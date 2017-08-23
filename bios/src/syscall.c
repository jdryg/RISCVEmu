#include "syscall.h"
#include "libkernel/stdio.h" // kputchar
#include "libkernel/string.h" // kstrlen
#include "libkernel/kernel.h" // kpanic
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>

void sys_exit(int code)
{
	char msg[256];
	ksprintf(msg, "\nProgram exited with code %d\n", code);
	kpanic(msg);
}

void* sys_brk(void* addr)
{
	kprintf("sys_brk(%08X)\n", addr);
/*
	extern char _end[];
	extern char _heap_end[];
	static char* curbrk = _end;

	if ((char*)addr < _heap_end) {
		return curbrk;
	} else if ((char*)addr >= _heap_end) {
		return curbrk;
	}

	if ((char*)addr > curbrk) {
		memset(curbrk, 0, (uint32_t)((char*)addr - curbrk));
	}

	curbrk = addr;
*/
	return addr;
}

static int sys_stub(int err)
{
//	errno = err;
	return -1;
}

int sys_close(int fd)
{
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

int sys_fstat(int fd, struct stat *st)
{
	if (sys_isatty(fd)) {
		st->st_mode = S_IFCHR;
		return 0;
	}

	return sys_stub(EBADF);
}

off_t sys_lseek(int fd, off_t ptr, int dir)
{
	if (sys_isatty(fd)) {
		return 0;
	}

	return sys_stub(EBADF);
}

ssize_t sys_read(int fd, void* ptr, size_t len)
{
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
