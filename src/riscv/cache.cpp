#include "cache.h"
#include "memory_map.h"
#include "../debug.h"
#include "../math.h"
#include <bx/bx.h>

namespace riscv
{
struct Cache
{
	uint32_t* m_Tags;
	uint8_t* m_Data;
	uint32_t m_BlockSize;
	uint32_t m_NumSets;
	uint32_t m_NumWays;

	uint32_t m_OffsetMask;
	uint32_t m_IndexMask;
	uint32_t m_IndexShift;
	uint32_t m_TagMask;
	uint32_t m_TagShift;
};

Cache* cacheCreate(uint32_t numSets, uint32_t numWays, uint32_t blockSize)
{
	RISCV_CHECK(blockSize >= sizeof(uint32_t) && isPowerOfTwo(blockSize), "Cache: Block size should be at least 4 bytes long and a power of 2.");
	RISCV_CHECK(numSets != 0 && isPowerOfTwo(numSets), "Cache: Number of sets should be a power of 2 greater than 0.");
	RISCV_CHECK(numWays != 0 && isPowerOfTwo(numWays), "Cache: Number of ways should be a power of 2 greater than 0.");

	Cache* cache = (Cache*)malloc(sizeof(Cache));
	bx::memSet(cache, 0, sizeof(Cache));

	cache->m_BlockSize = blockSize;
	cache->m_NumSets = numSets;
	cache->m_NumWays = numWays;

	const uint32_t log2BlockSize = log2ui_pow2(blockSize);
	const uint32_t log2NumSets = log2ui_pow2(numSets);

	cache->m_OffsetMask = ((1 << log2BlockSize) - 1);
	cache->m_IndexMask = (1 << log2NumSets) - 1;
	cache->m_IndexShift = log2BlockSize;
	cache->m_TagMask = (1 << (32 - log2BlockSize - log2NumSets)) - 1;
	cache->m_TagShift = log2BlockSize + log2NumSets;

	const uint32_t numBlocks = numSets * numWays;
	cache->m_Tags = (uint32_t*)malloc(sizeof(uint32_t) * numBlocks);
	bx::memSet(cache->m_Tags, 0, sizeof(uint32_t) * numBlocks);

	const uint32_t dataSize = numBlocks * blockSize;
	cache->m_Data = (uint8_t*)malloc(sizeof(uint8_t) * dataSize);
//	bx::memSet(cache->m_Data, 0, sizeof(uint8_t) * dataSize);

	return cache;
}

void cacheDestroy(Cache* cache)
{
	free(cache->m_Tags);
	free(cache->m_Data);
	free(cache);
}

uint32_t cacheLookup(Cache* cache, uint32_t addr, uint32_t& tag, uint32_t& setID, uint32_t& blockOffset)
{
	tag = (addr >> cache->m_TagShift) & cache->m_TagMask;
	setID = (addr >> cache->m_IndexShift) & cache->m_IndexMask;
	blockOffset = addr & cache->m_OffsetMask;

	const uint32_t numWays = cache->m_NumWays;
	const uint32_t* setTags = &cache->m_Tags[setID * numWays];
	for (uint32_t i = 0; i < numWays; ++i) {
		uint32_t blockTag = setTags[i];
		if (cacheBlockIsValid(blockTag) && cacheBlockGetTag(blockTag) == tag) {
			return i;
		}
	}

	return ~0u;
}

uint32_t cacheRead(Cache* cache, uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, void* data)
{
	RISCV_CHECK(setID < cache->m_NumSets, "Cache: Invalid set index");
	RISCV_CHECK(blockID < cache->m_NumWays, "Cache: Invalid block index");
	RISCV_CHECK(blockOffset < cache->m_BlockSize, "Cache: Invalid block offset");
	RISCV_CHECK(n != 0, "Cache: Cannot read 0 bytes from the cache");

	const uint32_t maxN = cache->m_BlockSize - blockOffset;
	const uint32_t nRead = n < maxN ? n : maxN;

	const uint8_t* blockData = &cache->m_Data[(setID * cache->m_NumWays + blockID) * cache->m_BlockSize];
	bx::memCopy(data, &blockData[blockOffset], nRead);

	return nRead;
}

uint32_t cacheWrite(Cache* cache, uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, const void* data)
{
	RISCV_CHECK(setID < cache->m_NumSets, "Cache: Invalid set index");
	RISCV_CHECK(blockID < cache->m_NumWays, "Cache: Invalid block index");
	RISCV_CHECK(blockOffset < cache->m_BlockSize, "Cache: Invalid block offset");
	RISCV_CHECK(n != 0, "Cache: Cannot read 0 bytes from the cache");

	const uint32_t maxN = cache->m_BlockSize - blockOffset;
	const uint32_t nWrite = n < maxN ? n : maxN;

	uint8_t* blockData = &cache->m_Data[(setID * cache->m_NumWays + blockID) * cache->m_BlockSize];
	bx::memCopy(&blockData[blockOffset], data, nWrite);

	return nWrite;
}

uint32_t cacheGetBlockTagBits(Cache* cache, uint32_t setID, uint32_t blockID)
{
	RISCV_CHECK(setID < cache->m_NumSets, "Cache: Invalid set index");
	RISCV_CHECK(blockID < cache->m_NumWays, "Cache: Invalid block index");

	const uint32_t* setTags = &cache->m_Tags[setID * cache->m_NumWays];
	return setTags[blockID];
}

void cacheSetBlockTagBits(Cache* cache, uint32_t setID, uint32_t blockID, uint32_t tagBits)
{
	RISCV_CHECK(setID < cache->m_NumSets, "Cache: Invalid set index");
	RISCV_CHECK(blockID < cache->m_NumWays, "Cache: Invalid block index");

	uint32_t* setTags = &cache->m_Tags[setID * cache->m_NumWays];
	setTags[blockID] = tagBits;
}

uint32_t cacheGetEmptyBlock(Cache* cache, uint32_t setID)
{
	const uint32_t numWays = cache->m_NumWays;
	const uint32_t* setTags = &cache->m_Tags[setID * numWays];
	for (uint32_t i = 0; i < numWays; ++i) {
		uint32_t blockTag = setTags[i];
		if (!cacheBlockIsValid(blockTag)) {
			return i;
		}
	}

	return ~0u;
}

uint32_t cacheMakeAddress(Cache* cache, uint32_t tag, uint32_t setID, uint32_t blockOffset)
{
	const uint32_t offsetMask = cache->m_OffsetMask;
	const uint32_t indexMask = cache->m_IndexMask;
	const uint32_t indexShift = cache->m_IndexShift;
	const uint32_t tagMask = cache->m_TagMask;
	const uint32_t tagShift = cache->m_TagShift;

	return (blockOffset & offsetMask) | ((setID & indexMask) << indexShift) | ((tag & tagMask) << tagShift);
}

uint32_t cacheGetNumSets(Cache* cache)
{
	return cache->m_NumSets;
}

uint32_t cacheGetNumWays(Cache* cache)
{
	return cache->m_NumWays;
}

uint32_t cacheGetBlockSize(Cache* cache)
{
	return cache->m_BlockSize;
}
}
