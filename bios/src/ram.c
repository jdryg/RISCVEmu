#include "ram.h"
#include "exception_handler.h"

uintptr_t handleAccessFault(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
    return epc + 4;
}

int ramInit(RAM* ram, uint32_t baseAddr, uint32_t pageSize)
{
    // memtest
    uint32_t ramSize = 0;
    {
        TrapHandler oldLoadAccessFaultHandler = setTrapHandler(MCAUSE_LOAD_ACCESS_FAULT, handleAccessFault);
        TrapHandler oldStoreAccessFaultHandler = setTrapHandler(MCAUSE_STORE_ACCESS_FAULT, handleAccessFault);
        
        volatile uint32_t dummy = 0;
        volatile uint32_t newValue = 0;
        volatile uint32_t oldValue = 0;

        uint32_t pageAddr = baseAddr;
        while(1) {
            uint32_t endOfPage = pageAddr + pageSize - 4;

            volatile uint32_t* ptr = (uint32_t*)endOfPage;
            oldValue = *ptr;
            *ptr = oldValue ^ 0x55555555;
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

    return 0;
}
