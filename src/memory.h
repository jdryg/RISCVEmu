#ifndef MEMORY_H
#define MEMORY_H

#include <stdint.h>

struct RegionFlags
{
	enum Enum : uint32_t
	{
		Execute = 0x01,
		Write = 0x02,
		Read = 0x04,
	};
};

struct Region
{
	uint8_t* m_Start;
	uint8_t* m_End;
	uint32_t m_Flags : 3;
	uint32_t m_MinPrivLevel : 2;
	uint32_t m_Unused : 27;
};

struct Memory
{
	Region* m_Regions;
	uint8_t* m_Data;
	uint32_t m_Size;
	uint32_t m_NumRegions;
};

Memory* memCreate(uint32_t size);
void memDestroy(Memory* mem);
bool memAddRegion(Memory* mem, uint32_t startAddress, uint32_t size, uint32_t flags, uint32_t minPrivLevel);
bool memExpandOrAddRegion(Memory* mem, uint32_t startAddress, uint32_t deltaSize, uint32_t flags, uint32_t minPrivLevel);
uint32_t memRead32(Memory* mem, uint32_t addr, uint32_t byteMask, uint32_t privLevel, bool isInstruction);
void memWrite32(Memory* mem, uint32_t addr, uint32_t val, uint32_t byteMask, uint32_t privLevel);
uint8_t* memVirtualToPhysical(Memory* mem, uint32_t addr);

#endif
