#include "hdd.h"
#include "exception_handler.h" // setTrapHandler()
#include "hal.h" // halXXX()
#include "libkernel/memory.h" // kmemset()/kmemcpy()

#define HDD_REG_DATA            0
#define HDD_REG_ERROR_INFO      1
#define HDD_REG_SECTOR_COUNT    2
#define HDD_REG_LBA_LOW         3
#define HDD_REG_LBA_MID         4
#define HDD_REG_LBA_HIGH        5
#define HDD_REG_DRIVE           6
#define HDD_REG_COMMAND_STATUS  7
#define HDD_NUM_REGS            8

#define HDD_CMD_READ_SECTORS    0x20
#define HDD_CMD_WRITE_SECTORS   0x30
#define HDD_CMD_CACHE_FLUSH     0xE7

#define HDD_MBR_PARTITION_TABLE_OFFSET 446

#define FAT_TYPE_UNKNOWN  0
#define FAT_TYPE_FAT12    1
#define FAT_TYPE_FAT16    2
#define FAT_TYPE_FAT32    3

static volatile int g_HDDTrapTriggered = 0;

static uintptr_t hddHandleAccessFault(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
	g_HDDTrapTriggered = 1;
	return epc + 4;
}

inline uint8_t hddReadReg8(uint32_t baseAddr, uint32_t reg)
{
	return halReadReg8(baseAddr + (reg << 2));
}

inline uint16_t hddReadReg16(uint32_t baseAddr, uint32_t reg)
{
	return halReadReg16(baseAddr + (reg << 2));
}

inline void hddWriteReg8(uint32_t baseAddr, uint32_t reg, uint8_t value)
{
	halWriteReg8(baseAddr + (reg << 2), value);
}

int hddIsConnected(uint32_t baseAddr)
{
	g_HDDTrapTriggered = 0;
	
	// Change trap handler to catch any load faults
	TrapHandler oldLoadAccessFaultHandler = setTrapHandler(MCAUSE_LOAD_ACCESS_FAULT, hddHandleAccessFault);
	
	// Try to read the status of the hdd
	volatile uint8_t status = hddReadReg8(baseAddr, HDD_REG_COMMAND_STATUS);
	
	// Restore previous trap handler
	setTrapHandler(MCAUSE_LOAD_ACCESS_FAULT, oldLoadAccessFaultHandler);

	return g_HDDTrapTriggered == 0 ? 1 : 0;
}

void hddReadSector(HDD* hdd, uint32_t lba, uint8_t* sectorData)
{
	const uint32_t baseAddr = hdd->m_BaseAddr;

	uint16_t* dst = (uint16_t*)&sectorData[0];
	hddWriteReg8(baseAddr, HDD_REG_DRIVE, lba >> 24);                     // LBA[24:27]
	hddWriteReg8(baseAddr, HDD_REG_SECTOR_COUNT, 1);                      // sector count
	hddWriteReg8(baseAddr, HDD_REG_LBA_LOW, lba & 0x000000FF);            // LBA[0:7]
	hddWriteReg8(baseAddr, HDD_REG_LBA_MID, (lba >> 8) & 0x000000FF);     // LBA[8:15]
	hddWriteReg8(baseAddr, HDD_REG_LBA_HIGH, (lba >> 16) & 0x000000FF);   // LBA[16:23]
	hddWriteReg8(baseAddr, HDD_REG_COMMAND_STATUS, HDD_CMD_READ_SECTORS); // READ SECTORS command

	// Wait for the DRQ status bit.
	while (!(hddReadReg8(baseAddr, HDD_REG_COMMAND_STATUS) & 0x08));

	for (uint32_t i = 0; i < 256; ++i) {
		uint16_t halfWord = hddReadReg16(baseAddr, HDD_REG_DATA);
		*dst++ = halfWord;
	}
}

int hddReadMBR(HDD* hdd)
{
	uint8_t sector[512];
	hddReadSector(hdd, 0, sector);

	// Check if this actually an MBR
	if(sector[510] != 0x55 || sector[511] != 0xAA) {
		return HDD_ERROR_NO_MBR;
	}

	PartitionTableEntry* pte = (PartitionTableEntry*)&sector[HDD_MBR_PARTITION_TABLE_OFFSET];

	// Check which partitions are active by looking at their type.
	// TODO: Q: Is this the right way?
	uint32_t numPartitions = 0;
	for(uint32_t i = 0;i < HDD_MAX_PARTITIONS;++i) {
		if(pte[i].m_PartitionType != 0) {
			++numPartitions;
		}
	}

	if(numPartitions == 0) {
		return HDD_ERROR_NO_PARTITIONS;
	}

	kmemcpy(&hdd->m_PTE[0], pte, sizeof(PartitionTableEntry) * HDD_MAX_PARTITIONS);
	hdd->m_NumPartitions = numPartitions;

	return HDD_SUCCESS;
}

int hddInit(HDD* hdd, uint32_t baseAddr)
{
	if(!hddIsConnected(baseAddr)) {
		return HDD_ERROR_NOT_CONNECTED;
	}

	// Init struct with default values
	kmemset(hdd, 0, sizeof(HDD));
	hdd->m_BaseAddr = baseAddr;

	// Read MBR
	int err = hddReadMBR(hdd);
	if(err != HDD_SUCCESS) {
		return err;
	}

	return HDD_SUCCESS;
}

uint32_t hddGetNumPartitions(HDD* hdd)
{
	return hdd->m_NumPartitions;
}

uint32_t hddGetPartitionSize(HDD* hdd, uint32_t id)
{
	if(id >= hdd->m_NumPartitions) {
		return ~0u;
	}

	return hdd->m_PTE[id].m_NumSectors * 512;
}

PartitionTableEntry* hddGetPartitionTableEntry(HDD* hdd, uint32_t id)
{
	if(id >= hdd->m_NumPartitions) {
		return 0;
	}

	return &hdd->m_PTE[id];
}
