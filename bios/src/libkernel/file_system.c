#include "file_system.h"
#include "devices/hdd.h"
#include "libkernel/malloc.h"
#include "libkernel/memory.h"
#include "libkernel/string.h"
#include "libkernel/kernel.h"

#define FAT_TYPE_FAT12 0
#define FAT_TYPE_FAT16 1
#define FAT_TYPE_FAT32 2

#define ATTR_LONG_NAME       (ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID)
#define ATTR_LONG_NAME_MASK  (ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID | ATTR_DIRECTORY | ATTR_ARCHIVE)

#define LONG_ENTRY_ORDER_MASK 0x3F
#define LAST_LONG_ENTRY       0x40

// https://staff.washington.edu/dittrich/misc/fatgen103.pdf
typedef struct BIOSParamBlock
{
	uint8_t m_JmpBoot[3];
	uint8_t m_OEMName[8];
	uint16_t m_BytesPerSector;
	uint8_t m_SectorsPerCluster;
	uint16_t m_ReservedSectorCount;
	uint8_t m_NumFATs;
	uint16_t m_RootEntriesCount;
	uint16_t m_TotalSectors16;
	uint8_t m_Media;
	uint16_t m_FATSize16;
	uint16_t m_SectorsPerTrack;
	uint16_t m_NumHeads;
	uint32_t m_HiddenSectors;
	uint32_t m_TotalSectors32;

	union FAT 
	{
		struct FAT16
		{
			uint8_t m_DriveNumber;
			uint8_t m_Reserved1;
			uint8_t m_BootSig;
			uint32_t m_VolID;
			uint8_t m_VolLab[11];
			uint8_t m_FileSysType[8];
		} FAT16;

		struct FAT32
		{
			uint32_t m_FATSize32;
			uint16_t m_ExtFlags;
			uint16_t m_FSVer;
			uint32_t m_RootClus;
			uint16_t m_FSInfo;
			uint16_t m_BkBootSec;
			uint8_t m_Reserved[8];
			uint8_t m_DriveNumber;
			uint8_t m_Reserved1;
			uint8_t m_BootSig;
			uint32_t m_VolID;
			uint8_t m_VolLab[11];
			uint8_t m_FileSysType[8];
		} FAT32;
	} FAT;
} __attribute__((packed)) BIOSParamBlock;

typedef struct LongDirectoryEntry
{
	uint8_t m_Order;
	uint16_t m_Name1[5];
	uint8_t m_Attrs; // Must be ATTR_LONG_NAME
	uint8_t m_Type;
	uint8_t m_Checksum;
	uint16_t m_Name2[6];
	uint16_t m_FirstClusterLow; // Should be 0
	uint16_t m_Name3[2];
} __attribute__((packed)) LongDirectoryEntry;

struct FileSystem
{
	// Constants
	HDD* m_HDD;
	PartitionTableEntry m_PTE;
	uint32_t m_FATType;
	uint32_t m_FATSize;
	uint32_t m_FirstRootDirSector_abs;
	uint32_t m_NumRootDirSectors;
	uint32_t m_FirstDataSector_abs;
	uint32_t m_NumDataSectors;
	uint32_t m_TotalSectors;
	uint32_t m_NumClusters;
	uint32_t m_NumSectorsPerCluster;

	// Run-time
	uint32_t m_FirstCWDSector_abs;
	uint8_t m_CachedSectorData[512];
	uint32_t m_CachedSectorID;
};

struct FileSystemDir
{
	// NOTE: The data returned by readdir() may be overwritten by subsequent calls to readdir() for the same directory stream.
	// https://linux.die.net/man/3/readdir
	FileSystemDirEnt m_CurDirEntry;
	uint32_t m_FirstSector_abs;
	uint32_t m_NextDirEntryID;
};

struct FileSystemFile
{
	FileSystemDirEnt m_FSDirEntry;
	uint8_t m_Buffer[512]; // holds 1 sector
	uint32_t m_BufferPos;
	uint32_t m_FilePos;
};

int _getDirectoryEntryFromPath(FileSystem* fs, const char* path, FileSystemDirEnt* fsDirEntry);
uint32_t _clusterNumberToDataSector(const FileSystem* fs, uint32_t clusterNumber);

