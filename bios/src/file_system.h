#ifndef FILE_SYSTEM_H
#define FILE_SYSTEM_H

#include <stdint.h>

struct HDD;
struct PartitionTableEntry;

struct FileSystem;
struct FileSystemDir;

#define ATTR_READ_ONLY       0x01
#define ATTR_HIDDEN          0x02
#define ATTR_SYSTEM          0x04
#define ATTR_VOLUME_ID       0x08
#define ATTR_DIRECTORY       0x10
#define ATTR_ARCHIVE         0x20

struct DirectoryEntry
{
	uint8_t m_Filename[8];
	uint8_t m_Extension[3];
	uint8_t m_Attrs;
	uint8_t m_Reserved[10];
	uint16_t m_LastUpdateTime;
	uint16_t m_LastDateTime;
	uint16_t m_StartClusterNumber;
	uint32_t m_FileSize;
} __attribute__((packed));

struct FileSystemDirEnt
{
	uint32_t m_FirstDirEntryID;
	struct DirectoryEntry m_DirEntry;
	char m_FilenameLong[256];
};

struct FileSystem* fsInit(struct HDD* hdd, struct PartitionTableEntry* pte);
void fsShutdown(struct FileSystem* fs);

struct FileSystemDir* fsOpenDir(struct FileSystem* fs, const char* path);
int fsCloseDir(struct FileSystem* fs, struct FileSystemDir* dir);
struct FileSystemDirEnt* fsReadDir(struct FileSystem* fs, struct FileSystemDir* dir);
int fsChangeDir(struct FileSystem* fs, const char* path);

#endif
