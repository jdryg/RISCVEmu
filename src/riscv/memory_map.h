#ifndef RISCV_MEMORY_MAP_H
#define RISCV_MEMORY_MAP_H

#include <stdint.h>

namespace riscv
{
struct MemoryMap;

struct Device
{
	uint32_t m_Flags;

	uint32_t (*read)(Device* dev, uint32_t relAddr, uint32_t byteMask);
	void (*write)(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val);
	uint32_t(*get)(Device* dev, uint32_t relAddr, uint32_t byteMask); // Non-destructive read (see uartRead/uartGet for an example)
};

MemoryMap* mmCreate();
void mmDestroy(MemoryMap* mm);

void mmMapDevice(MemoryMap* mm, Device* dev, uint32_t baseAddr, uint32_t size);
uint32_t mmGetDeviceBaseAddr(const MemoryMap* mm, uint32_t id);
uint32_t mmGetNumDevices(const MemoryMap* mm);
Device* mmGetDeviceByID(MemoryMap* mm, uint32_t id);

bool mmRead(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t& val);
bool mmWrite(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t val);
bool mmGet(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t& val);

namespace device
{
const uint32_t kUARTMemorySize = sizeof(uint32_t) * 3; // NOTE: 3 == UART_NUM_REGS in .cpp
const uint32_t kVHDMemorySize = sizeof(uint32_t) * 8; // NOTE: 8 == VHD_NUM_REGS in .cpp

void destroy(Device* dev);

bool isMemory(const Device* dev);
uint32_t memGetSize(const Device* dev);
uint8_t* memGetDataPtr(Device* dev);
bool memIsReadOnly(const Device* dev);

Device* ramCreate(uint32_t size);
Device* romCreate(uint32_t size, const uint8_t* data, uint32_t dataSize);
Device* uartCreate();
bool uartTransmit(Device* dev, uint8_t& data);
bool uartReceive(Device* dev, uint8_t data);

Device* vhdCreate(const char* filename);
}
}

#endif
