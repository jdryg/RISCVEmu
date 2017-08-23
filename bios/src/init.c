#include <stdint.h>
#include "file_system.h"
#include "devices/uart.h" // uartInit()
#include "devices/ram.h" // ramInit()
#include "devices/hdd.h" // hddInit()
#include "libkernel/kernel.h" // kinit()
#include "libkernel/stdio.h" // kprintf()/kputs()

#define PAGE_SIZE                      0x00001000

#define RAM_BASE_ADDRESS               0x00100000
#define HDD_BASE_ADDRESS               0x80001000

RAM g_RAM;
HDD g_HDD;
FileSystem* g_FS;

void _init()
{
	kinit();

	// Initialize RAM
	kputs("Initializing RAM...");
	ramInit(&g_RAM, RAM_BASE_ADDRESS, PAGE_SIZE);
	kprintf("- Size: %u bytes\n", g_RAM.m_TotalSize);

	// Initialize HDD
	kputs("Initializing HDD...");
	int hddErr = hddInit(&g_HDD, HDD_BASE_ADDRESS);
	if(hddErr == HDD_SUCCESS) {
		const uint32_t numPartitions = hddGetNumPartitions(&g_HDD);
		kassert(numPartitions != 0, "No initialized partitions found");

		for(uint32_t i = 0;i < numPartitions;++i) {
			const uint32_t partitionSize = hddGetPartitionSize(&g_HDD, i);
			kprintf("- Partition #%u: %u bytes\n", i, partitionSize);
		}

		kputs("Initializing file system (partition #0)");
		g_FS = fsInit(&g_HDD, hddGetPartitionTableEntry(&g_HDD, 0));
		if(g_FS == 0) {
			kputs("(x) Failed to initialize file system");
		}
	} else {
		const char* msg = "Unknown Error";
		if(hddErr == HDD_ERROR_NOT_CONNECTED) {
			msg = "Not connected";
		} else if(hddErr == HDD_ERROR_NO_MBR) {
			msg = "No MBR found";
		} else if(hddErr == HDD_ERROR_NO_PARTITIONS) {
			msg = "No partitions found";
		} else if(hddErr == HDD_ERROR_INIT_PARTITION) {
			msg = "Failed to initialize partition";
		}
		kprintf("- Error (%d): %s\n", hddErr, msg);
	}

	extern int main();
	int res = main();

	// Shutdown.
	if(g_FS) {
		kputs("Shutting down file system");
		fsShutdown(g_FS);
		g_FS = 0;
	}

	kpanic("HALT");
}
