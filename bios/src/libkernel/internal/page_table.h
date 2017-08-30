#ifndef LIBKERNEL_INTERNAL_PAGE_TABLE_H
#define LIBKERNEL_INTERNAL_PAGE_TABLE_H

#include <stdint.h>

typedef struct RAM RAM;

typedef struct PageTableEntry
{
	uint32_t m_Valid : 1;
	uint32_t m_Read : 1;
	uint32_t m_Write : 1;
	uint32_t m_Execute : 1;
	uint32_t m_UserModeAccessible : 1;
	uint32_t m_Global : 1;
	uint32_t m_Accessed : 1;
	uint32_t m_Dirty : 1;
	uint32_t m_RSW : 2;
	uint32_t m_PhysicalPageNumber : 22;
} __attribute__((packed)) PageTableEntry;

typedef struct PageTable
{
	RAM* m_RAM;
    PageTableEntry* m_PTE;
} PageTable;

void pageTableInit(PageTable* pt, RAM* ram);
int pageTableInsert(PageTable* pt, uint32_t va, uint32_t pa, uint32_t r, uint32_t w, uint32_t x, uint32_t u, uint32_t g);

uint32_t pageTableVPN2PPN(PageTable* pt, uint32_t vpn);
void* pageTableVA2PA(PageTable* pt, void* va);

void pageTableFree(PageTable* pt);

#endif
