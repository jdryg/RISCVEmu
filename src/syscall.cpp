#include <stdint.h>
#include <stdio.h>
#include <assert.h>
#include <sys/stat.h>
#include <io.h>

#ifndef TRACE_SYSCALLS
#	define TRACE_SYSCALLS 0
#endif

#define EBADF 9

static bool g_SysRunning = false;
static int g_SysExitCode = 0;

int sys_fstat(int fd, void* st)
{
#if TRACE_SYSCALLS
	printf("sys_fstat(%d, %08X)\n", fd, (uint32_t)st);
#endif

	int r = -EBADF;
	if (fd >= 0 && fd <= 2) {
		r = _fstat32(fd, (struct _stat32*)st);
	} else {
		assert(false); // Unknown file descriptor
	}

	return r;
}

size_t sys_lseek(int fd, size_t ptr, int dir)
{
#if TRACE_SYSCALLS
	printf("sys_lseek(%d, %u, %d)\n", fd, (uint32_t)ptr, dir);
#endif

	size_t r = (size_t)(-EBADF);

	if (fd >= 0 && fd <= 2) {
		r = _lseek(fd, (long)ptr, dir);
	} else {
		assert(false);
	}

	return r;
}

size_t sys_read(int fd, char* buf, size_t n)
{
#if TRACE_SYSCALLS
	printf("sys_read(%d, %08X, %u)\n", fd, (uint32_t)buf, n);
#endif

	size_t r = (size_t)(-EBADF);

	if (fd >= 0 && fd <= 2) {
		r = _read(fd, buf, (uint32_t)n);
	} else {
		assert(false);
	}

	return r;
}

size_t sys_write(int fd, const char* buf, size_t n)
{
#if TRACE_SYSCALLS
	printf("sys_write(%d, %08X, %u)\n", fd, (uint32_t)buf, n);
#endif

	size_t r = (size_t)(-EBADF);

	if (fd >= 0 && fd <= 2) {
		r = _write(fd, buf, (uint32_t)n);
	} else {
		assert(false); // Unknown file descriptor.
	}

	return r;
}

int sys_close(int fd)
{
#if TRACE_SYSCALLS
	printf("sys_close(%d)\n", fd);
#endif

	int r = -EBADF;
	if (fd >= 0 && fd <= 2) {
//		r = _close(fd);
		r = 0;
	}

	return r;
}

size_t sys_brk(size_t addr)
{
#if TRACE_SYSCALLS
	printf("sys_brk(%08X)\n", addr);
#endif

	// TODO: ???
	
	return addr;
}

void sys_exit(int code)
{
#if TRACE_SYSCALLS
	printf("sys_exit(%d)\n", code);
#endif

	g_SysRunning = false;
	g_SysExitCode = code;
}

// Internal
void sys__init()
{
	g_SysRunning = true;
	g_SysExitCode = 0;
}

bool sys__isRunning()
{
	return g_SysRunning;
}

int sys__getExitCode()
{
	return g_SysExitCode;
}

