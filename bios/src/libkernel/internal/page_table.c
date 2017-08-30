#include "page_table.h"
#include "../memory.h"
#include "../kernel.h" // kassert()
#include "../../devices/ram.h"

#define PAGE_SHIFT 12
#define PAGE_NUMBER_MASK 0xFFFFF000
#define PAGE_OFFSET_MASK 0x00000FFF

void pageTableInit(PageTable* pt, RAM* ram)
{
	pt->m_RAM = ram;
	pt->m_PTE = (PageTableEntry*)ramAllocPage(ram);
	kmemset(pt->m_PTE, 0, sizeof(PageTableEntry) * 1024);
}

int pageTableInsert(PageTable* pt, uint32_t va, uint32_t pa, uint32_t r, uint32_t w, uint32_t x, uint32_t u, uint32_t g)
{
	const uint32_t vpn = (va & PAGE_NUMBER_MASK) >> PAGE_SHIFT;
	const uint32_t vpn0 = vpn & 1023;
	const uint32_t vpn1 = (vpn >> 10) & 1023;

	PageTableEntry* dirPage = &pt->m_PTE[vpn1];
	if(dirPage->m_Valid == 0) {
		// Allocate a page and assign it to this master page table entry.
		uint32_t dirPagePhysicalAddr = (uint32_t)ramAllocPage(pt->m_RAM);
		dirPage->m_Valid = 1;
		dirPage->m_Read = 0;
		dirPage->m_Write = 0;
		dirPage->m_Execute = 0;
		dirPage->m_UserModeAccessible = 0;
		dirPage->m_Global = 0;
		dirPage->m_Accessed = 0;
		dirPage->m_Dirty = 0;
		dirPage->m_RSW = 0;
		dirPage->m_PhysicalPageNumber = (dirPagePhysicalAddr & PAGE_NUMBER_MASK) >> PAGE_SHIFT;

		// Clear the newly allocated page.
		kmemset((PageTableEntry*)dirPagePhysicalAddr, 0, sizeof(PageTableEntry) * 1024);
	}

	const uint32_t dirPagePhysicalAddr = dirPage->m_PhysicalPageNumber << PAGE_SHIFT;
	PageTableEntry* pte = ((PageTableEntry*)dirPagePhysicalAddr) + vpn0;

	kassert(pte->m_Valid == 0, "pageTableInsert(): Tried to allocate an already used page.");

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
	const uint32_t vpn0 = vpn & 1023;
	const uint32_t vpn1 = (vpn >> 10) & 1023;

	PageTableEntry* dirPage = &pt->m_PTE[vpn1];
	if(dirPage->m_Valid == 0) {
		return 0;
	}

	const uint32_t dirPagePhysicalAddr = dirPage->m_PhysicalPageNumber << PAGE_SHIFT;
	PageTableEntry* pte = ((PageTableEntry*)dirPagePhysicalAddr) + vpn0;
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

void pageTableFree(PageTable* pt)
{
	PageTableEntry* pde = pt->m_PTE;
	for(uint32_t i = 0;i < 1024;++i) {
		if(pde->m_Valid) {
			PageTableEntry* dirPage = (PageTableEntry*)(pde->m_PhysicalPageNumber << PAGE_SHIFT);

			PageTableEntry* pte = dirPage;
			for(uint32_t j = 0;j < 1024;++j) {
				if(pte->m_Valid) {
					ramFreePage(pt->m_RAM, (void*)(pte->m_PhysicalPageNumber << PAGE_SHIFT));
				}
				++pte;
			}
			ramFreePage(pt->m_RAM, dirPage);
		}

		++pde;
	}
	ramFreePage(pt->m_RAM, pt->m_PTE);
}
