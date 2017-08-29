#include "memory_map.h"
#include "../debug.h"
#include <malloc.h>
#include <stdio.h>

namespace riscv
{
#define DEV_FLAGS_RAM  0x00000001
#define DEV_FLAGS_ROM  0x00000002
#define DEV_FLAGS_UART 0x00000004
#define DEV_FLAGS_VHD  0x00000008

#define DEV_FLAGS_MEMORY (DEV_FLAGS_RAM | DEV_FLAGS_ROM)

struct DeviceDesc
{
	Device* m_Dev;
	uint32_t m_StartAddr;
	uint32_t m_EndAddr;
};

struct MemoryMap
{
	DeviceDesc* m_Devices;
	uint32_t m_NumDevices;
};

MemoryMap* mmCreate()
{
	MemoryMap* mm = (MemoryMap*)malloc(sizeof(MemoryMap));
	mm->m_Devices = nullptr;
	mm->m_NumDevices = 0;

	return mm;
}

void mmDestroy(MemoryMap* mm)
{
	const uint32_t nd = mm->m_NumDevices;
	for (uint32_t i = 0; i < nd; ++i) {
		device::destroy(mm->m_Devices[i].m_Dev);
	}

	free(mm->m_Devices);
	free(mm);
}

void mmMapDevice(MemoryMap* mm, Device* dev, uint32_t baseAddr, uint32_t size)
{
	++mm->m_NumDevices;
	mm->m_Devices = (DeviceDesc*)realloc(mm->m_Devices, sizeof(DeviceDesc) * mm->m_NumDevices);

	DeviceDesc* dd = &mm->m_Devices[mm->m_NumDevices - 1];
	dd->m_Dev = dev;
	dd->m_StartAddr = baseAddr;
	dd->m_EndAddr = baseAddr + size - 1;
}

uint32_t mmGetNumDevices(const MemoryMap* mm)
{
	return mm->m_NumDevices;
}

uint32_t mmGetDeviceBaseAddr(const MemoryMap* mm, uint32_t devID)
{
	RISCV_CHECK(devID < mm->m_NumDevices, "Invalid device id");
	return mm->m_Devices[devID].m_StartAddr;
}

Device* mmGetDeviceByID(MemoryMap* mm, uint32_t devID)
{
	RISCV_CHECK(devID < mm->m_NumDevices, "Invalid device id");
	return mm->m_Devices[devID].m_Dev;
}

bool mmRead(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t& val)
{
	const uint32_t numDevices = mm->m_NumDevices;
	DeviceDesc* dd = mm->m_Devices;
	for (uint32_t i = 0; i < numDevices; ++i, ++dd) {
		if (addr >= dd->m_StartAddr && addr <= dd->m_EndAddr) {
			return dd->m_Dev->read(dd->m_Dev, addr - dd->m_StartAddr, byteMask, val);
		}
	}

	return false;
}

bool mmWrite(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t val)
{
	const uint32_t numDevices = mm->m_NumDevices;
	DeviceDesc* dd = mm->m_Devices;
	for (uint32_t i = 0; i < numDevices; ++i, ++dd) {
		if (addr >= dd->m_StartAddr && addr <= dd->m_EndAddr) {
			return dd->m_Dev->write(dd->m_Dev, addr - dd->m_StartAddr, byteMask, val);
		}
	}

	return false;
}

bool mmGet(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t& val)
{
	const uint32_t numDevices = mm->m_NumDevices;
	DeviceDesc* dd = mm->m_Devices;
	for (uint32_t i = 0; i < numDevices; ++i, ++dd) {
		if (addr >= dd->m_StartAddr && addr <= dd->m_EndAddr) {
			val = dd->m_Dev->get(dd->m_Dev, addr - dd->m_StartAddr, byteMask);
			return true;
		}
	}

	return false;
}

namespace device
{
void vhdClose(Device* dev);

void destroy(Device* dev)
{
	if (dev->m_Flags & DEV_FLAGS_VHD) {
		vhdClose(dev);
	}

	free(dev);
}

bool isMemory(const Device* dev)
{
	return (dev->m_Flags & DEV_FLAGS_MEMORY) != 0;
}

// Devices
struct Memory : public Device
{
	uint8_t* m_Data;
	uint32_t m_Size;
};

uint32_t memGetSize(const Device* dev)
{
	RISCV_CHECK(dev->m_Flags & DEV_FLAGS_MEMORY, "Not a memory device");
	Memory* mem = (Memory*)dev;
	return mem->m_Size;
}

uint8_t* memGetDataPtr(Device* dev)
{
	RISCV_CHECK(dev->m_Flags & DEV_FLAGS_MEMORY, "Not a memory device");
	Memory* mem = (Memory*)dev;
	return mem->m_Data;
}

bool memIsReadOnly(const Device* dev)
{
	RISCV_CHECK(dev->m_Flags & DEV_FLAGS_MEMORY, "Not a memory device");
	return (dev->m_Flags & DEV_FLAGS_ROM) != 0;
}

// RAM
bool ramRead(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t& val)
{
	Memory* ram = (Memory*)dev;

	RISCV_CHECK(relAddr < ram->m_Size, "Invalid RAM relative address %08Xh. RAM size = %08Xh", relAddr, ram->m_Size);

	val = *(uint32_t*)&ram->m_Data[relAddr];
	val &= byteMask;
	return true;
}

bool ramWrite(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val)
{
	Memory* ram = (Memory*)dev;

	RISCV_CHECK(relAddr < ram->m_Size, "Invalid RAM relative address %08Xh. RAM size = %08Xh", relAddr, ram->m_Size);

	uint32_t* wordPtr = (uint32_t*)&ram->m_Data[relAddr];

	uint32_t oldVal = *wordPtr;
	*wordPtr = (val & byteMask) | (oldVal & (~byteMask));

	return true;
}

uint32_t ramGet(Device* dev, uint32_t relAddr, uint32_t byteMask)
{
	Memory* ram = (Memory*)dev;

	if (relAddr < ram->m_Size) {
		uint32_t val = *(uint32_t*)&ram->m_Data[relAddr];
		return val & byteMask;
	}

	return 0xbaadf00d;
}

Device* ramCreate(uint32_t size)
{
	uint8_t* ramData = (uint8_t*)malloc(sizeof(Memory) + size);
	if (!ramData) {
		return nullptr;
	}

	Memory* ram = (Memory*)ramData;
	ram->m_Flags = DEV_FLAGS_RAM;
	ram->read = ramRead;
	ram->write = ramWrite;
	ram->get = ramGet;
	ram->m_Data = ramData + sizeof(Memory);
	ram->m_Size = size;

	// NOTE: Don't initialize RAM. The BIOS/kernel should handle zero initialization
	// of all the sections needed to be initialized.
//	bx::memSet(ram->m_Data, 0, size);

	return ram;
}

// ROM
bool romRead(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t& val)
{
	Memory* rom = (Memory*)dev;

	RISCV_CHECK(relAddr < rom->m_Size, "Invalid ROM relative address %08Xh. ROM size = %08Xh", relAddr, rom->m_Size);

	val = *(uint32_t*)&rom->m_Data[relAddr];
	val &= byteMask;

	return true;
}

bool romWrite(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val)
{
	BX_UNUSED(dev, relAddr, byteMask, val);
	return false;
}

uint32_t romGet(Device* dev, uint32_t relAddr, uint32_t byteMask)
{
	Memory* rom = (Memory*)dev;

	if (relAddr < rom->m_Size) {
		uint32_t val = *(uint32_t*)&rom->m_Data[relAddr];
		return val & byteMask;
	}

	return 0xbaadf00d;
}

Device* romCreate(uint32_t size, const uint8_t* data, uint32_t dataSize)
{
	RISCV_CHECK(dataSize <= size, "ROM: Invalid data size (%u > %u)", dataSize, size);

	uint8_t* romData = (uint8_t*)malloc(sizeof(Memory) + size);
	if (!romData) {
		return nullptr;
	}

	Memory* rom = (Memory*)romData;
	rom->m_Flags = DEV_FLAGS_ROM;
	rom->read = romRead;
	rom->write = romWrite;
	rom->get = romGet;
	rom->m_Data = romData + sizeof(Memory);
	rom->m_Size = size;

	bx::memCopy(rom->m_Data, data, dataSize);
	bx::memSet(&rom->m_Data[dataSize], 0, size - dataSize);

	return rom;
}

// UART
#define UART_REG_TXDATA 0
#define UART_REG_RXDATA 1
#define UART_REG_STATUS 2
#define UART_NUM_REGS   3

#define UART_STATUS_TXREADY 0x01
#define UART_STATUS_RXFULL  0x02

struct UART : public Device
{
	uint32_t m_Regs[UART_NUM_REGS];
};

bool uartRead(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t& val)
{
	UART* uart = (UART*)dev;
	
	const uint32_t reg = relAddr >> 2;
	RISCV_CHECK(reg < UART_NUM_REGS, "Invalid UART relative address %08Xh", relAddr);
	RISCV_CHECK(reg != UART_REG_TXDATA, "UART: Tried to read TXDATA register");

	if (reg == UART_REG_RXDATA) {
		RISCV_CHECK(uart->m_Regs[UART_REG_STATUS] & UART_STATUS_RXFULL, "UART: Tried to read data with RXFULL=0");

		uart->m_Regs[UART_REG_STATUS] &= ~UART_STATUS_RXFULL;
	}

	val = uart->m_Regs[reg] & 0x000000FF; // 8-bit registers
	val &= byteMask;
	return true;
}

bool uartWrite(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val)
{
	UART* uart = (UART*)dev;

	const uint32_t reg = relAddr >> 2;
	RISCV_CHECK(reg < UART_NUM_REGS, "Invalid UART relative address %08Xh", relAddr);
	RISCV_CHECK(reg != UART_REG_RXDATA, "UART: Tried to write RXDATA register");

	if (reg == UART_REG_TXDATA) {
		RISCV_CHECK(uart->m_Regs[UART_REG_STATUS] & UART_STATUS_TXREADY, "UART: Tried to send data with TXREADY=0");

		uart->m_Regs[UART_REG_STATUS] &= ~UART_STATUS_TXREADY;
	}

	uart->m_Regs[reg] = ((val & byteMask) & 0x000000FF);

	return true;
}

uint32_t uartGet(Device* dev, uint32_t relAddr, uint32_t byteMask)
{
	UART* uart = (UART*)dev;

	const uint32_t reg = relAddr >> 2;
	if (reg < UART_NUM_REGS) {
		uint32_t val = uart->m_Regs[reg] & 0x000000FF; // 8-bit registers
		return val & byteMask;
	}

	return 0xbaadf00d;
}

bool uartTransmit(Device* dev, uint8_t& data)
{
	UART* uart = (UART*)dev;

	if (!(uart->m_Regs[UART_REG_STATUS] & UART_STATUS_TXREADY)) {
		data = (uint8_t)uart->m_Regs[UART_REG_TXDATA];
		uart->m_Regs[UART_REG_STATUS] |= UART_STATUS_TXREADY;

		return true;
	}

	return false;
}

bool uartReceive(Device* dev, uint8_t data)
{
	UART* uart = (UART*)dev;

	if (!(uart->m_Regs[UART_REG_STATUS] & UART_STATUS_RXFULL)) {
		uart->m_Regs[UART_REG_RXDATA] = data;
		uart->m_Regs[UART_REG_STATUS] |= UART_STATUS_RXFULL;

		return true;
	}

	return false;
}

Device* uartCreate()
{
	uint8_t* uartData = (uint8_t*)malloc(sizeof(UART));
	if (!uartData) {
		return nullptr;
	}

	UART* uart = (UART*)uartData;
	uart->m_Flags = DEV_FLAGS_UART;
	uart->read = uartRead;
	uart->write = uartWrite;
	uart->get = uartGet;
	uart->m_Regs[UART_REG_TXDATA] = 0;
	uart->m_Regs[UART_REG_RXDATA] = 0;
	uart->m_Regs[UART_REG_STATUS] = UART_STATUS_TXREADY;

	return uart;
}

// Virtual Hard Disk (vhd)
#define VHD_FEATURES_RESERVED   0x00000002
#define VHD_FILE_FORMAT_VERSION 0x00010000
#define VHD_DISK_TYPE_FIXED     0x00000002

// Loosely modeled around ATA (http://wiki.osdev.org/ATA_PIO_Mode)
// Assumes 28-bit LBA
#define VHD_REG_DATA            0
#define VHD_REG_ERROR_INFO      1
#define VHD_REG_SECTOR_COUNT    2
#define VHD_REG_LBA_LOW         3
#define VHD_REG_LBA_MID         4
#define VHD_REG_LBA_HIGH        5
#define VHD_REG_DRIVE           6
#define VHD_REG_COMMAND_STATUS  7
#define VHD_NUM_REGS            8

#define VHD_CMD_READ_SECTORS    0x20
#define VHD_CMD_WRITE_SECTORS   0x30
#define VHD_CMD_CACHE_FLUSH     0xE7

#define VHD_STATUS_RDY          0x40
#define VHD_STATUS_DRQ          0x08

struct VHDDiskGeometry
{
	uint16_t m_Cylinders;
	uint8_t m_Heads;
	uint8_t m_Sectors;
};

struct VHDFooter
{
	uint8_t m_Cookie[8];
	uint32_t m_Features;
	uint32_t m_FileFormatVersion;
	uint64_t m_DataOffset;
	uint32_t m_Timestamp;
	uint32_t m_CreatorApp;
	uint32_t m_CreatorVersion;
	uint32_t m_CreatorHostOS;
	uint64_t m_OriginalSize;
	uint64_t m_CurrentSize;
	VHDDiskGeometry m_DiskGeometry;
	uint32_t m_DiskType;
	uint32_t m_Checksum;
	uint8_t m_UniqueID[16];
	uint8_t m_SavedState;
	uint8_t m_Reserved[427];
};

struct VHD : public Device
{
	FILE* m_Handle;
	uint64_t m_FileSize;
	uint64_t m_Size;
	VHDFooter m_Footer;

