#include "syscall.h"
#include "libkernel/stdio.h"  // kputchar
#include "libkernel/string.h" // kstrlen
#include "libkernel/kernel.h" // kpanic
#include "libkernel/memory.h"
#include "libkernel/task.h"
#include "libkernel/internal/page_table.h"
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>

#if 0
#define systrace(format, args...) kprintf(format, args)
#else
#define systrace(format, args...)
#endif

void sys_exit(int code)
{
	char msg[256];
	ksprintf(msg, "\nProgram exited with code %d\n", code);
	kpanic(msg);
}

void* sys_brk(void* addr)
{
	systrace("sys_brk(%08X)\n", addr);

	Task* task = kgettask();
	if((uint32_t)addr < task->m_HeapStart) {
		return (void*)task->m_ProgramBreak;
	} else if((uint32_t)addr > task->m_HeapEnd) {
		return (void*)task->m_ProgramBreak;
	}

	if((uint32_t)addr > task->m_ProgramBreak) {
		uint32_t memSize = (uint32_t)addr - task->m_ProgramBreak;

		PageTable* pt = taskGetPageTable(task);
		if(pt) {
			// If the requested memory spans multiple pages we have to kmemset
			// each page individually.
			uint32_t vmStart = task->m_ProgramBreak;
			while(memSize > 0) {
				uint32_t pageOffset = vmStart & 0x00000FFF;
				uint32_t vpn = (vmStart & 0xFFFFF000) >> 12;
				uint32_t ppn = pageTableVPN2PPN(pt, vpn);
				kassert(ppn != 0, "sys_brk(): Invalid physical page number");
				uint32_t remainingPageLen = 4096 - pageOffset;
				uint32_t zeroLen = remainingPageLen > memSize ? memSize : remainingPageLen;

				uint32_t physicalAddr = (ppn << 12) | pageOffset;
				kmemset((void*)physicalAddr, 0, zeroLen);

				vmStart += zeroLen;
				memSize -= zeroLen;
			}
		} else {
			kmemset((void*)task->m_ProgramBreak, 0, memSize);
		}
	}

	task->m_ProgramBreak = (uint32_t)addr;

	return addr;
}

static int sys_stub(int err)
{
//	errno = err;
	return -1;
}

int sys_close(int fd)
{
	systrace("sys_close(%d)\n", fd);
	return sys_stub(EBADF);
}

int sys_isatty(int fd)
{
	if (fd == STDOUT_FILENO || fd == STDERR_FILENO || fd == STDIN_FILENO) {
		return 1;
	}

//	errno = EBADF;
	return 0;
}

int sys_fstat(int fd, struct stat* st)
{
	systrace("sys_fstat(%d, 0x%08X)\n", fd, st);

	Task* task = kgettask();
	PageTable* pt = taskGetPageTable(task);
	if(pt) {
		// TODO: What if stat struct spans page boundaries?
		st = (struct stat*)pageTableVA2PA(pt, st);
	}

	if (sys_isatty(fd)) {
		st->st_mode = S_IFCHR;
		return 0;
	}

	return sys_stub(EBADF);
}

off_t sys_lseek(int fd, off_t ptr, int dir)
{
	systrace("sys_lseek(%d, %d, %d)\n", fd, ptr, dir);
	
	if (sys_isatty(fd)) {
		return 0;
	}

	return sys_stub(EBADF);
}

ssize_t sys_read(int fd, void* ptr, size_t len)
{
	systrace("sys_read(%d, 0x%08X, %u)\n", fd, ptr, len);

	// TODO: Address translation of ptr

	if (sys_isatty(fd)) {
		uint8_t* u8ptr = (uint8_t*)ptr;
		size_t l = len;
		while(l--) {
			*u8ptr++ = (uint8_t)kgetchar();
		}
	}

	return sys_stub(EBADF);
}

ssize_t sys_write(int fd, const void* ptr, size_t len)
{
	systrace("sys_write(%d, 0x%08X, %u)\n", fd, ptr, len);

	// Address translation of ptr
	Task* task = kgettask();
	PageTable* pt = taskGetPageTable(task);
	if(pt) {
		// TODO: What if (ptr, len) spans page boundaries.
		ptr = (const void*)pageTableVA2PA(pt, (void*)ptr);
	}

	if (sys_isatty(fd)) {
		uint8_t* u8ptr = (uint8_t*)ptr;
		size_t l = len;
		while(l-- > 0) {
			kputchar((int)(*u8ptr++));
		}

		return len;
	} 

	return sys_stub(EBADF);
}

uintptr_t syscallHandler(uintptr_t syscallID, const uintptr_t* args)
{
	uintptr_t retval = args[0];

	switch(syscallID) {
	case SYSCALL_CLOSE:
		retval = (uintptr_t)sys_close((int)args[0]);
		break;
	case SYSCALL_LSEEK:
		retval = (uintptr_t)sys_lseek((int)args[0], (off_t)args[1], (int)args[2]);
		break;
	case SYSCALL_READ:
		retval = (uintptr_t)sys_read((int)args[0], (void*)args[1], (size_t)args[2]);
		break;
	case SYSCALL_WRITE:
		retval = (uintptr_t)sys_write((int)args[0], (const void*)args[1], (size_t)args[2]);
		break;
	case SYSCALL_FSTAT:
		retval = (uintptr_t)sys_fstat((int)args[0], (struct stat*)args[1]);
		break;
	case SYSCALL_EXIT:
		sys_exit(args[0]);
		break;
	case SYSCALL_BRK:
		retval = (uintptr_t)sys_brk((void*)args[0]);
		break;
	default:
		break;
	}

	return retval;
}
