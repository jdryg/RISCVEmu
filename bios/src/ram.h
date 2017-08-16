#ifndef RAM_H
#define RAM_H

#include <stdint.h>

typedef struct RAM_t
{
	uint32_t m_BaseAddr;
	uint32_t m_PageSize;
	uint32_t m_TotalSize;
	uint32_t* m_PageAllocBitmap; // 1 bit per page. 1 page (4k bytes)for the bitmap == 128MB max memory
} RAM;

int ramInit(RAM* ram, uint32_t baseAddr, uint32_t pageSize);

#endif
