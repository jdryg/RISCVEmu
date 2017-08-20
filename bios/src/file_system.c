#include "file_system.h"
#include "devices/hdd.h"
#include "libkernel/malloc.h"
#include "libkernel/memory.h"
#include "libkernel/string.h"

#define FAT_TYPE_FAT12 0
#define FAT_TYPE_FAT16 1
#define FAT_TYPE_FAT32 2

#define ATTR_LONG_NAME       (ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID)
#define ATTR_LONG_NAME_MASK  (ATTR_READ_ONLY | ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME_ID | ATTR_DIRECTORY | ATTR_ARCHIVE)

#define LONG_ENTRY_ORDER_MASK 0x3F
#define LAST_LONG_ENTRY       0x40

// https://staff.washington.edu/dittrich/misc/fatgen103.pdf
struct BIOSParamBlock
{
	uint8_t m_JmpBoot[3]; // 0xE9 0xXX 0xXX
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
} __attribute__((packed));

struct LongDirectoryEntry
{
	uint8_t m_Order;
	uint16_t m_Name1[5];
	uint8_t m_Attrs; // Must be ATTR_LONG_NAME
	uint8_t m_Type;
	uint8_t m_Checksum;
	uint16_t m_Name2[6];
	uint16_t m_FirstClusterLow; // Should be 0
	uint16_t m_Name3[2];
} __attribute__((packed));

struct FileSystem
{
	// Constants
	struct HDD* m_HDD;
	struct PartitionTableEntry m_PTE;
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
	struct FileSystemDirEnt m_CurDirEntry;
	uint32_t m_FirstSector_abs;
	uint32_t m_NextDirEntryID;
};

void dirEntFilename83(const struct DirectoryEntry* de, char* fn)
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

struct FileSystem* fsInit(struct HDD* hdd, struct PartitionTableEntry* pte)
{
	// Read the first partition sector.
	uint8_t bootSector[512];
	hddReadSector(hdd, pte->m_FirstSectorLBA, bootSector);

	struct BIOSParamBlock* bpb = (struct BIOSParamBlock*)&bootSector[0];

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

	struct FileSystem* fs = (struct FileSystem*)kmalloc(sizeof(struct FileSystem));
	fs->m_HDD = hdd;
	kmemcpy(&fs->m_PTE, pte, sizeof(struct PartitionTableEntry));
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

uint8_t* fsReadSector(struct FileSystem* fs, uint32_t sector_abs)
{
	if (fs->m_CachedSectorID != sector_abs) {
		hddReadSector(fs->m_HDD, sector_abs, &fs->m_CachedSectorData[0]);
		fs->m_CachedSectorID = sector_abs;
	}

	return fs->m_CachedSectorData;
}

struct FileSystemDir* fsOpenDir(struct FileSystem* fs, const char* path)
{
	// TODO: Only opening the current working directory is supported atm.
	if (kstrcmp(path, ".")) {
		return 0;
	}

	struct FileSystemDir* dir = (struct FileSystemDir*)kmalloc(sizeof(struct FileSystemDir));
	kmemset(&dir->m_CurDirEntry, 0, sizeof(struct FileSystemDirEnt));
	dir->m_FirstSector_abs = fs->m_FirstCWDSector_abs;
	dir->m_NextDirEntryID = 0;

	// TODO: On error set errno and return null. http://man7.org/linux/man-pages/man3/opendir.3.html

	return dir;
}

int fsCloseDir(struct FileSystem* fs, struct FileSystemDir* dir)
{
	kfree(dir);
	// TODO: On error set errno. http://man7.org/linux/man-pages/man3/closedir.3.html
	return 0;
}

struct FileSystemDirEnt* fsReadDir(struct FileSystem* fs, struct FileSystemDir* dir)
{
	struct FileSystemDirEnt* dirEnt = &dir->m_CurDirEntry;
	dirEnt->m_FilenameLong[0] = 0;
	dirEnt->m_FirstDirEntryID = dir->m_NextDirEntryID;

	// Read the directory's sector
	const uint32_t sectorSize = 512;
	const uint32_t numEntriesPerSector = sectorSize / sizeof(struct DirectoryEntry);

	while (1) {
		const uint32_t relSectorID = dir->m_NextDirEntryID / numEntriesPerSector;
		const uint32_t relDirEntryID = dir->m_NextDirEntryID % numEntriesPerSector;
		uint8_t* sectorData = fsReadSector(fs, dir->m_FirstSector_abs + relSectorID); // Cache

		struct DirectoryEntry* de = (struct DirectoryEntry*)&sectorData[relDirEntryID * sizeof(struct DirectoryEntry)];
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
			struct LongDirectoryEntry* lde = (struct LongDirectoryEntry*)de;

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

		kmemcpy(&dirEnt->m_DirEntry, de, sizeof(struct DirectoryEntry));

		++dir->m_NextDirEntryID;

		return dirEnt;
	}

	return 0;
}

int fsChangeDir(struct FileSystem* fs, const char* path)
{
	// TODO: Only paths relative to the cwd are allowed atm.
	const char* pathPtr = path;
	if (pathPtr[0] != '.') {
		return -1;
	}
	pathPtr = kstrchr(pathPtr, '/');
	if (!pathPtr) {
		return 0; // Already there.
	}
	++pathPtr; // skip '/'

	// Keep the actual cwd in case something goes wrong.
	const uint32_t cwdSector_abs = fs->m_FirstCWDSector_abs;

	// Scan the path one folder at a time and change the cwd.
	while (1) {
		const char* nextSlash = kstrchr(pathPtr, '/');
		const uint32_t folderNameLen = nextSlash ? (uint32_t)(nextSlash - pathPtr) : (uint32_t)kstrlen(pathPtr);

		struct FileSystemDir* cwd = fsOpenDir(fs, ".");
		if (!cwd) {
			fs->m_FirstCWDSector_abs = cwdSector_abs;
			return -1;
		}

		int found = 0;
        struct FileSystemDirEnt subfolderDirEnt;
        kmemset(&subfolderDirEnt, 0, sizeof(struct FileSystemDirEnt));

		struct FileSystemDirEnt* fsde;
		while ((fsde = fsReadDir(fs, cwd)) != 0) {
			const uint8_t attrs = fsde->m_DirEntry.m_Attrs;
			if (attrs & ATTR_DIRECTORY) {
				if (!kstrncmp(fsde->m_FilenameLong, pathPtr, folderNameLen)) {
					kmemcpy(&subfolderDirEnt, fsde, sizeof(struct FileSystemDirEnt));
					found = 1;
					break;
				}
			}
		}

		fsCloseDir(fs, cwd);

		if (!found) {
			fs->m_FirstCWDSector_abs = cwdSector_abs;
			return -1;
		}

		// fsde holds the DirectoryEntry for the subfolder.
		const uint32_t clustNum = subfolderDirEnt.m_DirEntry.m_StartClusterNumber;
		const uint32_t firstClusterSector_abs = clustNum == 0 ? fs->m_FirstRootDirSector_abs : ((clustNum - 2) * fs->m_NumSectorsPerCluster) + fs->m_FirstDataSector_abs;
		fs->m_FirstCWDSector_abs = firstClusterSector_abs;

		if (!nextSlash) {
			break;
		}

		pathPtr = nextSlash;
	}

	return 0;
}
