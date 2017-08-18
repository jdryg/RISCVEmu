#include <stdint.h>
#include "syscall.h" // sys_write()
#include "uart.h" // uartInit()
#include "ram.h" // ramInit()
#include "hdd.h" // hddInit()
#include "libkernel/printf.h" // kprintfInit()/kprintf()

#define PAGE_SIZE                      0x00001000

#define RAM_BASE_ADDRESS               0x00100000
#define CONSOLE_UART_BASE_ADDRESS      0x80000000
#define HDD_BASE_ADDRESS               0x80001000

static RAM g_RAM;
static HDD g_HDD;

static void printf_putc(void* userData, char c)
{
	sys_write(1, &c, 1);
}

void _init()
{
	// Initialize console UART
	extern UART g_ConsoleUART;
	uartInit(&g_ConsoleUART, CONSOLE_UART_BASE_ADDRESS);

	kprintfInit(0, printf_putc);

	// Initialize RAM
	kprintf("Initializing RAM...\n");
	ramInit(&g_RAM, RAM_BASE_ADDRESS, PAGE_SIZE);
	kprintf("- Size: %u bytes\n", g_RAM.m_TotalSize);

	// Initialize HDD
	kprintf("Initializing HDD...\n", 20);
	int hddErr = hddInit(&g_HDD, HDD_BASE_ADDRESS);
	if(hddErr == HDD_SUCCESS) {
		const uint32_t numPartitions = hddGetNumPartitions(&g_HDD);
		for(uint32_t i = 0;i < numPartitions;++i) {
			const uint32_t partitionSize = hddGetPartitionSize(&g_HDD, i);
			kprintf("- Partition #%u: %u bytes\n", i, partitionSize);
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
	sys_exit(main());
}
