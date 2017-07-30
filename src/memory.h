#ifndef MEMORY_H
#define MEMORY_H

#include <stdint.h>

struct RegionFlags
{
	enum Enum : uint32_t
	{
		Execute = 0x01, // PF_X
		Write = 0x02,   // PF_W
		Read = 0x04,    // PF_R
	};
};

struct Region
{
	uint8_t* m_Start;
	uint8_t* m_End;
	uint32_t m_Flags;
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
bool memAddRegion(Memory* mem, uint32_t startAddress, uint32_t size, uint32_t flags);
bool memExpandOrAddRegion(Memory* mem, uint32_t startAddress, uint32_t deltaSize, uint32_t flags);
uint32_t memRead32(Memory* mem, uint32_t addr, uint32_t flags);
void memWrite32(Memory* mem, uint32_t addr, uint32_t val);
void memWrite16(Memory* mem, uint32_t addr, uint16_t val);
void memWrite8(Memory* mem, uint32_t addr, uint8_t val);
uint8_t* memVirtualToPhysical(Memory* mem, uint32_t addr);

#endif
