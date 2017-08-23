#ifndef FILE_SYSTEM_H
#define FILE_SYSTEM_H

#include <stdint.h>
#include <stddef.h> // size_t

typedef struct HDD HDD;
typedef struct PartitionTableEntry PartitionTableEntry;

typedef struct FileSystem FileSystem;
typedef struct FileSystemDir FileSystemDir;
typedef struct FileSystemFile FileSystemFile;

#define ATTR_READ_ONLY       0x01
#define ATTR_HIDDEN          0x02
#define ATTR_SYSTEM          0x04
#define ATTR_VOLUME_ID       0x08
#define ATTR_DIRECTORY       0x10
#define ATTR_ARCHIVE         0x20

#define FILE_OPEN_READ       0x01
//#define FILE_OPEN_WRITE      0x02 // Not implemented yet (fs is read-only)
#define FILE_OPEN_BINARY     0x04

typedef struct DirectoryEntry
{
	uint8_t m_Filename[8];
	uint8_t m_Extension[3];
	uint8_t m_Attrs;
	uint8_t m_Reserved[10];
	uint16_t m_LastUpdateTime;
	uint16_t m_LastDateTime;
	uint16_t m_StartClusterNumber;
	uint32_t m_FileSize;
} __attribute__((packed)) DirectoryEntry;

typedef struct FileSystemDirEnt
{
	uint32_t m_ParentDirSector_abs;
	uint32_t m_DirEntryID;
	DirectoryEntry m_DirEntry;
	char m_FilenameLong[256];
} FileSystemDirEnt;

FileSystem* fsInit(HDD* hdd, PartitionTableEntry* pte);
void fsShutdown(FileSystem* fs);

FileSystemDir* fsOpenDir(FileSystem* fs, const char* path);
int fsCloseDir(FileSystem* fs, FileSystemDir* dir);
FileSystemDirEnt* fsReadDir(FileSystem* fs, FileSystemDir* dir);
int fsChangeDir(FileSystem* fs, const char* path);

FileSystemFile* fsOpenFile(FileSystem* fs, const char* filename, uint32_t flags);
int fsCloseFile(FileSystem* fs, FileSystemFile* file);
int fsReadFile(FileSystem* fs, FileSystemFile* file, void* buf, size_t len);
int fsEOF(FileSystem* fs, FileSystemFile* file);

#endif
