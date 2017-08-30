#include "kernel.h"
#include "string.h" // kstrlen()
#include "stdio.h" // kprintf
#include "task.h"
#include "malloc.h"
#include "memory.h"
#include "internal/elf.h"
#include "internal/page_table.h"
#include "../devices/uart.h"
#include "../devices/ram.h"
#include "../devices/hdd.h"
#include "../devices/hal.h"

#define PAGE_SIZE                      0x00001000
#define PAGE_SIZE_SHIFT                12
#define PAGE_NUMBER_MASK               0xFFFFF000

#define STACK_BOTTOM                   0x00100000

#define HEAP_START                     0x00080000

#define RAM_BASE_ADDRESS               0x00100000
#define CONSOLE_UART_BASE_ADDRESS      0x80000000
#define HDD_BASE_ADDRESS               0x80001000

#define CONSOLE_COMMAND             0xFF
#define CONSOLE_CMD_DEL_PREV        0
#define CONSOLE_CMD_RAW_OUTPUT      1

UART g_KernelConsoleUART;
RAM g_ExternalRAM;
HDD g_HDD;
Task* g_MainTask = 0;
Task* g_ProgramTask = 0;

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
	uartSend(&g_KernelConsoleUART, (const uint8_t*)str, len);
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
	g_MainTask = taskCreate();

	// Allocate the first 3 file descriptors for stdin, stdout and stderr.
	FileDescriptor* fd_stdin = taskAllocFileDescriptor(g_MainTask, 0);
	fd_stdin->m_Device = &g_KernelConsoleUART;
	fd_stdin->m_Data = 0;
	fd_stdin->m_Type = FD_TYPE_TTY;

	FileDescriptor* fd_stdout = taskAllocFileDescriptor(g_MainTask, 1);
	fd_stdout->m_Device = &g_KernelConsoleUART;
	fd_stdout->m_Data = (void*)1;
	fd_stdout->m_Type = FD_TYPE_TTY;

	FileDescriptor* fd_stderr = taskAllocFileDescriptor(g_MainTask, 2);
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
	if(g_ProgramTask) {
		return g_ProgramTask;
	}

	return g_MainTask;
}

