#include "kernel.h"
#include "string.h" // kstrlen()
#include "stdio.h" // kprintf
#include "task.h"
#include "../devices/uart.h"
#include "../devices/ram.h"
#include "../devices/hdd.h"

#define PAGE_SIZE                      0x00001000
#define RAM_BASE_ADDRESS               0x00100000
#define CONSOLE_UART_BASE_ADDRESS      0x80000000
#define HDD_BASE_ADDRESS               0x80001000

#define CONSOLE_COMMAND             0xFF
#define CONSOLE_CMD_DEL_PREV        0
#define CONSOLE_CMD_RAW_OUTPUT      1

UART g_KernelConsoleUART;
RAM g_ExternalRAM;
HDD g_HDD;
Task g_MainTask;

static const char* s_KernelPanicMsg = 0;

int kputchar(int character)
{
	uint8_t c = (uint8_t)character;
	uartSend(&g_KernelConsoleUART, &c, 1);
}

int kgetchar()
{
	uint8_t c;
	while(!uartRead(&g_KernelConsoleUART, &c, 1));
	return (int)c;
}

int kputs(const char* str)
{
	const uint8_t lf = '\n';

	size_t len = kstrlen(str);
	uartSend(&g_KernelConsoleUART, (const uint8_t*)str, len + 1);
	uartSend(&g_KernelConsoleUART, &lf, 1);
}

void kconsoleDelPrevChars(uint32_t n)
{
	kassert(n < 256, "Console: Max amount of chars to delete is 255");

	uint8_t consoleCmd[3] = {
		CONSOLE_COMMAND,
		CONSOLE_CMD_DEL_PREV,
		(uint8_t)n
	};
	uartSend(&g_KernelConsoleUART, &consoleCmd[0], 3);
}

void kconsoleRawOutput(const uint8_t* buf, uint32_t len)
{
	kassert(len < 65536, "Console: Raw output max buffer size is 65535");

	char cmd[4];
	cmd[0] = CONSOLE_COMMAND;
	cmd[1] = CONSOLE_CMD_RAW_OUTPUT;
	cmd[2] = (uint8_t)(len & 0x000000FF);
	cmd[3] = (uint8_t)((len >> 8) & 0x000000FF);
	uartSend(&g_KernelConsoleUART, &cmd[0], 4);
	uartSend(&g_KernelConsoleUART, buf, len);
}

void kpanic(const char* msg)
{
	s_KernelPanicMsg = msg; // Just in case console hasn't been initialized yet.
	kputs(msg);
	while(1);
}

void kinit()
{
	uartInit(&g_KernelConsoleUART, CONSOLE_UART_BASE_ADDRESS);

	kputs("Booting TinyKernel v1.0...");

	kputs("Initializing External RAM...");
	ramInit(&g_ExternalRAM, RAM_BASE_ADDRESS, PAGE_SIZE);
	kprintf("(i) Size: %uKB\n", g_ExternalRAM.m_TotalSize >> 10);

	kputs("Initializing HDD...");
	int hddErr = hddInit(&g_HDD, HDD_BASE_ADDRESS);
	if(hddErr == HDD_SUCCESS) {
		const uint32_t numPartitions = hddGetNumPartitions(&g_HDD);
		kassert(numPartitions != 0, "No initialized partitions found");

		for(uint32_t i = 0;i < numPartitions;++i) {
			const uint32_t partitionSize = hddGetPartitionSize(&g_HDD, i);
			kprintf("(i) Partition #%u: %uKB\n", i, partitionSize >> 10);
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
		kprintf("(x) Error (%d): %s\n", hddErr, msg);
	}

	// Initialize main task.
	taskInit(&g_MainTask);

	// Allocate the first 3 file descriptors for stdin, stdout and stderr.
	FileDescriptor* fd_stdin = taskAllocFileDescriptor(&g_MainTask, 0);
	fd_stdin->m_Device = &g_KernelConsoleUART;
	fd_stdin->m_Data = 0;
	fd_stdin->m_Type = FD_TYPE_TTY;

	FileDescriptor* fd_stdout = taskAllocFileDescriptor(&g_MainTask, 1);
	fd_stdout->m_Device = &g_KernelConsoleUART;
	fd_stdout->m_Data = (void*)1;
	fd_stdout->m_Type = FD_TYPE_TTY;

	FileDescriptor* fd_stderr = taskAllocFileDescriptor(&g_MainTask, 2);
	fd_stderr->m_Device = &g_KernelConsoleUART;
	fd_stderr->m_Data = (void*)2;
	fd_stderr->m_Type = FD_TYPE_TTY;
}

void kshutdown()
{
	// TODO: Close stdin/stdout and stderr
	// TODO: Shutdown main task
	// TODO: Destroy all mount points.
}

struct Task* kgettask()
{
	// TODO: return the actual current task.
	return &g_MainTask;
}
