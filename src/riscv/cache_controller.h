#ifndef RISCV_CACHE_CONTROLLER_H
#define RISCV_CACHE_CONTROLLER_H

#include <stdint.h>

namespace riscv
{
struct MemoryRequest;
struct MemoryResponse;
struct Cache;

struct CacheController
{
	struct State
	{
		enum Enum : uint32_t
		{
			Idle,
			Lookup,
			HitRead,
			HitWrite,
			Miss,
			Allocate,
			WriteBack,
			Flush
		};

		Enum m_ID;
		Enum m_IDAfterWriteBack; // Needed because we might end up in WriteBack from Miss or from Flush. 
		uint32_t m_TickCounter;
		uint32_t m_LookupAddr;
		uint32_t m_ReqSize;
		uint32_t m_WordByteOffset;
		uint32_t m_ActiveSetID;
		uint32_t m_ActiveBlockID;
		uint32_t m_ActiveBlockOffset;
	};

	Cache* m_Cache;
	State m_State;
	State m_NextState;

	// Combinational signals
	uint32_t m_HitBlockID;
	uint32_t m_Tag;
	uint32_t m_SetID;
	uint32_t m_BlockOffset;
};

void ccInit(CacheController* cc, Cache* cache);
void ccDestroy(CacheController* cc);

// NOTE: Returns true if the CPU should stall. Otherwise false.
bool ccSimulate(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);
void ccFlushCache(CacheController* cc);

void ccTick(CacheController* cc);
}

#endif
