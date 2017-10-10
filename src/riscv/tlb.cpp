#include "tlb.h"
#include "../debug.h"
#include <malloc.h>
#include <bx/bx.h>

namespace riscv
{
bool tlbInit(TLB* tlb, uint32_t numEntries)
{
	tlb->m_Entries = (TLB::Entry*)malloc(sizeof(TLB::Entry) * numEntries);
	if (tlb->m_Entries == nullptr) {
		return false;
	}

	tlb->m_FIFO = (uint32_t*)malloc(sizeof(uint32_t) * numEntries);
	if (tlb->m_FIFO == nullptr) {
		free(tlb->m_Entries);
		tlb->m_Entries = nullptr;
		return false;
	}
	tlb->m_NumEntries = numEntries;

	tlbFlush(tlb);

	return true;
}

void tlbShutdown(TLB* tlb)
{
	free(tlb->m_Entries);
	free(tlb->m_FIFO);
}

void tlbFlush(TLB* tlb)
{
	const uint32_t numEntries = tlb->m_NumEntries;
	for (uint32_t i = 0; i < numEntries; ++i) {
		tlb->m_Entries[i].m_IsValid = false;
		tlb->m_FIFO[i] = ~0u;
	}
}

TLBLookupResult tlbLookup(const TLB* tlb, TLB::virtual_addr_t virtualPageNumber)
{
	const TLB::Entry* entries = tlb->m_Entries;
	const TLB::Entry* matchedEntry = nullptr;
	const uint32_t n = tlb->m_NumEntries;
	for (uint32_t i = 0; i < n; ++i, ++entries) {
		if (entries->m_IsValid && entries->m_Tag == virtualPageNumber) {
			RISCV_CHECK(matchedEntry == nullptr, "TLB Lookup: Multiple entries match the given VPN");
			matchedEntry = entries;

#if !RISCV_CONFIG_DEBUG
			// NOTE: Don't break in order to be able to check the TLB for errors (i.e. multiple matches)
			break;
#endif
		}
	}

	TLBLookupResult res;
	res.m_Hit = matchedEntry != nullptr;
	res.m_PhysicalFrameNumber = matchedEntry != nullptr ? matchedEntry->m_Data : 0;
	res.m_ProtectionFlags = matchedEntry != nullptr ? matchedEntry->m_ProtectionFlags : 0;
	return res;
}

void tlbInsert(TLB* tlb, TLB::virtual_addr_t virtualPageNumber, TLB::physical_addr_t physicalPageNumber, uint32_t protectionFlags)
{
	// Find the TLB entry to insert the new translation.

	uint32_t invalidEntryID = ~0u;
	uint32_t replacementEntryID = ~0u;
	bool selInvalid = false;

	// Step 1a: Search for an invalid entry
	// HW: The loop below could be implemented using a priority encoder which takes as input
	// the valid bits of all the entries and returns the invalid entry with the lowest index.
	{
		TLB::Entry* entries = tlb->m_Entries;
		const uint32_t n = tlb->m_NumEntries;
		for (uint32_t i = 0; i < n; ++i, ++entries) {
			if (!entries->m_IsValid) {
				// Found an invalid entry
				invalidEntryID = i;
				selInvalid = true;
				break;
			}
		}
	}

	// Step 1b: Replace the entry at the top of the FIFO queue
	// HW: FIFO Queue
	{
		replacementEntryID = tlb->m_FIFO[0];
	}

	// HW: MUX
	uint32_t targetEntryID = selInvalid ? invalidEntryID : replacementEntryID;

	// Step 2a: Update the selected entry
	{
		RISCV_CHECK(targetEntryID != ~0u, "TLB Insert: Failed to find a TLB entry to replace.");

		TLB::Entry* targetEntry = &tlb->m_Entries[targetEntryID];
		targetEntry->m_Tag = virtualPageNumber;
		targetEntry->m_Data = physicalPageNumber;
		targetEntry->m_IsValid = true;
		targetEntry->m_ProtectionFlags = protectionFlags;
	}

	// Step 2b: Update the FIFO queue.
	if (!selInvalid) {
		bx::memMove(&tlb->m_FIFO[0], &tlb->m_FIFO[1], sizeof(uint32_t) * (tlb->m_NumEntries - 1));
		tlb->m_FIFO[tlb->m_NumEntries - 1] = targetEntryID;
	}
}
}
