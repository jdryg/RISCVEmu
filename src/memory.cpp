#include "memory.h"
#include "debug.h"

Memory* memCreate(uint32_t size)
{
	Memory* mem = (Memory*)malloc(sizeof(Memory));
	mem->m_Regions = nullptr;
	mem->m_NumRegions = 0;

	mem->m_Data = (uint8_t*)malloc(size);
	if (!mem->m_Data) {
		free(mem);
		return nullptr;
	}

	bx::memSet(mem->m_Data, 0x55, size);
	mem->m_Size = size;

	return mem;
}

void memDestroy(Memory* mem)
{
	free(mem->m_Regions);
	free(mem->m_Data);
	free(mem);
}

bool _memCheckAccess(const Memory* mem, uint8_t* physicalPtr, uint32_t flags, uint32_t privLevel)
{
	if (privLevel == 3) {
		// Maximum privilege level has RWX access to the whole memory range.
		return true;
	}

	const uint32_t nr = mem->m_NumRegions;
	for (uint32_t i = 0; i < nr; ++i) {
		const Region* r = &mem->m_Regions[i];
		if (physicalPtr >= r->m_Start && physicalPtr <= r->m_End) {
			return (privLevel >= r->m_MinPrivLevel) && (r->m_Flags & flags) == flags;
		}
	}

	return false;
}

uint32_t memRead32(Memory* mem, uint32_t addr, uint32_t byteMask, uint32_t privLevel, bool isInstruction)
{
	RISCV_CHECK(addr + 3 < mem->m_Size, "memRead32(%08Xh): Invalid address", addr);
	
	uint8_t* data = memVirtualToPhysical(mem, addr);
	if (!_memCheckAccess(mem, data, RegionFlags::Read | (isInstruction ? RegionFlags::Execute : 0), privLevel)) {
		RISCV_CHECK(false, "Access violation reading memory at address %08Xh", addr);
		return 0x55555555;
	}

	uint32_t val = *(uint32_t*)data;
	return val & byteMask;
}

void memWrite32(Memory* mem, uint32_t addr, uint32_t val, uint32_t byteMask, uint32_t privLevel)
{
	RISCV_CHECK(addr + 3 < mem->m_Size, "memWrite32(%08Xh): Invalid address", addr);
	
	uint8_t* data = memVirtualToPhysical(mem, addr);
	if (!_memCheckAccess(mem, data, RegionFlags::Write, privLevel)) {
		RISCV_CHECK(false, "Access violation writing memory at address %08Xh", addr);
		return;
	}

	uint32_t oldVal = *(uint32_t*)data;
	*(uint32_t*)data = (oldVal & (~byteMask)) | (val & byteMask);
}

uint8_t* memVirtualToPhysical(Memory* mem, uint32_t addr)
{
	RISCV_CHECK(addr < mem->m_Size, "memVirtualToPhysical(%08Xh): Invalid address", addr);
	return mem->m_Data + addr;
}

bool memAddRegion(Memory* mem, uint32_t startAddress, uint32_t size, uint32_t flags, uint32_t minPrivLevel)
{
	// Check if this region overlaps another region.
	uint8_t* startPtr = memVirtualToPhysical(mem, startAddress);
	uint8_t* endPtr = memVirtualToPhysical(mem, startAddress + size - 1);

	const uint32_t nr = mem->m_NumRegions;
	for (uint32_t i = 0; i < nr; ++i) {
		const Region* r = &mem->m_Regions[i];
		const bool startPtrInside = (startPtr >= r->m_Start && startPtr <= r->m_End);
		const bool endPtrInside = (endPtr >= r->m_Start && endPtr <= r->m_End);

		if (startPtrInside && endPtrInside) {
			// Region already exists.
			RISCV_CHECK(flags == r->m_Flags, "Region already exists with different protection flags");
			return true; // ???
		} else if ((startPtrInside && !endPtrInside) || (!startPtrInside && endPtrInside)) {
			RISCV_CHECK(false, "Regions overlap");
			return false;
		}
		RISCV_CHECK(endPtr < r->m_Start || startPtr > r->m_End, "Regions overlap");
	}

	++mem->m_NumRegions;
	mem->m_Regions = (Region*)realloc(mem->m_Regions, sizeof(Region) * mem->m_NumRegions);

	Region* newRegion = &mem->m_Regions[mem->m_NumRegions - 1];
	newRegion->m_Start = startPtr;
	newRegion->m_End = endPtr;
	newRegion->m_Flags = flags;
	newRegion->m_MinPrivLevel = minPrivLevel;

	return true;
}

bool memExpandOrAddRegion(Memory* mem, uint32_t startAddress, uint32_t deltaSize, uint32_t flags, uint32_t minPrivLevel)
{
	// Find the region with the specified start address.
	uint8_t* startPtr = memVirtualToPhysical(mem, startAddress);

	const uint32_t nr = mem->m_NumRegions;
	for (uint32_t i = 0; i < nr; ++i) {
		Region* r = &mem->m_Regions[i];
		if (r->m_Start == startPtr) {
			r->m_End += deltaSize;
			RISCV_CHECK(r->m_End < mem->m_Data + mem->m_Size, "Region expanded outside the valid space");

			// Ignore flags
			RISCV_CHECK(r->m_Flags == flags, "Cannot change memory region flags on expansion.");
			return true;
		}
	}

	// Region not found. Add it...
	return memAddRegion(mem, startAddress, deltaSize, flags, minPrivLevel);
}
