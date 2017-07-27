#include <stdint.h>
#include <stdio.h>
#include <assert.h>
#include <sys/stat.h>

#define EBADF 9

static bool g_SysRunning = false;
static int g_SysExitCode = 0;

int sys_fstat(int fd, void* st)
{
	printf("sys_fstat(%d, %08X)\n", fd, (uint32_t)st);

	int r = -EBADF;
	if (fd == 0 || fd == 1 || fd == 2) {
		r = _fstat32(fd, (struct _stat32*)st);
	} else {
		assert(false); // Unknown file descriptor
	}

	return r;
}

size_t sys_write(int fd, const char* buf, size_t n)
{
	printf("sys_write(%d, %08X, %u)\n", fd, (uint32_t)buf, n);

	size_t r = (size_t)(-EBADF);

	if (fd == 1) {
		r = fwrite(buf, 1, n, stdout);
	} else if (fd == 2) {
		r = fwrite(buf, 1, n, stderr);
	} else {
		assert(false); // Unknown file descriptor.
	}

	return r;
}

int sys_close(int fd)
{
	printf("sys_close(%d)\n", fd);

	if (fd == 0 || fd == 1 || fd == 2) {
		return 0;
	}

	return -EBADF;
}

size_t sys_brk(size_t pos)
{
	printf("sys_brk(%u)\n", pos);
	
	return pos;
}

void sys_exit(int code)
{
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

