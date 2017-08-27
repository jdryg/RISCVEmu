#include "page_table.h"
#include "../memory.h"
#include "../kernel.h" // kassert()

#define PAGE_SHIFT 12
#define PAGE_NUMBER_MASK 0xFFFFF000
#define PAGE_OFFSET_MASK 0x00000FFF

// TODO: Pass the RAM device instead and let the PageTable allocate as much RAM 
// as it needs (e.g. in case I decide to implement a 2-level PT);
PageTable* pageTableInit(void* mem)
{
    if(!mem) {
        return 0;
    }

    PageTable* pt = (PageTable*)mem;
    kmemset(pt->m_PTE, 0, sizeof(PageTableEntry) * 1024);

    return pt;
}

int pageTableInsert(PageTable* pt, uint32_t va, uint32_t pa, uint32_t r, uint32_t w, uint32_t x, uint32_t u, uint32_t g)
{
//    kprintf("ptInsert(%08X, %08X, %u, %u, %u)\n", va, pa, r, w, x);

    uint32_t vpn = (va & PAGE_NUMBER_MASK) >> PAGE_SHIFT;

    PageTableEntry* pte = &pt->m_PTE[vpn & 1023];
    kassert(pte->m_Valid == 0, "pageTableInsert(): Tried to allocate an already used page. 2-level page table is required.");

	pte->m_Valid = 1;
	pte->m_Read = r;
	pte->m_Write = w;
	pte->m_Execute  = x;
	pte->m_UserModeAccessible = u;
	pte->m_Global = g;
	pte->m_Accessed = 0;
	pte->m_Dirty = 0;
	pte->m_RSW = 0;
	pte->m_PhysicalPageNumber = (pa & PAGE_NUMBER_MASK) >> PAGE_SHIFT;

    return 1;
}

uint32_t pageTableVPN2PPN(PageTable* pt, uint32_t vpn)
{
    PageTableEntry* pte = &pt->m_PTE[vpn & 1023];
    if(pte->m_Valid == 0) {
        return 0;
    }

    return pte->m_PhysicalPageNumber;
}

void* pageTableVA2PA(PageTable* pt, void* va)
{
    uint32_t vpn = ((uint32_t)va & PAGE_NUMBER_MASK) >> PAGE_SHIFT;
    uint32_t offset = (uint32_t)va & PAGE_OFFSET_MASK;

    uint32_t ppn = pageTableVPN2PPN(pt, vpn);
    if(ppn == 0) {
        return 0;
    }

    return (void*)((ppn << PAGE_SHIFT) | offset);
}
