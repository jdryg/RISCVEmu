#ifndef RISCV_TLB_H
#define RISCV_TLB_H

#include <stdint.h>

namespace riscv
{
struct TLB
{
	typedef uint32_t physical_addr_t;
	typedef uint32_t virtual_addr_t;

	struct Entry
	{
		virtual_addr_t m_Tag; // M-R bits, where M is the virtual memory size and R is the page size
		physical_addr_t m_Data; // N-R bits, where N is the physical memory size (in bits) and R is the page size
		uint32_t m_ProtectionFlags; // 3 bits (RWX)
		bool m_IsValid; // 1 bit
	};

	Entry* m_Entries;
	uint32_t* m_FIFO;
	uint32_t m_NumEntries;
};

struct TLBLookupResult
{
	TLB::physical_addr_t m_PhysicalFrameNumber;
	uint32_t m_ProtectionFlags;
	bool m_Hit;
};

bool tlbInit(TLB* tlb, uint32_t numEntries);
void tlbShutdown(TLB* tlb);
TLBLookupResult tlbLookup(const TLB* tlb, TLB::virtual_addr_t virtualPageNumber);
void tlbInsert(TLB* tlb, TLB::virtual_addr_t virtualPageNumber, TLB::physical_addr_t physicalPageNumber, uint32_t protectionFlags);
void tlbFlush(TLB* tlb);
}

#endif
