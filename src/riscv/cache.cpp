#include "cache.h"
#include "memory_map.h"
#include "../debug.h"
#include <bx/bx.h>

#define TAG_BIT_VALID  0x80000000
#define TAG_BIT_DIRTY  0x40000000
#define TAG_BIT_ERROR  0x20000000 // Error means that something went wrong during Allocate (e.g. tried to read an invalid memory location).
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

	cache->m_OffsetMask = ((1 << log2LineSize) - 1);
	cache->m_IndexMask = (1 << log2NumSets) - 1;
	cache->m_IndexShift = log2LineSize;
	cache->m_TagMask = (1 << (32 - log2LineSize - log2NumSets)) - 1;
	cache->m_TagShift = log2LineSize + log2NumSets;

	const uint32_t numBlocks = numSets * numWays;
	cache->m__Tags = (uint32_t*)malloc(sizeof(uint32_t) * numBlocks);
	bx::memSet(cache->m__Tags, 0, sizeof(uint32_t) * numBlocks); // Sets all Valid bits to 0.

	const uint32_t dataSize = numBlocks * lineSize;
	cache->m__Data = (uint8_t*)malloc(sizeof(uint8_t) * dataSize);
//	bx::memSet(cache->m_Data, 0, sizeof(uint8_t) * dataSize);

	cache->m__Blocks = (CacheBlock*)malloc(sizeof(CacheBlock) * numBlocks);
	for (uint32_t i = 0; i < numBlocks; ++i) {
		cache->m__Blocks[i].m_Data = &cache->m__Data[i * lineSize];
	}

	cache->m_Sets = (CacheSet*)malloc(sizeof(CacheSet) * numSets);
	for (uint32_t i = 0; i < numSets; ++i) {
		CacheSet* set = &cache->m_Sets[i];
		set->m_Blocks = &cache->m__Blocks[i * numWays];
		set->m_Tags = &cache->m__Tags[i * numWays];
	}

	cache->m_NextState.m_State = Cache::State::Idle;
	cache->m_MemReq.m_Control.m_Fields.m_Valid = 0;
	cache->m_MemRes.m_Control.m_Fields.m_Ready = 0;
	bx::memCopy(&cache->m_State, &cache->m_NextState, sizeof(Cache::State));

	return true;
}

void cacheShutdown(Cache* cache)
{
	free(cache->m_Sets);
	free(cache->m__Blocks);
	free(cache->m__Tags);
	free(cache->m__Data);
	bx::memSet(cache, 0, sizeof(Cache));
}

uint32_t cacheLookupTag(Cache* cache, uint32_t setID, uint32_t tag, uint32_t& matchedTag)
{
	const CacheSet* set = &cache->m_Sets[setID];
	const uint32_t* setTags = set->m_Tags;

	uint32_t hitBlock = ~0u;
	for (uint32_t iWay = 0; iWay < cache->m_NumWays; ++iWay) {
		const uint32_t setTag = setTags[iWay];
		if ((setTag & TAG_BIT_VALID) && ((setTag & TAG_VALUE_MASK) == tag)) {
			RISCV_CHECK(hitBlock == ~0u, "!!!");
			hitBlock = iWay;
			matchedTag = setTag;
//			break;
		}
	}

	return hitBlock;
}

uint32_t cacheFindInvalidBlock(Cache* cache, uint32_t setID)
{
	const CacheSet* set = &cache->m_Sets[setID];
	const uint32_t* setTags = set->m_Tags;

	uint32_t invalidBlock = ~0u;
	for (uint32_t iWay = 0; iWay < cache->m_NumWays; ++iWay) {
		const uint32_t setTag = setTags[iWay];
		if (!(setTag & TAG_BIT_VALID)) {
			invalidBlock = iWay;
			break;
		}
	}

	return invalidBlock;
}