void dirEntFilename83(const DirectoryEntry* de, char* fn)
{
	const char* name = (const char*)de->m_Filename;
	const char* ext = (const char*)de->m_Extension;

	uint32_t l = 8;
	if (name[0] == 0x05) {
		*fn++ = (uint8_t)0xE5;
		name++;
		--l;
	}

	for (uint32_t i = 0; i < l; ++i) {
		if (*name == ' ') {
			break;
		}

		*fn++ = *name++;
	}

	if (*ext != ' ') {
		*fn++ = '.';
		*fn++ = *ext++;
		*fn++ = *ext++;
		*fn++ = *ext++;
	}

	*fn = '\0';
}

FileSystem* fsInit(HDD* hdd, PartitionTableEntry* pte)
{
	// Read the first partition sector.
	uint8_t bootSector[512];
	hddReadSector(hdd, pte->m_FirstSectorLBA, bootSector);

	// Is this a valid boot sector?
	// NOTE: The locations of the values should be dependent on the sector size which 
	// I assume it'll always be 512 bytes.
	if(bootSector[510] != 0x55 || bootSector[511] != 0xAA) {
		return 0;
	}

	BIOSParamBlock* bpb = (BIOSParamBlock*)&bootSector[0];
	if (!(bpb->m_JmpBoot[0] == 0xE9 || (bpb->m_JmpBoot[0] == 0xEB && bpb->m_JmpBoot[2] == 0x90)) ||
		bpb->m_BytesPerSector != 512)
	{
		return 0;
	}

	// FAT type determination (see pdf).
	uint32_t rootDirSectors = ((bpb->m_RootEntriesCount * 32) + (bpb->m_BytesPerSector - 1)) / bpb->m_BytesPerSector;
	uint32_t FATsz = bpb->m_FATSize16 != 0 ? bpb->m_FATSize16 : bpb->FAT.FAT32.m_FATSize32;
	uint32_t totalSec = bpb->m_TotalSectors16 != 0 ? bpb->m_TotalSectors16 : bpb->m_TotalSectors32;
	uint32_t dataSec = totalSec - (bpb->m_ReservedSectorCount + (bpb->m_NumFATs * FATsz) + rootDirSectors);
	uint32_t countOfClusters = dataSec / bpb->m_SectorsPerCluster;

	uint32_t fatType = ~0;
	if (countOfClusters < 4085) {
		fatType = FAT_TYPE_FAT12;
	} else if (countOfClusters < 65525) {
		fatType = FAT_TYPE_FAT16;
	} else {
		fatType = FAT_TYPE_FAT32;
	}

	if (fatType != FAT_TYPE_FAT16) {
		return 0; // Cannot handle any other type atm.
	}

	uint32_t firstRootDirSectorRel = bpb->m_ReservedSectorCount + (bpb->m_NumFATs * FATsz);
	uint32_t firstRootDirSectorAbs = pte->m_FirstSectorLBA + firstRootDirSectorRel;
	uint32_t firstDataSectorRel = bpb->m_ReservedSectorCount + (bpb->m_NumFATs * FATsz) + rootDirSectors;
	uint32_t firstDataSectorAbs = pte->m_FirstSectorLBA + firstDataSectorRel;

	FileSystem* fs = (FileSystem*)kmalloc(sizeof(FileSystem));
	fs->m_HDD = hdd;
	kmemcpy(&fs->m_PTE, pte, sizeof(PartitionTableEntry));
	fs->m_FATType = fatType;
	fs->m_FATSize = FATsz;
	fs->m_FirstRootDirSector_abs = firstRootDirSectorAbs;
	fs->m_NumRootDirSectors = rootDirSectors;
	fs->m_FirstDataSector_abs = firstDataSectorAbs;
	fs->m_NumDataSectors = dataSec;
	fs->m_TotalSectors = totalSec;
	fs->m_NumClusters = countOfClusters;
	fs->m_NumSectorsPerCluster = bpb->m_SectorsPerCluster;

	// Set the current working directory to be the root
	fs->m_FirstCWDSector_abs = firstRootDirSectorAbs;
	fs->m_CachedSectorID = ~0u;

    return fs;
}

void fsShutdown(FileSystem* fs)
{
	kfree(fs);
}

uint8_t* fsReadSector(FileSystem* fs, uint32_t sector_abs)
{
	if (fs->m_CachedSectorID != sector_abs) {
		hddReadSector(fs->m_HDD, sector_abs, &fs->m_CachedSectorData[0]);
		fs->m_CachedSectorID = sector_abs;
	}

	return fs->m_CachedSectorData;
}

