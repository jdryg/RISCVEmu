#include "ram.h"
#include "exception_handler.h"

static volatile int g_RAMTrapTriggered = 0;

uintptr_t ramHandleAccessFault(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
	g_RAMTrapTriggered = 1;
	return epc + 4;
}

int ramInit(RAM* ram, uint32_t baseAddr, uint32_t pageSize)
{
	// memtest
	g_RAMTrapTriggered = 0;
	uint32_t ramSize = 0;
	{
		TrapHandler oldLoadAccessFaultHandler = setTrapHandler(MCAUSE_LOAD_ACCESS_FAULT, ramHandleAccessFault);
		TrapHandler oldStoreAccessFaultHandler = setTrapHandler(MCAUSE_STORE_ACCESS_FAULT, ramHandleAccessFault);
		
		volatile uint32_t dummy = 0;
		volatile uint32_t newValue = 0;
		volatile uint32_t oldValue = 0;

		uint32_t pageAddr = baseAddr;
		while(1) {
			uint32_t endOfPage = pageAddr + pageSize - 4;

			volatile uint32_t* ptr = (uint32_t*)endOfPage;
			oldValue = *ptr;
			if(g_RAMTrapTriggered) {
				break;
			}

			*ptr = oldValue ^ 0x55555555;
			if(g_RAMTrapTriggered) {
				break;
			}

			dummy = oldValue;

			// TODO: Flush cache once we have caches

			newValue = *ptr;
			*ptr = oldValue;

			if(newValue != (oldValue ^ 0x55555555)) {
				break;
			}

			newValue = oldValue ^ 0xAAAAAAAA;

			ramSize += pageSize;
			pageAddr += pageSize;
		}

		setTrapHandler(MCAUSE_LOAD_ACCESS_FAULT, oldLoadAccessFaultHandler);
		setTrapHandler(MCAUSE_STORE_ACCESS_FAULT, oldStoreAccessFaultHandler);
	}

	ram->m_BaseAddr = baseAddr;
	ram->m_PageSize = pageSize;
	ram->m_TotalSize = ramSize;
	ram->m_PageAllocBitmap = (uint32_t*)baseAddr;
	ram->m_PageAllocBitmap[0] |= 0x00000001; // Mark 1st page as allocated (by the Page Allocation Bitmap)

	return 0;
}
