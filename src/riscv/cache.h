#ifndef RISCV_CACHE_H
#define RISCV_CACHE_H

#include <stdint.h>
#include "memory_map.h"

namespace riscv
{
struct CacheBlock
{
	uint8_t* m_Data;
};

struct CacheSet
{
	CacheBlock* m_Blocks;
	uint32_t* m_Tags;
};

struct Cache
{
	CacheSet* m_Sets;
	uint32_t* m__Tags;
	uint8_t* m__Data;
	CacheBlock* m__Blocks;
	uint32_t m_LineSize;
	uint32_t m_NumSets;
	uint32_t m_NumWays;

	uint32_t m_OffsetMask;
	uint32_t m_IndexMask;
	uint32_t m_IndexShift;
	uint32_t m_TagMask;
	uint32_t m_TagShift;

	MemoryRequest m_MemReq;
	MemoryResponse m_MemRes;

	struct State
	{
		enum Enum : uint32_t
		{
			Idle,
			Allocate,
			WriteBack,
			Flush
		};

		Enum m_State;
		uint32_t m_TargetBlockID;
		uint32_t m_NextWordID;
		Enum m_StateAfterWriteBack;
	};

	State m_State;
	State m_NextState;
};

bool cacheInit(Cache* cache, uint32_t lineSize, uint32_t numSets, uint32_t numWays);
void cacheShutdown(Cache* cache);

void cacheTick(Cache* cache, uint32_t randomSrc, const MemoryRequest& cpuReq, MemoryResponse& cpuRes);
void cacheFlush(Cache* cache);
}

#endif
