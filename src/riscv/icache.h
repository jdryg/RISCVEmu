#ifndef RISCV_ICACHE_H
#define RISCV_ICACHE_H

#include <stdint.h>

namespace riscv
{
class ICache
{
public:
	virtual ~ICache()
	{}

	virtual uint32_t lookup(uint32_t addr, uint32_t& tag, uint32_t& setID, uint32_t& blockOffset) = 0;
	virtual uint32_t read(uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, void* data) = 0;
	virtual uint32_t write(uint32_t setID, uint32_t blockID, uint32_t blockOffset, uint32_t n, const void* data) = 0;
	virtual uint32_t getBlockTagBits(uint32_t setID, uint32_t blockID) = 0;
	virtual void setBlockTagBits(uint32_t setID, uint32_t blockID, uint32_t tagBits) = 0;
	virtual uint32_t getEmptyBlock(uint32_t setID) = 0;
	virtual uint32_t makeAddress(uint32_t tag, uint32_t setID, uint32_t blockOffset) = 0;
	virtual uint32_t getNumSets() = 0;
	virtual uint32_t getNumWays() = 0;
	virtual uint32_t getBlockSize() = 0;
};

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