void cacheTick(Cache* cache, uint32_t randomSrc, const MemoryRequest& cpuReq, MemoryResponse& cpuRes)
{
	Cache::State::Enum state = cache->m_State.m_State;

	cache->m_MemReq.m_Control.m_Fields.m_Valid = 0;

	if (state == Cache::State::Idle) {
		if (cpuReq.m_Control.m_Fields.m_Valid) {
			const uint32_t addr = cpuReq.m_Addr;

			const uint32_t setIndex = (addr >> cache->m_IndexShift) & cache->m_IndexMask;
			const uint32_t tag = (addr >> cache->m_TagShift) & cache->m_TagMask;

			CacheSet* set = &cache->m_Sets[setIndex];

			// Lookup the specified tag in the set...
			uint32_t matchedTag;
			const uint32_t hitBlock = cacheLookupTag(cache, setIndex, tag, matchedTag);

			if (hitBlock != ~0u) {
				RISCV_CHECK(matchedTag == set->m_Tags[hitBlock], "Invalid tag");

				// Cache hit
				const uint32_t numBytesToRead = 1 << cpuReq.m_Control.m_Fields.m_Size;
				const uint32_t byteMask = 0xFFFFFFFF >> (32 - (numBytesToRead << 3));
				const uint32_t blockByteOffset = addr & cache->m_OffsetMask;
				RISCV_CHECK(blockByteOffset + numBytesToRead <= cache->m_LineSize, "Cannot read from multiple cache lines");

				uint32_t* word = (uint32_t*)&set->m_Blocks[hitBlock].m_Data[blockByteOffset];
				if (cpuReq.m_Control.m_Fields.m_WriteEnable) {
					*word = (*word & ~byteMask) | (cpuReq.m_Data & byteMask);
					set->m_Tags[hitBlock] |= TAG_BIT_DIRTY;
				}

				cpuRes.m_Control.m_Fields.m_Ready = 1;
				cpuRes.m_Control.m_Fields.m_Valid = (matchedTag & TAG_BIT_ERROR) ? 0 : 1;
				cpuRes.m_Data = *word & byteMask;
			} else {
				// Cache miss.
				cpuRes.m_Control.m_Fields.m_Ready = 0;

				// Find the cache line to write data in.
				const uint32_t invalidBlock = cacheFindInvalidBlock(cache, setIndex);
				const uint32_t targetBlock = invalidBlock != ~0u ? invalidBlock : (randomSrc % cache->m_NumWays);

				// If the selected block isn't valid or if it's valid but not dirty, there's no need for write-back. 
				// Replace it immediatelly.
				const uint32_t globalBlockID = setIndex * cache->m_NumWays + targetBlock;
				const uint32_t blockTag = set->m_Tags[targetBlock];
				if (!(blockTag & TAG_BIT_VALID) || !(blockTag & TAG_BIT_DIRTY)) {
					// Update the tag.
					set->m_Tags[targetBlock] = TAG_BIT_VALID | tag;

					// Prepare 1st word read from memory
					cache->m_MemReq.m_Control.m_Fields.m_Valid = 1;
					cache->m_MemReq.m_Control.m_Fields.m_Size = 2;
					cache->m_MemReq.m_Control.m_Fields.m_WriteEnable = 0;
					cache->m_MemReq.m_Addr = (tag << cache->m_TagShift) | (setIndex << cache->m_IndexShift);

					// Switch to Allocate state.
					cache->m_NextState.m_TargetBlockID = globalBlockID;
					cache->m_NextState.m_NextWordID = 0;
					cache->m_NextState.m_State = Cache::State::Allocate;
				} else {
					// Block must be written back to memory before reading new data.
					uint32_t* cacheLine = (uint32_t*)set->m_Blocks[targetBlock].m_Data;

					set->m_Tags[targetBlock] = TAG_BIT_VALID | tag;

					cache->m_MemReq.m_Control.m_Fields.m_Valid = 1;
					cache->m_MemReq.m_Control.m_Fields.m_Size = 2;
					cache->m_MemReq.m_Control.m_Fields.m_WriteEnable = 1;
					cache->m_MemReq.m_Addr = ((blockTag & TAG_VALUE_MASK) << cache->m_TagShift) | (setIndex << cache->m_IndexShift);
					cache->m_MemReq.m_Data = cacheLine[0];

					cache->m_NextState.m_TargetBlockID = globalBlockID;
					cache->m_NextState.m_NextWordID = 0;
					cache->m_NextState.m_StateAfterWriteBack = Cache::State::Allocate;
					cache->m_NextState.m_State = Cache::State::WriteBack;
				}
			}
		} else {
			cpuRes.m_Control.m_Fields.m_Ready = 0;
		}
	} else if (state == Cache::State::Allocate) {
		cpuRes.m_Control.m_Fields.m_Ready = 0;

		if (cache->m_MemRes.m_Control.m_Fields.m_Ready) {
			const uint32_t setIndex = cache->m_State.m_TargetBlockID / cache->m_NumWays;
			const uint32_t blockIndex = cache->m_State.m_TargetBlockID % cache->m_NumWays;
			CacheSet* set = &cache->m_Sets[setIndex];

			if (!cache->m_MemRes.m_Control.m_Fields.m_Valid) {
				// Raise the ERROR bit of the cache line.
				set->m_Tags[blockIndex] |= TAG_BIT_ERROR;
				cache->m_NextState.m_State = Cache::State::Idle;
			} else {
				uint32_t* cacheLine = (uint32_t*)set->m_Blocks[blockIndex].m_Data;
				cacheLine[cache->m_State.m_NextWordID] = cache->m_MemRes.m_Data;
				cache->m_NextState.m_NextWordID = cache->m_State.m_NextWordID + 1;

				if (cache->m_NextState.m_NextWordID >= (cache->m_LineSize >> 2)) {
					// We are done filling in the cache block.
					cache->m_MemReq.m_Control.m_Fields.m_Valid = 0;
					cache->m_NextState.m_State = Cache::State::Idle;
				} else {
					cache->m_MemReq.m_Control.m_Fields.m_Valid = 1;
					cache->m_MemReq.m_Control.m_Fields.m_Size = 2; // == 4 bytes
					cache->m_MemReq.m_Control.m_Fields.m_WriteEnable = 0;
					cache->m_MemReq.m_Addr += 4;
				}
			}
		}
	} else if (state == Cache::State::WriteBack) {
		cpuRes.m_Control.m_Fields.m_Ready = 0;

		// Write back the marked cache line to memory.
		if (cache->m_MemRes.m_Control.m_Fields.m_Ready) {
			const uint32_t setIndex = cache->m_State.m_TargetBlockID / cache->m_NumWays;
			const uint32_t blockIndex = cache->m_State.m_TargetBlockID % cache->m_NumWays;
			CacheSet* set = &cache->m_Sets[setIndex];

			if (!cache->m_MemRes.m_Control.m_Fields.m_Valid) {
				// Can this happen?
				RISCV_CHECK(false, "Invalid memory access during cache line write-back");
			} else {
				uint32_t* cacheLine = (uint32_t*)set->m_Blocks[blockIndex].m_Data;
				cache->m_NextState.m_NextWordID = cache->m_State.m_NextWordID + 1;

				if (cache->m_NextState.m_NextWordID >= (cache->m_LineSize >> 2)) {
					// We are done filling in the cache block.
					cache->m_MemReq.m_Control.m_Fields.m_Valid = 0;
					cache->m_NextState.m_State = cache->m_State.m_StateAfterWriteBack;
				} else {
					cache->m_MemReq.m_Control.m_Fields.m_Valid = 1;
					cache->m_MemReq.m_Control.m_Fields.m_Size = 2;
					cache->m_MemReq.m_Control.m_Fields.m_WriteEnable = 1;
					cache->m_MemReq.m_Addr += 4;
					cache->m_MemReq.m_Data = cacheLine[cache->m_NextState.m_NextWordID];
				}
			}
		}
	} else if (state == Cache::State::Flush) {
		cpuRes.m_Control.m_Fields.m_Ready = 0;

		const uint32_t setIndex = cache->m_State.m_TargetBlockID / cache->m_NumWays;
		const uint32_t blockIndex = cache->m_State.m_TargetBlockID % cache->m_NumWays;
		CacheSet* set = &cache->m_Sets[setIndex];

		const uint32_t blockTag = set->m_Tags[blockIndex];
		const uint32_t tag = blockTag & TAG_VALUE_MASK;
		if ((blockTag & TAG_BIT_VALID) && (blockTag & TAG_BIT_DIRTY) && !(blockTag & TAG_BIT_ERROR)) {
			const uint32_t setIndex = cache->m_State.m_TargetBlockID / cache->m_NumWays;
			const uint32_t* cacheLine = (uint32_t*)set->m_Blocks[blockIndex].m_Data;

			set->m_Tags[blockIndex] &= ~(TAG_BIT_VALID | TAG_BIT_DIRTY);

			cache->m_MemReq.m_Control.m_Fields.m_Valid = 1;
			cache->m_MemReq.m_Control.m_Fields.m_Size = 2;
			cache->m_MemReq.m_Control.m_Fields.m_WriteEnable = 1;
			cache->m_MemReq.m_Addr = (tag << cache->m_TagShift) | (setIndex << cache->m_IndexShift);
			cache->m_MemReq.m_Data = cacheLine[0];

			cache->m_NextState.m_NextWordID = 0;
			cache->m_NextState.m_StateAfterWriteBack = Cache::State::Flush;
			cache->m_NextState.m_State = Cache::State::WriteBack;
		} else {
			if (cache->m_State.m_TargetBlockID == cache->m_NumSets * cache->m_NumWays - 1) {
				cache->m_NextState.m_State = Cache::State::Idle;
			} else {
				cache->m_NextState.m_TargetBlockID = cache->m_State.m_TargetBlockID + 1;
			}
		}
	}

	// Tick
	bx::memCopy(&cache->m_State, &cache->m_NextState, sizeof(Cache::State));
}

void cacheFlush(Cache* cache)
{
	cache->m_NextState.m_State = Cache::State::Flush;
	cache->m_NextState.m_TargetBlockID = 0; // Start scanning all blocks
}
}
