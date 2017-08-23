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

typedef struct PartitionTableEntry
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

typedef struct HDD
{
	PartitionTableEntry m_PTE[HDD_MAX_PARTITIONS];
	uint32_t m_NumPartitions;
	uint32_t m_BaseAddr;
} HDD;

int hddInit(HDD* hdd, uint32_t baseAddr);
void hddReadSector(HDD* hdd, uint32_t lba, uint8_t* sector);
void hddWriteSector(HDD* hdd, uint32_t lba, const uint8_t* sector);
uint32_t hddGetNumPartitions(HDD* hdd);
uint32_t hddGetPartitionSize(HDD* hdd, uint32_t id);
PartitionTableEntry* hddGetPartitionTableEntry(HDD* hdd, uint32_t id);

#endif
