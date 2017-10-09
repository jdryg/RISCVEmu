#include "cache_controller.h"
#include "icache.h"
#include "memory_map.h"
#include "../debug.h"
#include <bx/bx.h>

namespace riscv
{
void cc_Idle(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);
void cc_Lookup(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);
void cc_HitRead(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);
void cc_HitWrite(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);
void cc_Miss(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);
void cc_Allocate(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);
void cc_WriteBack(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);
void cc_Flush(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes);

void ccInit(CacheController* cc, ICache* cache)
{
	cc->m_Cache = cache;
	cc->m_NextState.m_ID = CacheController::State::Idle;
	cc->m_NextState.m_TickCounter = 0;

	bx::memCopy(&cc->m_State, &cc->m_NextState, sizeof(CacheController::State));
}

void ccDestroy(CacheController* cc)
{
	BX_UNUSED(cc);
}

bool ccSimulate(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	CacheController::State::Enum stateID = cc->m_State.m_ID;

	memReqInvalidate(memReq);
	memResInvalidate(cpuRes);

	cc->m_HitBlockID = cc->m_Cache->lookup(cc->m_State.m_LookupAddr + cc->m_State.m_WordByteOffset, cc->m_Tag, cc->m_SetID, cc->m_BlockOffset);

	switch (stateID) {
	case CacheController::State::Idle:
		cc_Idle(cc, cpuReq, cpuRes, memReq, memRes);
		break;
	case CacheController::State::Lookup:
		cc_Lookup(cc, cpuReq, cpuRes, memReq, memRes);
		break;
	case CacheController::State::HitRead:
		cc_HitRead(cc, cpuReq, cpuRes, memReq, memRes);
		break;
	case CacheController::State::HitWrite:
		cc_HitWrite(cc, cpuReq, cpuRes, memReq, memRes);
		break;
	case CacheController::State::Miss:
		cc_Miss(cc, cpuReq, cpuRes, memReq, memRes);
		break;
	case CacheController::State::Allocate:
		cc_Allocate(cc, cpuReq, cpuRes, memReq, memRes);
		break;
	case CacheController::State::WriteBack:
		cc_WriteBack(cc, cpuReq, cpuRes, memReq, memRes);
		break;
	case CacheController::State::Flush:
		cc_Flush(cc, cpuReq, cpuRes, memReq, memRes);
		break;
	}

	cc->m_NextState.m_TickCounter = cc->m_State.m_TickCounter + 1;

	// Stall the CPU if we are either in Flush state or in WriteBack state during a Flush.
	return stateID == CacheController::State::Flush || (stateID == CacheController::State::WriteBack && cc->m_State.m_IDAfterWriteBack == CacheController::State::Flush);
}

void ccTick(CacheController* cc)
{
	// Tick
	bx::memCopy(&cc->m_State, &cc->m_NextState, sizeof(CacheController::State));
}

void ccFlushCache(CacheController* cc)
{
	cc->m_NextState.m_ID = CacheController::State::Flush;
	cc->m_NextState.m_ActiveSetID = 0;
	cc->m_NextState.m_ActiveBlockID = 0;
}

void cc_Idle(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	BX_UNUSED(cpuRes, memReq, memRes);

	cc->m_NextState.m_ID = cpuReq->m_Control.m_Fields.m_Valid 
		? CacheController::State::Lookup
		: CacheController::State::Idle;

	cc->m_NextState.m_LookupAddr = cpuReq->m_Addr;
	cc->m_NextState.m_ReqSize = 1 << cpuReq->m_Control.m_Fields.m_Size;
	cc->m_NextState.m_WordByteOffset = 0;
	cpuRes->m_Data = 0;
}

void cc_Lookup(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	BX_UNUSED(cpuRes, memReq, memRes);

	if (cc->m_HitBlockID != ~0u) {
		// Cache hit.
		const uint32_t tagBits = cc->m_Cache->getBlockTagBits(cc->m_SetID, cc->m_HitBlockID);
		const uint32_t newTagBits = cacheBlockMakeTagBits(cacheBlockGetTag(tagBits), cacheBlockIsValid(tagBits), cacheBlockIsDirty(tagBits) || cpuReq->m_Control.m_Fields.m_WriteEnable, cacheBlockIsError(tagBits));
		cc->m_Cache->setBlockTagBits(cc->m_SetID, cc->m_HitBlockID, newTagBits);

		cc->m_NextState.m_ID = cpuReq->m_Control.m_Fields.m_WriteEnable
			? CacheController::State::HitWrite
			: CacheController::State::HitRead;
	} else {
		// Cache miss.
		cc->m_NextState.m_ID = CacheController::State::Miss;
	}
}

void cc_HitRead(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	BX_UNUSED(cpuReq, memReq, memRes);

	const uint32_t tagBits = cc->m_Cache->getBlockTagBits(cc->m_SetID, cc->m_HitBlockID);

	uint8_t* ptr = ((uint8_t*)&cpuRes->m_Data) + cc->m_State.m_WordByteOffset;
	uint32_t numBytesRead = cc->m_Cache->read(cc->m_SetID, cc->m_HitBlockID, cc->m_BlockOffset, cc->m_State.m_ReqSize, ptr);
	cpuRes->m_Control.m_Fields.m_Ready = numBytesRead == cc->m_State.m_ReqSize;
	cpuRes->m_Control.m_Fields.m_Valid = cacheBlockIsError(tagBits) ? 0 : 1;

	cc->m_NextState.m_ReqSize = cc->m_State.m_ReqSize - numBytesRead;
	cc->m_NextState.m_WordByteOffset += numBytesRead;

	cc->m_NextState.m_ID = numBytesRead == cc->m_State.m_ReqSize
		? CacheController::State::Idle
		: CacheController::State::Lookup;
}

void cc_HitWrite(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	BX_UNUSED(memReq, memRes);

	const uint32_t tagBits = cc->m_Cache->getBlockTagBits(cc->m_SetID, cc->m_HitBlockID);

	uint8_t* ptr = ((uint8_t*)&cpuReq->m_Data) + cc->m_State.m_WordByteOffset;
	uint32_t numBytesWritten = cc->m_Cache->write(cc->m_SetID, cc->m_HitBlockID, cc->m_BlockOffset, cc->m_State.m_ReqSize, ptr);
	cpuRes->m_Control.m_Fields.m_Ready = numBytesWritten == cc->m_State.m_ReqSize;
	cpuRes->m_Control.m_Fields.m_Valid = cacheBlockIsError(tagBits) ? 0 : 1;

	cc->m_NextState.m_ReqSize = cc->m_State.m_ReqSize - numBytesWritten;
	cc->m_NextState.m_WordByteOffset += numBytesWritten;

	cc->m_NextState.m_ID = numBytesWritten == cc->m_State.m_ReqSize
		? CacheController::State::Idle
		: CacheController::State::Lookup;
}

void cc_Miss(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	BX_UNUSED(cpuReq, cpuRes, memRes);

	// NOTE: The search for an empty block will probably be executed in parallel with the tag lookup.
	const uint32_t emptyBlockID = cc->m_Cache->getEmptyBlock(cc->m_SetID);
	const uint32_t randomBlockID = cc->m_State.m_TickCounter % cc->m_Cache->getNumWays();
	const uint32_t victimBlockID = emptyBlockID != ~0u ? emptyBlockID : randomBlockID;

	const uint32_t victimBlockTagBits = cc->m_Cache->getBlockTagBits(cc->m_SetID, victimBlockID);
	const bool needsWriteBack = cacheBlockIsValid(victimBlockTagBits) && cacheBlockIsDirty(victimBlockTagBits);

	uint32_t victimBlockWord;
	if (cc->m_Cache->read(cc->m_SetID, victimBlockID, 0, 4, &victimBlockWord) != 4) {
		RISCV_CHECK(false, "Failed to read word from cache block");
	}

	const uint32_t wordAddr = cc->m_Cache->makeAddress(needsWriteBack 
		? cacheBlockGetTag(victimBlockTagBits) 
		: cc->m_Tag,
		cc->m_SetID,
		0);

	// Prepare memory request
	memReq->m_Addr = wordAddr;
	memReq->m_Data = victimBlockWord;
	memReq->m_Control.m_Fields.m_Size = 2;
	memReq->m_Control.m_Fields.m_WriteEnable = needsWriteBack ? 1 : 0;
	memReq->m_Control.m_Fields.m_Valid = 1;

	// Update the tag
	// NOTE: If the block should be written back to main memory, mark it as invalid at this point and switch to WriteBack 
	// state. Otherwise, mark it as valid and switch to Allocate state. Both WriteBack and Allocate switch to Lookup when
	// they are done. In case of WriteBack, the block will be written to main memory and it'll switch to Lookup. Lookup will
	// still fail, but this time the block has been marked as invalid so there's no need for WriteBack when the next Miss 
	// occurs. This block will be selected as a victim in the second miss.
	// If I wanted to avoid the 2 cycle cost of a Lookup + Miss the second time, the WriteBack stage should be able to update
	// the tag bits when it's done. To keep things simple I decided to do it this way (minimize the points where the tags
	// are updated).
	// 
	// Hope it works like that in the end :)
	cc->m_Cache->setBlockTagBits(cc->m_SetID, victimBlockID, cacheBlockMakeTagBits(needsWriteBack ? cacheBlockGetTag(victimBlockTagBits) : cc->m_Tag, !needsWriteBack, false, false));

	// Switch to next state.
	cc->m_NextState.m_ID = needsWriteBack
		? CacheController::State::WriteBack
		: CacheController::State::Allocate;
	cc->m_NextState.m_IDAfterWriteBack = CacheController::State::Lookup;
	cc->m_NextState.m_ActiveSetID = cc->m_SetID;
	cc->m_NextState.m_ActiveBlockID = victimBlockID;
	cc->m_NextState.m_ActiveBlockOffset = 0;
}

void cc_Allocate(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	BX_UNUSED(cpuReq, cpuRes);

	if (!memRes->m_Control.m_Fields.m_Ready) {
		return;
	}

	const uint32_t activeSetID = cc->m_State.m_ActiveSetID;
	const uint32_t activeBlockID = cc->m_State.m_ActiveBlockID;
	const uint32_t activeBlockTagBits = cc->m_Cache->getBlockTagBits(activeSetID, activeBlockID);
	const uint32_t activeBlockTag = cacheBlockGetTag(activeBlockTagBits);

	if (!memRes->m_Control.m_Fields.m_Valid) {
		// Raise the ERROR bit of the cache line.
		cc->m_Cache->setBlockTagBits(activeSetID, activeBlockID, cacheBlockMakeTagBits(activeBlockTag, true, false, true));
		cc->m_NextState.m_ID = CacheController::State::Lookup;
	} else {
		if (cc->m_Cache->write(activeSetID, activeBlockID, cc->m_State.m_ActiveBlockOffset, 4, &memRes->m_Data) != 4) {
			RISCV_CHECK(false, "Failed to write word to cache block");
		}

		const uint32_t newBlockOffset = cc->m_State.m_ActiveBlockOffset + 4;
		const bool hasMoreWords = newBlockOffset != cc->m_Cache->getBlockSize();
		const uint32_t wordAddr = cc->m_Cache->makeAddress(activeBlockTag, activeSetID, newBlockOffset);

		memReq->m_Addr = wordAddr;
		memReq->m_Control.m_Fields.m_Size = 2;
		memReq->m_Control.m_Fields.m_WriteEnable = 0;
		memReq->m_Control.m_Fields.m_Valid = hasMoreWords ? 1 : 0;

		cc->m_NextState.m_ActiveBlockOffset = newBlockOffset;
		cc->m_NextState.m_ID = hasMoreWords
			? CacheController::State::Allocate
			: CacheController::State::Lookup;
	}
}

void cc_WriteBack(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	BX_UNUSED(cpuReq, cpuRes);

	if (!memRes->m_Control.m_Fields.m_Ready) {
		return;
	}

	const uint32_t activeSetID = cc->m_State.m_ActiveSetID;
	const uint32_t activeBlockID = cc->m_State.m_ActiveBlockID;
	const uint32_t activeBlockTagBits = cc->m_Cache->getBlockTagBits(activeSetID, activeBlockID);
	const uint32_t activeBlockTag = cacheBlockGetTag(activeBlockTagBits);

	if (!memRes->m_Control.m_Fields.m_Valid) {
		// Can this happen? "HW" bug?
		RISCV_CHECK(false, "Invalid memory access during cache line write-back");
	} else {
		const uint32_t newBlockOffset = cc->m_State.m_ActiveBlockOffset + 4;
		const bool hasMoreWords = newBlockOffset != cc->m_Cache->getBlockSize();
		const uint32_t wordAddr = cc->m_Cache->makeAddress(activeBlockTag, activeSetID, newBlockOffset);

		uint32_t val;
		if (cc->m_Cache->read(activeSetID, activeBlockID, newBlockOffset % cc->m_Cache->getBlockSize(), 4, &val) != 4) {
			RISCV_CHECK(false, "Failed to read word from cache block");
		}

		memReq->m_Addr = wordAddr;
		memReq->m_Data = val;
		memReq->m_Control.m_Fields.m_Size = 2;
		memReq->m_Control.m_Fields.m_WriteEnable = 1;
		memReq->m_Control.m_Fields.m_Valid = hasMoreWords ? 1 : 0;

		cc->m_NextState.m_ActiveBlockOffset = newBlockOffset;
		cc->m_NextState.m_ID = hasMoreWords
			? CacheController::State::WriteBack
			: cc->m_State.m_IDAfterWriteBack;
	}
}

void cc_Flush(CacheController* cc, const MemoryRequest* cpuReq, MemoryResponse* cpuRes, MemoryRequest* memReq, const MemoryResponse* memRes)
{
	BX_UNUSED(cpuReq, cpuRes, memRes);

	const uint32_t activeSetID = cc->m_State.m_ActiveSetID;
	const uint32_t activeBlockID = cc->m_State.m_ActiveBlockID;
	const uint32_t activeBlockTagBits = cc->m_Cache->getBlockTagBits(activeSetID, activeBlockID);
	const uint32_t activeBlockTag = cacheBlockGetTag(activeBlockTagBits);

	// Update the tag
	// NOTE: The actual tag remains unchanged. Only the control bits are reset so the next time we end up 
	// in this state the FSM will move on to the next block.
	cc->m_Cache->setBlockTagBits(activeSetID, activeBlockID, cacheBlockMakeTagBits(activeBlockTag, false, false, false));

	if (cacheBlockIsValid(activeBlockTagBits) && cacheBlockIsDirty(activeBlockTagBits) && !cacheBlockIsError(activeBlockTagBits)) {
		// Read 1st word from current block.
		uint32_t val;
		if (cc->m_Cache->read(activeSetID, activeBlockID, 0, 4, &val) != 4) {
			RISCV_CHECK(false, "Failed to read word from cache block");
		}

		const uint32_t wordAddr = cc->m_Cache->makeAddress(activeBlockTag, activeSetID, 0);

		// Prepare memory request
		memReq->m_Addr = wordAddr;
		memReq->m_Data = val;
		memReq->m_Control.m_Fields.m_Size = 2;
		memReq->m_Control.m_Fields.m_WriteEnable = 1;
		memReq->m_Control.m_Fields.m_Valid = 1;

		// Switch to next state.
		cc->m_NextState.m_ID = CacheController::State::WriteBack;
		cc->m_NextState.m_IDAfterWriteBack = CacheController::State::Flush;
		cc->m_NextState.m_ActiveBlockOffset = 0;
	} else {
		// No need for write back. Move on to the next block.
		bool done = false;

		cc->m_NextState.m_ActiveBlockID = activeBlockID + 1;
		cc->m_NextState.m_ActiveSetID = activeSetID;

		if (cc->m_NextState.m_ActiveBlockID == cc->m_Cache->getNumWays()) {
			cc->m_NextState.m_ActiveBlockID = 0;
			cc->m_NextState.m_ActiveSetID = activeSetID + 1;

			if (cc->m_NextState.m_ActiveSetID == cc->m_Cache->getNumSets()) {
				cc->m_NextState.m_ActiveSetID = 0;
				done = true;
			}
		}

		cc->m_NextState.m_ID = done
			? CacheController::State::Idle
			: CacheController::State::Flush;
	}
}
}
