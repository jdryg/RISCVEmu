#include <stdint.h>
#include <stdlib.h>
#include <stddef.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <stdio.h>
#include <string.h>
#include "syscall.h"
#include "uart.h"

#undef errno
int errno;

UART g_ConsoleUART;

void sys_write_hex(int fd, uint32_t hex)
{
	uint8_t i, j;
	char towrite;
	
	sys_write(fd, "0x", 2);
	for (i = 8 ; i > 0; i--) {
		j = i - 1;

		uint8_t digit = ((hex & (0xF << (j * 4))) >> (j * 4));
		towrite = digit < 0xA ? ('0' + digit) : ('A' +  (digit - 0xA));
		sys_write(fd, &towrite, 1);
	}
}

void sys_write_dec(int fd, uint32_t v)
{
	uint32_t len = 1;

	/* count needed characters */
	for (uint32_t tmp = v; (tmp > 9); ++len) {
		tmp /= 10;
	}

	char str[64]; // Should be enough :)
	char* ptr = &str[len - 1];
	do {
		uint8_t c = (v % 10) + '0';
		*ptr-- = c;
	} while ((v /= 10));

	sys_write(fd, str, len);
}

void sys_exit(int code)
{
	const char * message = "\nProgram exited with code: ";
	
	sys_write(STDERR_FILENO, message, strlen(message));
	sys_write_hex(STDERR_FILENO, code);

	while (1);
}

void* sys_brk(void* addr)
{
	sys_write(1, "sys_brk(", 8);
	sys_write_hex(1, (uint32_t)addr);
	sys_write(1, ") = ", 4);
/*
	extern char _end[];
	extern char _heap_end[];
	static char* curbrk = _end;

	if ((char*)addr < _heap_end) {
		sys_write_hex(1, (uint32_t)curbrk);
		sys_write(1, "\n", 1);
		return curbrk;
	} else if ((char*)addr >= _heap_end) {
		sys_write_hex(1, (uint32_t)curbrk);
		sys_write(1, "\n", 1);
		return curbrk;
	}

	if ((char*)addr > curbrk) {
		memset(curbrk, 0, (uint32_t)((char*)addr - curbrk));
	}

	curbrk = addr;

	sys_write_hex(1, (uint32_t)curbrk);
	sys_write(1, "\n", 1);
*/
	return addr;
}

static int sys_stub(int err)
{
	errno = err;
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

	errno = EBADF;
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
		return uartRead(&g_ConsoleUART, (uint8_t*)ptr, len);
	}

	return sys_stub(EBADF);
}

ssize_t sys_write(int fd, const void* ptr, size_t len)
{
	const uint8_t* current = (const uint8_t*)ptr;
	size_t jj;
	if (sys_isatty(fd)) {
		for (jj = 0; jj < len; jj++) {
			uartSend(&g_ConsoleUART, current + jj, 1);
			if (current[jj] == '\n') {
				uartSend(&g_ConsoleUART, "\r", 1);
			}
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