	// Registers
	uint32_t m_LBA;
	uint32_t m_SectorCount;
	uint32_t m_Command;
	uint32_t m_SectorHalfWord; // 256 half-words (16-bit) per sector.
};

uint32_t be2le_uint32(uint32_t be)
{
	const uint32_t a = (be >> 0) & 0x000000FF;
	const uint32_t b = (be >> 8) & 0x000000FF;
	const uint32_t c = (be >> 16) & 0x000000FF;
	const uint32_t d = (be >> 24) & 0x000000FF;
	return (a << 24) | (b << 16) | (c << 8) | d;
}

uint64_t be2le_uint64(uint64_t be)
{
	const uint64_t a = (be >> 0) & 0x00000000000000FF;
	const uint64_t b = (be >> 8) & 0x00000000000000FF;
	const uint64_t c = (be >> 16) & 0x00000000000000FF;
	const uint64_t d = (be >> 24) & 0x00000000000000FF;
	const uint64_t e = (be >> 32) & 0x00000000000000FF;
	const uint64_t f = (be >> 40) & 0x00000000000000FF;
	const uint64_t g = (be >> 48) & 0x00000000000000FF;
	const uint64_t h = (be >> 56) & 0x00000000000000FF;
	return (a << 56) | (b << 48) | (c << 40) | (d << 32) | (e << 24) | (f << 16) | (g << 8) | h;
}

void vhdConvertFooterToHostEndian(VHDFooter* footer)
{
	// Assume host is little-endian (otherwise no conversion is required)
	footer->m_Features = be2le_uint32(footer->m_Features);
	footer->m_FileFormatVersion = be2le_uint32(footer->m_FileFormatVersion);
	footer->m_DataOffset = be2le_uint64(footer->m_DataOffset);
	footer->m_Timestamp = be2le_uint32(footer->m_Timestamp);
	footer->m_CreatorVersion = be2le_uint32(footer->m_CreatorVersion);
	footer->m_OriginalSize = be2le_uint64(footer->m_OriginalSize);
	footer->m_CurrentSize = be2le_uint64(footer->m_CurrentSize);
	footer->m_DiskType = be2le_uint32(footer->m_DiskType);
	footer->m_Checksum = be2le_uint32(footer->m_Checksum);
}

bool vhdRead(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t& retVal)
{
	RISCV_CHECK(dev->m_Flags & DEV_FLAGS_VHD, "Not a virtual hard disk");

	VHD* vhd = (VHD*)dev;

	const uint32_t reg = relAddr >> 2;
	retVal = 0;
	if (reg == VHD_REG_DRIVE) {
		retVal = 0xA0 | ((vhd->m_LBA >> 24) & 0x0000000F);
	} else if (reg == VHD_REG_ERROR_INFO) {
		retVal = 0; // TODO: Errors?
	} else if (reg == VHD_REG_SECTOR_COUNT) {
		retVal = vhd->m_SectorCount;
	} else if (reg == VHD_REG_LBA_LOW) {
		retVal = vhd->m_LBA & 0x000000FF;
	} else if (reg == VHD_REG_LBA_MID) {
		retVal = (vhd->m_LBA >> 8) & 0x000000FF;
	} else if (reg == VHD_REG_LBA_HIGH) {
		retVal = (vhd->m_LBA >> 16) & 0x000000FF;
	} else if (reg == VHD_REG_COMMAND_STATUS) {
		retVal = VHD_STATUS_RDY; // Always ready, no errors, never busy
		if ((vhd->m_Command == VHD_CMD_READ_SECTORS && vhd->m_SectorCount != 0) ||
			(vhd->m_Command == VHD_CMD_WRITE_SECTORS && vhd->m_SectorCount != 0)) {
			// The device either has more data to send to the CPU or it waits for more
			// data to be written to it.
			retVal = VHD_STATUS_DRQ;
		}
	} else if (reg == VHD_REG_DATA) {
		if (vhd->m_Command == VHD_CMD_READ_SECTORS && vhd->m_SectorCount != 0) {
			const uint64_t sectorOffset = (uint64_t)vhd->m_LBA << 9; // 512 bytes/sector
			const uint64_t halfWordOffset = sectorOffset + (uint64_t)(vhd->m_SectorHalfWord << 1);
			if (fseek(vhd->m_Handle, (long)halfWordOffset, SEEK_SET)) {
				RISCV_CHECK(false, "Invalid vhd address %08Xh", halfWordOffset);
			}
			if (fread(&retVal, sizeof(uint16_t), 1, vhd->m_Handle) != 1) {
				RISCV_CHECK(false, "Failed to read half word from address %08Xh", halfWordOffset);
			}

			// Move on to the next half-word.
			++vhd->m_SectorHalfWord;
			if (vhd->m_SectorHalfWord == 256) {
				vhd->m_SectorHalfWord = 0;
				RISCV_CHECK(vhd->m_SectorCount != 0, "Invalid sector count");
				--vhd->m_SectorCount;
				++vhd->m_LBA;
			}
		}
	}

	retVal &= byteMask;

	return true;
}

bool vhdWrite(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val)
{
	BX_UNUSED(byteMask);
	RISCV_CHECK(dev->m_Flags & DEV_FLAGS_VHD, "Not a virtual hard disk");

	VHD* vhd = (VHD*)dev;

	const uint32_t reg = relAddr >> 2;
	if (reg == VHD_REG_DRIVE) {
		// Ignore master/slave and LBA mode bits.
		// Set the 4 highest LBA bits.
		const uint32_t oldLBA = vhd->m_LBA;
		const uint32_t newLBABits = val & 0x0000000F;
		vhd->m_LBA = (oldLBA & 0x00FFFFFF) | (newLBABits << 24);
	} else if (reg == VHD_REG_ERROR_INFO) {
		// Ignore write
	} else if (reg == VHD_REG_SECTOR_COUNT) {
		vhd->m_SectorCount = (val & 0x000000FF);
	} else if (reg == VHD_REG_LBA_LOW) {
		const uint32_t oldLBA = vhd->m_LBA;
		const uint32_t newLBABits = val & 0x000000FF;
		vhd->m_LBA = (oldLBA & 0x0FFFFF00) | (newLBABits);
	} else if (reg == VHD_REG_LBA_MID) {
		const uint32_t oldLBA = vhd->m_LBA;
		const uint32_t newLBABits = val & 0x000000FF;
		vhd->m_LBA = (oldLBA & 0x0FFF00FF) | (newLBABits << 8);
	} else if (reg == VHD_REG_LBA_HIGH) {
		const uint32_t oldLBA = vhd->m_LBA;
		const uint32_t newLBABits = val & 0x000000FF;
		vhd->m_LBA = (oldLBA & 0x0F00FFFF) | (newLBABits << 16);
	} else if (reg == VHD_REG_COMMAND_STATUS) {
		vhd->m_Command = val & 0x000000FF;
		if (vhd->m_Command == VHD_CMD_WRITE_SECTORS ||
			vhd->m_Command == VHD_CMD_READ_SECTORS) 
		{
			vhd->m_SectorHalfWord = 0;
		} else if (vhd->m_Command == VHD_CMD_CACHE_FLUSH) {
			fflush(vhd->m_Handle);
		}
	} else if (reg == VHD_REG_DATA) {
		if (vhd->m_Command == VHD_CMD_WRITE_SECTORS && vhd->m_SectorCount != 0) {
			const uint64_t sectorOffset = (uint64_t)vhd->m_LBA << 9; // 512 bytes/sector
			const uint64_t halfWordOffset = sectorOffset + (uint64_t)(vhd->m_SectorHalfWord << 1);
			if (fseek(vhd->m_Handle, (long)halfWordOffset, SEEK_SET)) {
				RISCV_CHECK(false, "Invalid vhd address %08Xh", halfWordOffset);
			}
			if (fwrite(&val, sizeof(uint16_t), 1, vhd->m_Handle) != 1) {
				RISCV_CHECK(false, "Failed to write half word at address %08Xh", halfWordOffset);
			}

			// Move on to the next half-word.
			++vhd->m_SectorHalfWord;
			if (vhd->m_SectorHalfWord == 256) {
				vhd->m_SectorHalfWord = 0;
				RISCV_CHECK(vhd->m_SectorCount != 0, "Invalid sector count");
				--vhd->m_SectorCount;
				++vhd->m_LBA;
			}
		}
	}

	return true;
}

uint32_t vhdGet(Device* dev, uint32_t relAddr, uint32_t byteMask)
{
	// TODO: 
	BX_UNUSED(dev, relAddr, byteMask);
	return 0xbaadf00d;
}

Device* vhdCreate(const char* filename)
{
	VHD* vhd = (VHD*)malloc(sizeof(VHD));
	vhd->m_Handle = fopen(filename, "rb+"); // Open for read/update
	if (!vhd->m_Handle) {
		free(vhd);
		return nullptr;
	}

	// Get file size
	fseek(vhd->m_Handle, 0, SEEK_END);
	vhd->m_FileSize = (uint64_t)ftell(vhd->m_Handle);
	fseek(vhd->m_Handle, 0, SEEK_SET);
	if (vhd->m_FileSize == 0xFFFFFFFFFFFFFFFF) {
		fclose(vhd->m_Handle);
		free(vhd);
		return nullptr;
	}

	// Read footer
	fseek(vhd->m_Handle, -(long)sizeof(VHDFooter), SEEK_END);
	if (fread(&vhd->m_Footer, sizeof(VHDFooter), 1, vhd->m_Handle) != 1) {
		fclose(vhd->m_Handle);
		free(vhd);
		return nullptr;
	}

	vhd->m_Size = vhd->m_FileSize - sizeof(VHDFooter);

	vhdConvertFooterToHostEndian(&vhd->m_Footer);

	// Verify vhd
	if (!(vhd->m_Footer.m_Features & VHD_FEATURES_RESERVED) ||
		vhd->m_Footer.m_FileFormatVersion != VHD_FILE_FORMAT_VERSION ||
		vhd->m_Footer.m_DataOffset != 0xFFFFFFFFFFFFFFFF ||
		vhd->m_Footer.m_OriginalSize != vhd->m_Size ||
		vhd->m_Footer.m_CurrentSize != vhd->m_Size ||
		vhd->m_Footer.m_DiskType != VHD_DISK_TYPE_FIXED)
	{
		fclose(vhd->m_Handle);
		free(vhd);
		return nullptr;
	}

	// Rewind file to the beginning
	fseek(vhd->m_Handle, 0, SEEK_SET);

	// Initialize device
	vhd->m_Flags = DEV_FLAGS_VHD;
	vhd->read = vhdRead;
	vhd->write = vhdWrite;
	vhd->get = vhdGet;

	return vhd;
}

void vhdClose(Device* dev)
{
	RISCV_CHECK(dev->m_Flags & DEV_FLAGS_VHD, "Not a virtual hard disk");
	VHD* vhd = (VHD*)dev;
	if (vhd->m_Handle) {
		fclose(vhd->m_Handle);
		vhd->m_Handle = nullptr;
	}
}
}
}
