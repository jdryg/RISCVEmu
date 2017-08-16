#ifndef HDD_H
#define HDD_H

#include <stdint.h>

#define HDD_SUCCESS                        0
#define HDD_ERROR_NOT_CONNECTED            1
#define HDD_ERROR_NO_MBR                   2
#define HDD_ERROR_NO_PARTITIONS            3
#define HDD_ERROR_INVALID_PARTITION        4
#define HDD_ERROR_ACTIVATE_EMPTY_PARTITION 5
#define HDD_ERROR_NO_ACTIVE_PARTITION      6
#define HDD_ERROR_NO_BOOT_SECTOR           7
#define HDD_ERROR_INIT_PARTITION           8
#define HDD_ERROR_UNSUPPORTED_FS           9

#define HDD_MAX_PARTITIONS 4

typedef struct PartitionTableEntry_t
{
	uint8_t m_Status;
	uint8_t m_FirstHead;
	uint16_t m_FirstSector : 5;
	uint16_t m_FirstCylinder : 11;
	uint8_t m_PartitionType;
	uint8_t m_LastHead;
	uint16_t m_LastSector : 5;
	uint16_t m_LastCylinder : 11;
	uint32_t m_FirstSectorLBA;
	uint32_t m_NumSectors;
} __attribute__((packed)) PartitionTableEntry;

// https://staff.washington.edu/dittrich/misc/fatgen103.pdf
typedef struct BIOSParamBlock_t
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
} __attribute__((packed)) BIOSParamBlock;

typedef struct FATPartitionInfo_t
{
	uint32_t m_NumRootDirSectors;
	uint32_t m_FATSize;
	uint32_t m_TotalSectors;
	uint32_t m_NumDataSectors;
	uint32_t m_NumClusters;
	uint32_t m_FATType;
} FATPartitionInfo;

typedef struct HDD_t
{
	uint32_t m_BaseAddr;
	PartitionTableEntry m_PTE[HDD_MAX_PARTITIONS];
	FATPartitionInfo m_FAT[HDD_MAX_PARTITIONS];
	uint32_t m_NumPartitions;

	void (*readSector)(struct HDD_t* hdd, uint32_t lba, uint8_t* sector);
	void (*writeSector)(struct HDD_t* hdd, uint32_t lba, const uint8_t* sector);
} HDD;

int hddInit(HDD* hdd, uint32_t baseAddr);
uint32_t hddGetNumPartitions(HDD* hdd);
uint32_t hddGetPartitionSize(HDD* hdd, uint32_t id);

#endif