FileSystemDir* fsOpenDir(FileSystem* fs, const char* path)
{
	// TODO: On error set errno and return null. http://man7.org/linux/man-pages/man3/opendir.3.html
	FileSystemDirEnt fsde;
	if(!_getDirectoryEntryFromPath(fs, path, &fsde)) {
		return 0;
	}

	FileSystemDir* dir = (FileSystemDir*)kmalloc(sizeof(FileSystemDir));
	kmemset(&dir->m_CurDirEntry, 0, sizeof(FileSystemDirEnt));
	dir->m_FirstSector_abs = _clusterNumberToDataSector(fs, fsde.m_DirEntry.m_StartClusterNumber);
	dir->m_NextDirEntryID = 0;
	
	return dir;
}

int fsCloseDir(FileSystem* fs, FileSystemDir* dir)
{
	kfree(dir);
	// TODO: On error set errno. http://man7.org/linux/man-pages/man3/closedir.3.html
	return 0;
}

FileSystemDirEnt* fsReadDir(FileSystem* fs, FileSystemDir* dir)
{
	FileSystemDirEnt* dirEnt = &dir->m_CurDirEntry;
	dirEnt->m_FilenameLong[0] = 0;
	dirEnt->m_DirEntryID = dir->m_NextDirEntryID;
	dirEnt->m_ParentDirSector_abs = dir->m_FirstSector_abs;

	// Read the directory's sector
	const uint32_t sectorSize = 512;
	const uint32_t numEntriesPerSector = sectorSize / sizeof(DirectoryEntry);

	while (1) {
		const uint32_t relSectorID = dir->m_NextDirEntryID / numEntriesPerSector;
		const uint32_t relDirEntryID = dir->m_NextDirEntryID % numEntriesPerSector;
		uint8_t* sectorData = fsReadSector(fs, dir->m_FirstSector_abs + relSectorID); // Cache

		DirectoryEntry* de = (DirectoryEntry*)&sectorData[relDirEntryID * sizeof(DirectoryEntry)];
		if (de->m_Filename[0] == 0xE5) {
			// DirectoryEntry is free. Continue to the next one.
			++dir->m_NextDirEntryID;
			continue;
		} else if (de->m_Filename[0] == 0x00) {
			// DirectoryEntry is free and there's no other DEs after that
			break;
		}

		// Check for long name entries first
		if ((de->m_Attrs & ATTR_LONG_NAME_MASK) == ATTR_LONG_NAME) {
			LongDirectoryEntry* lde = (LongDirectoryEntry*)de;

			const uint32_t startID = ((lde->m_Order & LONG_ENTRY_ORDER_MASK) - 1) * 13;
			char* longFilenamePtr = &dirEnt->m_FilenameLong[startID];

			for (uint32_t i = 0; i < 5; ++i) { *longFilenamePtr++ = (uint8_t)lde->m_Name1[i]; }
			for (uint32_t i = 0; i < 6; ++i) { *longFilenamePtr++ = (uint8_t)lde->m_Name2[i]; }
			for (uint32_t i = 0; i < 2; ++i) { *longFilenamePtr++ = (uint8_t)lde->m_Name3[i]; }

			if (lde->m_Order & LAST_LONG_ENTRY) {
				// Null-terminate filename because:
				// A name that fits exactly in a n long directory entries (i.e. is an integer multiple of 13) is 
				// not NUL terminated and not padded with 0xFFFFs.
				*longFilenamePtr = '\0';
			}

			++dir->m_NextDirEntryID;
			continue;
		} else {
			if (de->m_Attrs & ATTR_VOLUME_ID) {
				// TODO: Filename holds the Volume Label in case I need it somewhere.
				++dir->m_NextDirEntryID;
				continue;
			}

			if (dirEnt->m_FilenameLong[0] == '\0') {
				// No long filename. Set the short filename as the long filename of the file.
				dirEntFilename83(de, dirEnt->m_FilenameLong);
			}
		}

		kmemcpy(&dirEnt->m_DirEntry, de, sizeof(DirectoryEntry));

		++dir->m_NextDirEntryID;

		return dirEnt;
	}

	return 0;
}

int fsChangeDir(FileSystem* fs, const char* path)
{
	// Find the directory entry for the path...
	FileSystemDirEnt fsde;
	if(!_getDirectoryEntryFromPath(fs, path, &fsde)) {
		return -1;
	}

	// Is it actually a directory?
	if(!(fsde.m_DirEntry.m_Attrs & ATTR_DIRECTORY)) {
		return -1;
	}

	// Calculate first sector of directory.
	const uint32_t clustNum = fsde.m_DirEntry.m_StartClusterNumber;
	const uint32_t firstClusterSector_abs = _clusterNumberToDataSector(fs, fsde.m_DirEntry.m_StartClusterNumber);
	fs->m_FirstCWDSector_abs = firstClusterSector_abs;

	return 0;
}

