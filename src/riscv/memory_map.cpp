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

Device* ramCreate(uint32_t size)
{
	uint8_t* ramData = (uint8_t*)malloc(sizeof(Memory) + size);
	if (!ramData) {
		return nullptr;
	}

	Memory* ram = (Memory*)ramData;
	ram->read = ramRead;
	ram->write = ramWrite;
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
	rom->m_Data = romData + sizeof(Memory);
	rom->m_Size = size;

	bx::memCopy(rom->m_Data, data, dataSize);
	bx::memSet(&rom->m_Data[dataSize], 0, size - dataSize);

	return rom;
}

void romDestroy(Device* dev)
{
	free(dev);
}
}
}