int kexec(const char* path, int argc, char** argv)
{
	kassert(g_ProgramTask == 0, "kexec(): User task already running");

	// Try to open the file for reading.
	int fd = kopen(path, O_RDONLY);
	if(fd == -1) {
		kprintf("(x) kexec(): Failed to open file \"%s\" for reading.\n", path);
		return 0;
	}

	Elf32_Ehdr hdr;
	uint32_t numBytesRead = kread(fd, &hdr, sizeof(Elf32_Ehdr));
	if(numBytesRead < sizeof(Elf32_Ehdr)) {
		kclose(fd);
		kprintf("(x) kexec(): Failed to read %d bytes from file.\n", sizeof(Elf32_Ehdr));
		return 0;
	}

	if(!elfIsRISCV32(&hdr)) {
		kclose(fd);
		kprintf("(x) kexec(): \"%s\" is not a 32-bit RISCV executable.\n");
		return 0;
	}

	// Read all program headers.
	Elf32_Phdr* phdr = (Elf32_Phdr*)kmalloc(sizeof(Elf32_Phdr) * hdr.e_phnum);
	klseek(fd, hdr.e_phoff, SEEK_SET);
	if(kread(fd, phdr, sizeof(Elf32_Phdr) * hdr.e_phnum) != sizeof(Elf32_Phdr) * hdr.e_phnum) {
		kfree(phdr);
		kclose(fd);
		kprintf("(x) kexec(): Failed to read program headers.\n");
		return 0;
	}

	// Allocate a new Task for the new process.
	Task* task = taskCreate();
	kassert(task != 0, "(x) kexec(): Failed to create new Task");

	// Allocate the first 3 file descriptors for stdin, stdout and stderr.
	FileDescriptor* fd_stdin = taskAllocFileDescriptor(task, 0);
	fd_stdin->m_Device = &g_KernelConsoleUART;
	fd_stdin->m_Data = 0;
	fd_stdin->m_Type = FD_TYPE_TTY;

	FileDescriptor* fd_stdout = taskAllocFileDescriptor(task, 1);
	fd_stdout->m_Device = &g_KernelConsoleUART;
	fd_stdout->m_Data = (void*)1;
	fd_stdout->m_Type = FD_TYPE_TTY;

	FileDescriptor* fd_stderr = taskAllocFileDescriptor(task, 2);
	fd_stderr->m_Device = &g_KernelConsoleUART;
	fd_stderr->m_Data = (void*)2;
	fd_stderr->m_Type = FD_TYPE_TTY;
	
	// Allocate a page of RAM for the Page Table and set it to the current Task.
	PageTable* pageTable = (PageTable*)kmalloc(sizeof(PageTable));
	pageTableInit(pageTable, &g_ExternalRAM);
	kassert(pageTable != 0, "(x) kexec(): Not enough memory for page table.");
	taskSetPageTable(task, pageTable);

	for(uint32_t iph = 0;iph < hdr.e_phnum;++iph) {
		const Elf32_Phdr* ph = &phdr[iph];
		if(ph->p_type == PT_LOAD) {
			// Make sure the program header is aligned to page boundaries
			kassert(ph->p_align == PAGE_SIZE, "(x) kexec(): Program header not aligned correctly.");

			// Calculate the number of memory pages required for this header.
			uint32_t numPages = (ph->p_memsz >> PAGE_SIZE_SHIFT) + 1;

			// Allocate pages one at a time and copy the file data to them...
			uint32_t pageVirtualAddress = ph->p_vaddr & PAGE_NUMBER_MASK;
			uint32_t pageOffset = ph->p_vaddr & ((1 << PAGE_SIZE_SHIFT) - 1);
			uint32_t remainingFileSize = ph->p_filesz;
			klseek(fd, ph->p_offset, SEEK_SET);
			while(numPages-- > 0) {
				void* pagePtr = ramAllocPage(&g_ExternalRAM);
				kassert(pagePtr != 0, "(x) kexec(): Not enough memory");

				uint8_t* dst = (uint8_t*)pagePtr + pageOffset;

				// Load the data from the file directly into RAM.
				const uint32_t numBytesToRead = remainingFileSize > PAGE_SIZE ? PAGE_SIZE : remainingFileSize;
				if(numBytesToRead != 0) {
					uint32_t numBytesRead = kread(fd, dst, numBytesToRead);
					kassert(numBytesRead == numBytesToRead, "(x) kexec(): Failed to read correct number of bytes from file.");
				}

				// If there's more room in the current page, zero-initialize the rest...
				if(numBytesToRead < PAGE_SIZE) {
					kmemset(dst + numBytesToRead, 0, PAGE_SIZE - numBytesToRead - pageOffset);
				}

				// Keep the mapping of ph->p_vaddr and the data ptr in the task's page table.
				pageTableInsert(pageTable, pageVirtualAddress, (uint32_t)pagePtr, (ph->p_flags & PF_R) >> PF_R_SHIFT, (ph->p_flags & PF_W) >> PF_W_SHIFT, (ph->p_flags & PF_X) >> PF_X_SHIFT, 1, 0);

				// Move to the next page...
				remainingFileSize -= numBytesToRead;
				pageVirtualAddress += PAGE_SIZE;
				pageOffset = 0;
			}
		}
	}

	kfree(phdr);
	kclose(fd);

	// Allocate 16 pages for the heap
	const uint32_t numHeapPages = 4;
	for(uint32_t i = 0;i < numHeapPages;++i) {
		void* pagePtr = ramAllocPage(&g_ExternalRAM);
		pageTableInsert(pageTable, HEAP_START + PAGE_SIZE * i, (uint32_t)pagePtr, 1, 1, 0, 1, 0);
	}
	task->m_HeapStart = HEAP_START;
	task->m_HeapEnd = HEAP_START + PAGE_SIZE * numHeapPages;
	task->m_ProgramBreak = HEAP_START;

	// Allocate 4 pages for the stack.
	const uint32_t numStackPages = 4;
	for(uint32_t i = 0;i < numStackPages;++i) {
		void* pagePtr = ramAllocPage(&g_ExternalRAM);
		pageTableInsert(pageTable, STACK_BOTTOM + PAGE_SIZE * i, (uint32_t)pagePtr, 1, 1, 0, 1, 0);
	}
	uint32_t stackTop = STACK_BOTTOM + PAGE_SIZE * numStackPages;

	// TODO: Set cwd
	// TODO: Push program arguments to the program stack.
	stackTop -= 4;

	g_ProgramTask = task;

	// Switch to U-mode
	_switchToUMode((uint32_t)pageTable->m_PTE, hdr.e_entry, stackTop, &g_MainTask->m_Frame[0]);

	return 1;
}

int kkill()
{
	kassert(g_ProgramTask != 0, "kkill(): Called when no user task was active.");

	// Deallocate all file descriptors
	taskFreeAllFileDescriptors(g_ProgramTask);

	// Deallocate all allocated RAM pages including the PageTable itself.
	pageTableFree(g_ProgramTask->m_PageTable);
	kfree(g_ProgramTask->m_PageTable);

	// Destroy the task
	taskDestroy(g_ProgramTask);
	g_ProgramTask = 0;

	_switchToMMode(&g_MainTask->m_Frame[0]);

	// Unreachable code
	return 1;
}