FileSystemFile* fsOpenFile(FileSystem* fs, const char* filename, uint32_t flags)
{
	FileSystemDirEnt fsde;
	if(!_getDirectoryEntryFromPath(fs, filename, &fsde)) {
		return 0;
	}

	FileSystemFile* file = (FileSystemFile*)kmalloc(sizeof(FileSystemFile));
	kmemcpy(&file->m_FSDirEntry, &fsde, sizeof(FileSystemDirEnt));
	kmemset(&file->m_Buffer[0], 0, 512);
	file->m_FilePos = 0;
	file->m_BufferPos = 512; // force reading on next fsReadFile

	return file;
}

int fsCloseFile(FileSystem* fs, FileSystemFile* file)
{
	kfree(file);
}

int fsReadFile(FileSystem* fs, FileSystemFile* file, void* buf, size_t len)
{
	if(fsEOF(fs, file)) {
		return 0;
	}

	uint8_t* dst = (uint8_t*)buf;

	// Copy the remaining data from file's buffer to buf.
	if(file->m_BufferPos < 512) {
		const uint32_t remainingLen = 512 - file->m_BufferPos;
		const uint32_t copyLen = remainingLen < len ? remainingLen : len;
		kmemcpy(dst, &file->m_Buffer[file->m_BufferPos], copyLen);

		dst += copyLen;
		len -= copyLen;
		file->m_BufferPos += copyLen;
		file->m_FilePos += copyLen;
	}

	while(len > 0) {
		// If we land here more bytes should be written to the output buffer
		// but the file's buffer doesn't have enough data. Read the next sector.
		uint32_t remainingLen = file->m_FSDirEntry.m_DirEntry.m_FileSize - file->m_FilePos;
		if(!remainingLen) {
			break;
		}

		remainingLen = remainingLen > 512 ? 512 : remainingLen;

		kassert((file->m_FilePos % 512) == 0, "Invalid file position");

		const uint32_t sector_rel = file->m_FilePos / 512;
		const uint32_t sector_abs = _clusterNumberToDataSector(fs, file->m_FSDirEntry.m_DirEntry.m_StartClusterNumber) + sector_rel;

		uint8_t* sectorData = fsReadSector(fs, sector_abs);
		kmemcpy(&file->m_Buffer[0], sectorData, remainingLen); // TODO: Avoid copying and use sector's data directly? fsReadSector() caches the last read sector

		// Now read from the buffer as above...
		const uint32_t copyLen = remainingLen < len ? remainingLen : len;
		kmemcpy(dst, &file->m_Buffer[0], copyLen);

		dst += copyLen;
		len -= copyLen;
		file->m_BufferPos = copyLen;
		file->m_FilePos += copyLen;
	}

	return (int)(dst - (uint8_t*)buf);
}

int fsEOF(FileSystem* fs, FileSystemFile* file)
{
	return file->m_FilePos == file->m_FSDirEntry.m_DirEntry.m_FileSize;
}

