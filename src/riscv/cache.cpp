#include "cache.h"
#include "memory_map.h"
#include "../debug.h"
#include <bx/bx.h>

#define TAG_BIT_VALID  0x80000000
#define TAG_BIT_DIRTY  0x40000000
#define TAG_VALUE_MASK 0x0FFFFFFF // Max 28-bit tag

namespace riscv
{
bool isPowerOfTwo(uint32_t x)
{
	return (x & (x - 1)) == 0;
}

uint32_t log2ui_pow2(uint32_t v)
{
	static const uint32_t b[] = { 0xAAAAAAAA, 0xCCCCCCCC, 0xF0F0F0F0, 0xFF00FF00, 0xFFFF0000 };

	uint32_t r = (v & b[0]) != 0;
	for (uint32_t i = 4; i > 0; i--) {
		r |= ((v & b[i]) != 0) << i;
	}

	return r;
}

bool cacheInit(Cache* cache, uint32_t lineSize, uint32_t numSets, uint32_t numWays)
{
	RISCV_CHECK(lineSize >= sizeof(uint32_t) && isPowerOfTwo(lineSize), "Cache: Line size should be at least 4 bytes long and a power of 2.");
	RISCV_CHECK(numSets != 0 && isPowerOfTwo(numSets), "Cache: Number of sets should be a power of 2 greater than 0.");
	RISCV_CHECK(numWays != 0 && isPowerOfTwo(numWays), "Cache: Number of ways should be a power of 2 greater than 0.");

	bx::memSet(cache, 0, sizeof(Cache));

	cache->m_LineSize = lineSize;
	cache->m_NumSets = numSets;
	cache->m_NumWays = numWays;

	const uint32_t log2LineSize = log2ui_pow2(lineSize);
	const uint32_t log2NumSets = log2ui_pow2(numSets);

	cache->m_OffsetMask = ((1 << log2LineSize) - 1) >> 2;
	cache->m_IndexMask = (1 << log2NumSets) - 1;
	cache->m_IndexShift = log2LineSize;
	cache->m_TagMask = (1 << (32 - log2LineSize - log2NumSets)) - 1;
	cache->m_TagShift = log2LineSize + log2NumSets;

	const uint32_t numTags = numSets * numWays;
	cache->m_Tags = (uint32_t*)malloc(sizeof(uint32_t) * numTags);
	bx::memSet(cache->m_Tags, 0, sizeof(uint32_t) * numTags); // Sets all Valid bits to 0.

	const uint32_t dataSize = numTags * lineSize;
	cache->m_Data = (uint8_t*)malloc(sizeof(uint8_t) * dataSize);
//	bx::memSet(cache->m_Data, 0, sizeof(uint8_t) * dataSize);

	cache->m_State = CacheState::Idle;

	return true;
}

void cacheShutdown(Cache* cache)
{
	free(cache->m_Tags);
	free(cache->m_Data);
	bx::memSet(cache, 0, sizeof(Cache));
}

void cacheTick(Cache* cache, uint32_t randomSource, const CacheCPUReq& in_cpuReq, const CacheMemRes& in_memRes, CacheCPURes& out_cpuRes, CacheMemReq& out_memReq)
{
	const CacheState::Enum state = cache->m_State;
	CacheState::Enum newState = state;

	const uint32_t wordsPerLine = cache->m_LineSize >> 2;

	// Combinational part
	out_cpuRes.m_Data = 0;
	out_cpuRes.m_Ready = false;
	out_memReq.m_Addr = in_cpuReq.m_Addr;
	out_memReq.m_Data = 0;
	out_memReq.m_RW = false;
	out_memReq.m_Valid = false;

	const uint32_t blockOffset = (in_cpuReq.m_Addr >> 2) & cache->m_OffsetMask; // NOTE: Offset mask has the first 2 bits zeroed. The offset is always word-aligned.
	const uint32_t setIndex = (in_cpuReq.m_Addr >> cache->m_IndexShift) & cache->m_IndexMask;
	const uint32_t tag = (in_cpuReq.m_Addr >> cache->m_TagShift) & cache->m_TagMask;

	uint32_t* setTags = &cache->m_Tags[setIndex * cache->m_NumWays];
	uint32_t* setData = (uint32_t*)&cache->m_Data[setIndex * cache->m_NumWays * cache->m_LineSize];

	// Lookup the specified tag in the set...
	uint32_t hitBlock = ~0u;
	uint32_t invalidBlock = ~0u;
	for (uint32_t iWay = 0; iWay < cache->m_NumWays; ++iWay) {
		const uint32_t setTag = setTags[iWay];
		if (setTag & TAG_BIT_VALID) {
			if (((setTag & TAG_VALUE_MASK) == tag)) {
				RISCV_CHECK(hitBlock == ~0u, "Cache: Multiple hits");
				hitBlock = iWay;
				// NOTE: Don't break here because we need an invalid entry in order to write 
				// in case of a miss.
			}
		} else {
			invalidBlock = iWay; // Candidate for replacement
		}
	}

	const uint32_t targetBlock = invalidBlock != ~0u ? invalidBlock : (randomSource % cache->m_NumWays);

	// Sequential part
	switch (state) {
	case CacheState::Idle:
		if (in_cpuReq.m_Valid) {
			newState = CacheState::CompareTag;
		}
		break;
	case CacheState::CompareTag:
		if (hitBlock != ~0u) {
			// Cache hit
			const uint32_t blockWordID = hitBlock * wordsPerLine + blockOffset;

			if (in_cpuReq.m_RW) {
				// Write request
				setTags[hitBlock] |= TAG_BIT_DIRTY;
				setData[blockWordID] = in_cpuReq.m_Data;
			}

			out_cpuRes.m_Ready = 1;
			out_cpuRes.m_Data = setData[blockWordID];

			newState = CacheState::Idle;
		} else {
			// Cache miss
			// If there's an invalid entry in this set, use for caching new data. Otherwise use the random source
			// (i.e. a free running counter) to select one of the ways in the set randomly.
			cache->m_TargetBlockID = setIndex * cache->m_NumWays + targetBlock;
			cache->m_TargetBlockWordID = 0;
			out_memReq.m_Valid = true;

			if (!(setTags[targetBlock] & TAG_BIT_VALID) || !(setTags[targetBlock] & TAG_BIT_DIRTY)) {
				// No need for write-back. Generate a memory read request and switch Allocate state.
				out_memReq.m_Addr = (tag << cache->m_TagShift) | (setIndex << cache->m_IndexShift);
				setTags[targetBlock] = TAG_BIT_VALID | tag;
				newState = CacheState::Allocate;
			} else {
				// Prepare for write-back. 
				out_memReq.m_Addr = ((setTags[targetBlock] & TAG_VALUE_MASK) << cache->m_TagShift) | (setIndex << cache->m_IndexShift);
				out_memReq.m_Data = setData[targetBlock * wordsPerLine]; // The 1st word of the cache line.
				out_memReq.m_RW = true;
				newState = CacheState::WriteBack;
			}
		}
		break;
	case CacheState::Allocate:
		if (in_memRes.m_Ready) {
			setData[cache->m_TargetBlockID * wordsPerLine + cache->m_TargetBlockWordID] = in_memRes.m_Data;
			++cache->m_TargetBlockWordID;
			if (cache->m_TargetBlockWordID >= wordsPerLine) {
				// We are done filling in the cache block. Switch to CompareTag again.
				newState = CacheState::CompareTag;
			} else {
				out_memReq.m_Valid = true;
				out_memReq.m_Addr = (tag << cache->m_TagShift) | (setIndex << cache->m_IndexShift) | (cache->m_TargetBlockWordID << 2);
			}
		}
		break;
	case CacheState::WriteBack:
		if (in_memRes.m_Ready) {
			++cache->m_TargetBlockWordID;
			if (cache->m_TargetBlockWordID >= wordsPerLine) {
				// We are done writing back the old block to memory. Switch to Allocate.
				cache->m_TargetBlockWordID = 0;
				setTags[targetBlock] = TAG_BIT_VALID | tag;
				newState = CacheState::Allocate;
			} else {
				out_memReq.m_Valid = true;
				out_memReq.m_RW = true;
				out_memReq.m_Addr = ((setTags[cache->m_TargetBlockID] & TAG_VALUE_MASK) << cache->m_TagShift) | (setIndex << cache->m_IndexShift) | (cache->m_TargetBlockWordID << 2);
				out_memReq.m_Data = setData[cache->m_TargetBlockID * wordsPerLine + cache->m_TargetBlockWordID];
			}
		}
		break;
	}

	cache->m_State = newState;
}

/*
bool cacheRead(Cache* cache, uint32_t addr, uint32_t byteMask, uint32_t& data)
{
	RISCV_CHECK((addr & 3) == 0, "Misaligned address");

	const uint32_t numWays = cache->m_NumWays;

	const uint32_t blockOffset = addr & cache->m_OffsetMask; // NOTE: Offset mask has the first 2 bits zeroed. The offset is always word-aligned.
	const uint32_t setIndex = (addr & cache->m_IndexMask) >> cache->m_IndexShift;
	const uint32_t tag = (addr & cache->m_TagMask) >> cache->m_TagShift;

	uint32_t* cacheData = nullptr;
	const uint32_t firstTagID = numWays * setIndex;
	for (uint32_t i = 0; i < numWays; ++i) {
		const uint32_t tagID = firstTagID + i;
		const uint32_t setTag = cache->m_Tags[tagID];
		if ((setTag & TAG_BIT_VALID) && ((setTag & TAG_VALUE_MASK) == tag)) {
			cacheData = (uint32_t*)&cache->m_Data[cache->m_LineSize * tagID];
			break;
		}
	}

	if (!cacheData) {
		return false;
	}

	data = cacheData[blockOffset] & byteMask;

	return true;
}

bool cacheWrite(Cache* cache, uint32_t addr, uint32_t byteMask, uint32_t data)
{
	RISCV_CHECK((addr & 3) == 0, "Misaligned address");

	const uint32_t numWays = cache->m_NumWays;

	const uint32_t blockOffset = addr & cache->m_OffsetMask; // NOTE: Offset mask has the first 2 bits zeroed. The offset is always word-aligned.
	const uint32_t setIndex = (addr & cache->m_IndexMask) >> cache->m_IndexShift;
	const uint32_t tag = (addr & cache->m_TagMask) >> cache->m_TagShift;

	uint32_t* cacheData = nullptr;
	const uint32_t firstTagID = numWays * setIndex;
	for (uint32_t i = 0; i < numWays; ++i) {
		const uint32_t tagID = firstTagID + i;
		const uint32_t setTag = cache->m_Tags[tagID];
		if ((setTag & TAG_BIT_VALID) && ((setTag & TAG_VALUE_MASK) == tag)) {
			cacheData = (uint32_t*)&cache->m_Data[cache->m_LineSize * tagID];
			break;
		}
	}

	if (!cacheData) {
		return false;
	}

	cacheData[blockOffset] = (cacheData[blockOffset] & (~byteMask)) | (data & byteMask);

	return true;
}
*/
}
