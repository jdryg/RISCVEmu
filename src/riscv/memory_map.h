#ifndef RISCV_MEMORY_MAP_H
#define RISCV_MEMORY_MAP_H

#include <stdint.h>

namespace riscv
{
struct MemoryMap;

struct Device
{
	uint32_t (*read)(Device* dev, uint32_t relAddr, uint32_t byteMask);
	void (*write)(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val);
};

MemoryMap* mmCreate();
void mmDestroy(MemoryMap* mm);

void mmMapDevice(MemoryMap* mm, Device* dev, uint32_t baseAddr, uint32_t size);

bool mmRead(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t& val);
bool mmWrite(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t val);

namespace device
{
void destroy(Device* dev);

Device* ramCreate(uint32_t size);
uint32_t ramGetSize(Device* dev);

Device* romCreate(uint32_t size, const uint8_t* data, uint32_t dataSize);
}
}

#endif
