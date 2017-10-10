#ifndef RISCV_CACHE_H
#define RISCV_CACHE_H

#include <stdint.h>

namespace riscv
{
struct Cache;

Cache* cacheCreate(uint32_t numSets, uint32_t numWays, uint32_t blockSize);
void cacheDestroy(Cache* cache);

uint32_t cacheLookup(Cache* cache, uint32_t addr, uint32_t& tag, uint32_t& setID, uint32_t& blockOffset);
uint32_t cacheRead(Cache* cache, uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, void* data);
uint32_t cacheWrite(Cache* cache, uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, const void* data);
uint32_t cacheGetBlockTagBits(Cache* cache, uint32_t setID, uint32_t blockID);
void cacheSetBlockTagBits(Cache* cache, uint32_t setID, uint32_t blockID, uint32_t tagBits);
uint32_t cacheGetEmptyBlock(Cache* cache, uint32_t setID);
uint32_t cacheMakeAddress(Cache* cache, uint32_t tag, uint32_t setID, uint32_t blockOffset);
uint32_t cacheGetNumSets(Cache* cache);
uint32_t cacheGetNumWays(Cache* cache);
uint32_t cacheGetBlockSize(Cache* cache);

//////////////////////////////////////////////////////////////////////////
// Helpers
//
inline bool cacheBlockIsValid(uint32_t tagBits)
{
	return (tagBits & 0x80000000) != 0;
}

inline bool cacheBlockIsDirty(uint32_t tagBits)
{
	return (tagBits & 0x40000000) != 0;
}

inline bool cacheBlockIsError(uint32_t tagBits)
{
	return (tagBits & 0x20000000) != 0;
}

inline uint32_t cacheBlockGetTag(uint32_t tagBits)
{
	return tagBits & 0x0FFFFFFF;
}

inline uint32_t cacheBlockMakeTagBits(uint32_t tag, bool valid, bool dirty, bool err)
{
	return (tag & 0x0FFFFFFF) | (valid ? 0x80000000 : 0) | (dirty ? 0x40000000 : 0) | (err ? 0x20000000 : 0);
}
}

#endif
