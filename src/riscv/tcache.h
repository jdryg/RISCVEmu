#ifndef RISCV_TCACHE_H
#define RISCV_TCACHE_H

#include "icache.h"
#include "../debug.h"
#include "../math.h"
#include <stdint.h>
#include <bx/bx.h>

#define INVALID_ID ~0u

namespace riscv
{
template<uint32_t LineSize>
class TCacheBlock
{
public:
	uint32_t m_Tag;

	TCacheBlock() : m_Tag(0)
	{}

	uint32_t read(uint32_t addr, uint32_t n, void* data);
	uint32_t write(uint32_t addr, uint32_t n, const void* data);

private:
	uint8_t m_Data[LineSize];
};

template<uint32_t NumWays, uint32_t LineSize>
class TCacheSet
{
public:
	uint32_t lookup(uint32_t tag);
	uint32_t getEmptyBlock();
	uint32_t read(uint32_t blockID, uint32_t blockOffset, uint32_t n, void* data);
	uint32_t write(uint32_t blockID, uint32_t blockOffset, uint32_t n, const void* data);
	uint32_t getBlockTagBits(uint32_t blockID);
	void setBlockTagBits(uint32_t blockID, uint32_t tagBits);

private:
	typedef TCacheBlock<LineSize> Block;

	Block m_Blocks[NumWays];
};

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
class TCache : public ICache
{
public:
	virtual ~TCache()
	{}

	virtual uint32_t lookup(uint32_t addr, uint32_t& tag, uint32_t& setID, uint32_t& blockOffset);
	virtual uint32_t read(uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, void* data);
	virtual uint32_t write(uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, const void* data);
	virtual uint32_t getBlockTagBits(uint32_t setID, uint32_t blockID);
	virtual void setBlockTagBits(uint32_t setID, uint32_t blockID, uint32_t tagBits);
	virtual uint32_t getEmptyBlock(uint32_t setID);
	virtual uint32_t makeAddress(uint32_t tag, uint32_t setID, uint32_t blockOffset);
	virtual uint32_t getNumSets();
	virtual uint32_t getNumWays();
	virtual uint32_t getBlockSize();

private:
	typedef TCacheSet<NumWays, LineSize> Set;

