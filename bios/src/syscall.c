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

void write_hex(int fd, uint32_t hex)
{
    uint8_t i, j;
    char towrite;
    
    write(fd, "0x", 2);
    for (i = 8 ; i > 0; i--) {
        j = i - 1;

        uint8_t digit = ((hex & (0xF << (j * 4))) >> (j * 4));
        towrite = digit < 0xA ? ('0' + digit) : ('A' +  (digit - 0xA));
        write(fd, &towrite, 1);
    }
}

void _exit(int code)
{
    const char * message = "\nProgram exited with code: ";
    
    write(STDERR_FILENO, message, strlen(message));
    write_hex(STDERR_FILENO, code);

    while (1);
}

void* brk(void* addr)
{
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

	return addr;
}

static int stub(int err)
{
    errno = err;
    return -1;
}

int close(int fd)
{
    return stub(EBADF);
}

int fstat(int fd, struct stat *st)
{
    if (isatty(fd)) {
        st->st_mode = S_IFCHR;
        return 0;
    }

    return stub(EBADF);
}

int isatty(int fd)
{
    if (fd == STDOUT_FILENO || fd == STDERR_FILENO || fd == STDIN_FILENO) {
        return 1;
    }

    errno = EBADF;
    return 0;
}

off_t lseek(int fd, off_t ptr, int dir)
{
    if (isatty(fd)) {
        return 0;
    }

    return stub(EBADF);
}

ssize_t read(int fd, void* ptr, size_t len)
{
    if (isatty(fd)) {
        return uartRead(&g_ConsoleUART, (uint8_t*)ptr, len);
    }

    return stub(EBADF);
}

ssize_t write(int fd, const void* ptr, size_t len)
{
    const uint8_t* current = (const uint8_t*)ptr;
    size_t jj;
    if (isatty(fd)) {
        for (jj = 0; jj < len; jj++) {
            uartSend(&g_ConsoleUART, current + jj, 1);
            if (current[jj] == '\n') {
                uartSend(&g_ConsoleUART, "\r", 1);
            }
        }

        return len;
    } 
  
    return stub(EBADF);
}

uintptr_t syscallHandler(uintptr_t syscallID, const uintptr_t* args)
{
    uintptr_t retval = args[0];

    switch(syscallID) {
    case SYSCALL_CLOSE:
        retval = (uintptr_t)close((int)args[0]);
        break;
    case SYSCALL_LSEEK:
        retval = (uintptr_t)lseek((int)args[0], (off_t)args[1], (int)args[2]);
        break;
    case SYSCALL_READ:
        retval = (uintptr_t)read((int)args[0], (void*)args[1], (size_t)args[2]);
        break;
    case SYSCALL_WRITE:
        retval = (uintptr_t)write((int)args[0], (const void*)args[1], (size_t)args[2]);
        break;
    case SYSCALL_FSTAT:
        retval = (uintptr_t)fstat((int)args[0], (struct stat*)args[1]);
        break;
    case SYSCALL_EXIT:
        _exit(args[0]);
        break;
    case SYSCALL_BRK:
        retval = (uintptr_t)brk((void*)args[0]);
        break;
    default:
        break;
    }

    return retval;
}
