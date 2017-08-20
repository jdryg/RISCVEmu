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

struct PartitionTableEntry
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
} __attribute__((packed));

struct HDD
{
	uint32_t m_BaseAddr;
	struct PartitionTableEntry m_PTE[HDD_MAX_PARTITIONS];
	uint32_t m_NumPartitions;
};

int hddInit(struct HDD* hdd, uint32_t baseAddr);
void hddReadSector(struct HDD* hdd, uint32_t lba, uint8_t* sector);
void hddWriteSector(struct HDD* hdd, uint32_t lba, const uint8_t* sector);
uint32_t hddGetNumPartitions(struct HDD* hdd);
uint32_t hddGetPartitionSize(struct HDD* hdd, uint32_t id);
struct PartitionTableEntry* hddGetPartitionTableEntry(struct HDD* hdd, uint32_t id);

#endif