	Set m_Sets[NumSets];
};

//////////////////////////////////////////////////////////////////////////
// Block
// 
template<uint32_t LineSize>
uint32_t TCacheBlock<LineSize>::read(uint32_t addr, uint32_t n, void* data)
{
	RISCV_CHECK(addr < LineSize, "Cache: Invalid block address");
	RISCV_CHECK(n != 0, "Cache: Cannot read 0 bytes from the cache");

	const uint32_t maxN = LineSize - addr;
	const uint32_t nRead = n < maxN ? n : maxN;

	bx::memCopy(data, &m_Data[addr], nRead);

	return nRead;
}

template<uint32_t LineSize>
uint32_t TCacheBlock<LineSize>::write(uint32_t addr, uint32_t n, const void* data)
{
	RISCV_CHECK(addr < LineSize, "Cache: Invalid block address");
	RISCV_CHECK(n != 0, "Cache: Cannot write 0 bytes to the cache");

	const uint32_t maxN = LineSize - addr;
	const uint32_t nWrite = n < maxN ? n : maxN;

	bx::memCopy(&m_Data[addr], data, nWrite);

	return nWrite;
}

//////////////////////////////////////////////////////////////////////////
// Set
//
template<uint32_t NumWays, uint32_t LineSize>
uint32_t TCacheSet<NumWays, LineSize>::lookup(uint32_t tag)
{
	for (uint32_t i = 0; i < NumWays; ++i) {
		uint32_t blockTag = m_Blocks[i].m_Tag;
		if (cacheBlockIsValid(blockTag) && cacheBlockGetTag(blockTag) == tag) {
			return i;
		}
	}

	return INVALID_ID;
}

template<uint32_t NumWays, uint32_t LineSize>
uint32_t TCacheSet<NumWays, LineSize>::getEmptyBlock()
{
	for (uint32_t i = 0; i < NumWays; ++i) {
		uint32_t blockTag = m_Blocks[i].m_Tag;
		if (!cacheBlockIsValid(blockTag)) {
			return i;
		}
	}

	return INVALID_ID;
}

template<uint32_t NumWays, uint32_t LineSize>
uint32_t TCacheSet<NumWays, LineSize>::read(uint32_t blockID, uint32_t blockOffset, uint32_t n, void* data)
{
	RISCV_CHECK(blockID < NumWays, "Invalid block index");
	return m_Blocks[blockID].read(blockOffset, n, data);
}

template<uint32_t NumWays, uint32_t LineSize>
uint32_t TCacheSet<NumWays, LineSize>::write(uint32_t blockID, uint32_t blockOffset, uint32_t n, const void* data)
{
	RISCV_CHECK(blockID < NumWays, "Invalid block index");
	return m_Blocks[blockID].write(blockOffset, n, data);
}

template<uint32_t NumWays, uint32_t LineSize>
uint32_t TCacheSet<NumWays, LineSize>::getBlockTagBits(uint32_t blockID)
{
	RISCV_CHECK(blockID < NumWays, "Invalid block index");
	return m_Blocks[blockID].m_Tag;
}

template<uint32_t NumWays, uint32_t LineSize>
void TCacheSet<NumWays, LineSize>::setBlockTagBits(uint32_t blockID, uint32_t tagBits)
{
	RISCV_CHECK(blockID < NumWays, "Invalid block index");
	m_Blocks[blockID].m_Tag = tagBits;
}

//////////////////////////////////////////////////////////////////////////
// Cache
//
template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::lookup(uint32_t addr, uint32_t& tag, uint32_t& setID, uint32_t& blockOffset)
{
	const uint32_t log2LineSize = log2ui_pow2(LineSize);
	const uint32_t log2NumSets = log2ui_pow2(NumSets);

	const uint32_t offsetMask = ((1 << log2LineSize) - 1);
	const uint32_t indexMask = (1 << log2NumSets) - 1;
	const uint32_t indexShift = log2LineSize;
	const uint32_t tagMask = (1 << (32 - log2LineSize - log2NumSets)) - 1;
	const uint32_t tagShift = log2LineSize + log2NumSets;

	tag = (addr >> tagShift) & tagMask;
	setID = (addr >> indexShift) & indexMask;
	blockOffset = addr & offsetMask;

	return m_Sets[setID].lookup(tag);
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::makeAddress(uint32_t tag, uint32_t setID, uint32_t blockOffset)
{
	const uint32_t log2LineSize = log2ui_pow2(LineSize);
	const uint32_t log2NumSets = log2ui_pow2(NumSets);

	const uint32_t offsetMask = ((1 << log2LineSize) - 1);
	const uint32_t indexMask = (1 << log2NumSets) - 1;
	const uint32_t indexShift = log2LineSize;
	const uint32_t tagMask = (1 << (32 - log2LineSize - log2NumSets)) - 1;
	const uint32_t tagShift = log2LineSize + log2NumSets;

	return (blockOffset & offsetMask) | ((setID & indexMask) << indexShift) | ((tag & tagMask) << tagShift);
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::read(uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, void* data)
{
	RISCV_CHECK(setID < NumSets, "Invalid set index");
	return m_Sets[setID].read(blockID, blockOffset, n, data);
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::write(uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, const void* data)
{
	RISCV_CHECK(setID < NumSets, "Invalid set index");
	return m_Sets[setID].write(blockID, blockOffset, n, data);
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::getBlockTagBits(uint32_t setID, uint32_t blockID)
{
	RISCV_CHECK(setID < NumSets, "Invalid set index");
	return m_Sets[setID].getBlockTagBits(blockID);
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
void TCache<NumSets, NumWays, LineSize>::setBlockTagBits(uint32_t setID, uint32_t blockID, uint32_t tagBits)
{
	RISCV_CHECK(setID < NumSets, "Invalid set index");
	m_Sets[setID].setBlockTagBits(blockID, tagBits);
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::getNumSets()
{
	return NumSets;
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::getNumWays()
{
	return NumWays;
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::getBlockSize()
{
	return LineSize;
}

template<uint32_t NumSets, uint32_t NumWays, uint32_t LineSize>
uint32_t TCache<NumSets, NumWays, LineSize>::getEmptyBlock(uint32_t setID)
{
	RISCV_CHECK(setID < NumSets, "Invalid set index");
	return m_Sets[setID].getEmptyBlock();
}
}

#endif
