#include "memory_map.h"
#include "../debug.h"
#include <malloc.h>

namespace riscv
{
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

bool mmRead(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t& val)
{
	const uint32_t numDevices = mm->m_NumDevices;
	DeviceDesc* dd = mm->m_Devices;
	for (uint32_t i = 0; i < numDevices; ++i, ++dd) {
		if (addr >= dd->m_StartAddr && addr <= dd->m_EndAddr) {
			val = dd->m_Dev->read(dd->m_Dev, addr - dd->m_StartAddr, byteMask);
			return true;
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
			dd->m_Dev->write(dd->m_Dev, addr - dd->m_StartAddr, byteMask, val);
			return true;
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
void destroy(Device* dev)
{
	free(dev);
}

// Devices
struct Memory : public Device
{
	uint8_t* m_Data;
	uint32_t m_Size;
};

// RAM
uint32_t ramRead(Device* dev, uint32_t relAddr, uint32_t byteMask)
{
	Memory* ram = (Memory*)dev;

	RISCV_CHECK(relAddr < ram->m_Size, "Invalid RAM relative address %08Xh. RAM size = %08Xh", relAddr, ram->m_Size);

	uint32_t val = *(uint32_t*)&ram->m_Data[relAddr];
	return val & byteMask;
}

void ramWrite(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val)
{
	Memory* ram = (Memory*)dev;

	RISCV_CHECK(relAddr < ram->m_Size, "Invalid RAM relative address %08Xh. RAM size = %08Xh", relAddr, ram->m_Size);

	uint32_t* wordPtr = (uint32_t*)&ram->m_Data[relAddr];

	uint32_t oldVal = *wordPtr;
	*wordPtr = (val & byteMask) | (oldVal & (~byteMask));
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
	ram->read = ramRead;
	ram->write = ramWrite;
	ram->get = ramGet;
	ram->m_Data = ramData + sizeof(Memory);
	ram->m_Size = size;

	bx::memSet(ram->m_Data, 0, size);

	return ram;
}

uint32_t ramGetSize(Device* dev)
{
	Memory* ram = (Memory*)dev;
	return ram->m_Size;
}

// ROM
uint32_t romRead(Device* dev, uint32_t relAddr, uint32_t byteMask)
{
	Memory* rom = (Memory*)dev;

	RISCV_CHECK(relAddr < rom->m_Size, "Invalid ROM relative address %08Xh. ROM size = %08Xh", relAddr, rom->m_Size);

	uint32_t val = *(uint32_t*)&rom->m_Data[relAddr];
	return val & byteMask;
}

void romWrite(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val)
{
	BX_UNUSED(dev, relAddr, byteMask, val);
	// Nop
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

uint32_t uartRead(Device* dev, uint32_t relAddr, uint32_t byteMask)
{
	UART* uart = (UART*)dev;
	
	const uint32_t reg = relAddr >> 2;
	RISCV_CHECK(reg < UART_NUM_REGS, "Invalid UART relative address %08Xh", relAddr);
	RISCV_CHECK(reg != UART_REG_TXDATA, "UART: Tried to read TXDATA register");

	if (reg == UART_REG_RXDATA) {
		RISCV_CHECK(uart->m_Regs[UART_REG_STATUS] & UART_STATUS_RXFULL, "UART: Tried to read data with RXFULL=0");

		uart->m_Regs[UART_REG_STATUS] &= ~UART_STATUS_RXFULL;
	}

	uint32_t val = uart->m_Regs[reg] & 0x000000FF; // 8-bit registers
	return val & byteMask;
}

void uartWrite(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val)
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
	uart->read = uartRead;
	uart->write = uartWrite;
	uart->get = uartGet;
	uart->m_Regs[UART_REG_TXDATA] = 0;
	uart->m_Regs[UART_REG_RXDATA] = 0;
	uart->m_Regs[UART_REG_STATUS] = UART_STATUS_TXREADY;

	return uart;
}
}
}
