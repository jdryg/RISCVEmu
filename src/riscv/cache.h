#ifndef RISCV_CACHE_H
#define RISCV_CACHE_H

#include <stdint.h>

namespace riscv
{
struct MemoryMap;

struct CacheState
{
	enum Enum : uint32_t
	{
		Idle,
		CompareTag,
		Allocate,
		WriteBack
	};
};

struct Cache
{
	uint32_t m_LineSize;
	uint32_t m_NumSets;
	uint32_t m_NumWays;
	uint32_t m_OffsetMask;
	uint32_t m_IndexMask;
	uint32_t m_IndexShift;
	uint32_t m_TagMask;
	uint32_t m_TagShift;
	uint32_t m_TargetBlockID; // The global block ID for allocation and write-back states.
	uint32_t m_TargetBlockWordID; // The word inside the target block we are currently reading (write-back) or writing (allocate)
	CacheState::Enum m_State;
	uint32_t* m_Tags;
	uint8_t* m_Data;
};

struct CacheCPUReq
{
	uint32_t m_Addr;
	uint32_t m_Data; // User when writing
	bool m_RW; // false == R, true == W
	bool m_Valid; // Is this request valid
};

struct CacheCPURes
{
	uint32_t m_Data;
	bool m_Ready;
};

struct CacheMemReq
{
	uint32_t m_Addr;
	uint32_t m_Data;
	bool m_RW;
	bool m_Valid;
};

struct CacheMemRes
{
	uint32_t m_Data;
	bool m_Ready;
};

bool cacheInit(Cache* cache, uint32_t lineSize, uint32_t numSets, uint32_t numWays);
void cacheShutdown(Cache* cache);

void cacheTick(Cache* cache, uint32_t randomSource, const CacheCPUReq& in_cpuReq, const CacheMemRes& in_memRes, CacheCPURes& out_cpuRes, CacheMemReq& out_memReq);
}

#endif