//////////////////////////////////////////////////////////////////////////
// Private functions...
//
// NOTE: FileSystem ptr should be const on this one since it doesn't make sense to imply that
// the internals of the fs will be affected when searching for a DirectoryEntry. Problem is that
// the current FileSystem acts as its own context with all run-time variables included (including
// the last read sector cache which is affected by fsReadSector()).
int _getDirectoryEntryFromPath(FileSystem* fs, const char* path, FileSystemDirEnt* fsDirEntry)
{
	const char* pathPtr = path;
	char filenameShort[13];
	char filenameLong[256];

	filenameShort[0] = 0;
	filenameLong[0] = 0;

	// Assume relative path.
	uint32_t sector = fs->m_FirstCWDSector_abs;
	if(*pathPtr == '/') {
		sector = fs->m_FirstRootDirSector_abs;
		++pathPtr;
		if(*pathPtr == '\0') {
			fsDirEntry->m_ParentDirSector_abs = ~0u;
			fsDirEntry->m_DirEntryID = ~0u;
			fsDirEntry->m_DirEntry.m_Attrs = ATTR_DIRECTORY;
			fsDirEntry->m_DirEntry.m_StartClusterNumber = 0;
			fsDirEntry->m_DirEntry.m_FileSize = 0;
			return 1;
		}
	} else {
		// Special cases of relative paths
		if(pathPtr[0] == '.') {
			// If the path is "."
			if(pathPtr[1] == '\0') {
				// and the CWD is the root dir
				if(fs->m_FirstCWDSector_abs == fs->m_FirstRootDirSector_abs) {
					fsDirEntry->m_ParentDirSector_abs = ~0u;
					fsDirEntry->m_DirEntryID = ~0u;
					fsDirEntry->m_DirEntry.m_Attrs = ATTR_DIRECTORY;
					fsDirEntry->m_DirEntry.m_StartClusterNumber = 0;
					fsDirEntry->m_DirEntry.m_FileSize = 0;
					return 1;
				}

				// Otherwise let the code below handle it.
			} else if(pathPtr[1] == '/') {
				// If the path starts with "./", skip it.
				pathPtr += 2;				
			}
		}
	}

	const uint32_t sectorSize = 512;
	const uint32_t numEntriesPerSector = sectorSize / sizeof(DirectoryEntry);

	while(1) {
		// Find the next slash in the path
		const char* nextSlash = kstrchr(pathPtr, '/');
		uint32_t pathFragLength = nextSlash ? nextSlash - pathPtr : kstrlen(pathPtr);

		// Find the DirectoryEntry corresponding to the current path fragment.
		int found = 0;
		uint32_t dirEntryID = 0;
		while(1) {
			const uint32_t relSectorID = dirEntryID / numEntriesPerSector;
			const uint32_t relDirEntryID = dirEntryID % numEntriesPerSector;

			uint8_t* sectorData = fsReadSector(fs, sector + relSectorID); // Cache
	
			const DirectoryEntry* de = (const DirectoryEntry*)&sectorData[relDirEntryID * sizeof(DirectoryEntry)];
			if (de->m_Filename[0] == 0xE5) {
				// DirectoryEntry is free. Continue to the next one.
				++dirEntryID;
				continue;
			} else if (de->m_Filename[0] == 0x00) {
				// DirectoryEntry is free and there's no other DEs after that
				break;
			}

			// Check for long name entries first
			if ((de->m_Attrs & ATTR_LONG_NAME_MASK) == ATTR_LONG_NAME) {
				const LongDirectoryEntry* lde = (const LongDirectoryEntry*)de;

				const uint32_t startID = ((lde->m_Order & LONG_ENTRY_ORDER_MASK) - 1) * 13;
				char* longFilenamePtr = &filenameLong[startID];

				for (uint32_t i = 0; i < 5; ++i) { *longFilenamePtr++ = (uint8_t)lde->m_Name1[i]; }
				for (uint32_t i = 0; i < 6; ++i) { *longFilenamePtr++ = (uint8_t)lde->m_Name2[i]; }
				for (uint32_t i = 0; i < 2; ++i) { *longFilenamePtr++ = (uint8_t)lde->m_Name3[i]; }

				if (lde->m_Order & LAST_LONG_ENTRY) {
					// Null-terminate filename because:
					// A name that fits exactly in a n long directory entries (i.e. is an integer multiple of 13) is 
					// not NUL terminated and not padded with 0xFFFFs.
					*longFilenamePtr = '\0';
				}

				++dirEntryID;
				continue;
			} else {
				if (de->m_Attrs & ATTR_VOLUME_ID) {
					++dirEntryID;
					continue;
				}

				dirEntFilename83(de, filenameShort);
			}

			if(!kstrncmp(filenameShort, pathPtr, pathFragLength) || !kstrncmp(filenameLong, pathPtr, pathFragLength)) {
				// The DirectoryEntry matching the specified path fragment has been found.
				// If this is the last fragment, return the entry's sector
				if(nextSlash == 0) {
					kmemcpy(&fsDirEntry->m_DirEntry, de, sizeof(DirectoryEntry));
					kmemcpy(&fsDirEntry->m_FilenameLong[0], &filenameLong[0], 256);
					fsDirEntry->m_DirEntryID = dirEntryID;
					fsDirEntry->m_ParentDirSector_abs = sector;
					return 1;
				} else {
					found = 1;
					sector = _clusterNumberToDataSector(fs, de->m_StartClusterNumber);
					break;
				}
			}

			filenameShort[0] = 0;
			filenameLong[0] = 0;
		
			++dirEntryID;
		}

		if(!found) {
			break;
		}

		pathPtr = nextSlash + 1;
	}

	return 0;
}

uint32_t _clusterNumberToDataSector(const FileSystem* fs, uint32_t clusterNumber)
{
	if(clusterNumber == 0) {
		return fs->m_FirstRootDirSector_abs;
	}

	kassert(clusterNumber >= 2, "Invalid cluster number");

	return ((clusterNumber - 2) * fs->m_NumSectorsPerCluster) + fs->m_FirstDataSector_abs;
}
