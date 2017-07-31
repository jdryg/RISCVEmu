#include "syscall.h"
#include "memory.h"
#include "debug.h"
#include <stdio.h>
#include <assert.h>
#include <sys/stat.h>
#include <io.h>

#ifndef TRACE_SYSCALLS
#	define TRACE_SYSCALLS 1
#endif

#define EBADF 9

static bool g_SysRunning = false;
static int g_SysExitCode = 0;
static Memory* g_SysMemory = nullptr;
static uint32_t g_SysInitialBreak = 0;
static uint32_t g_SysCurrentBreak = 0;

int sys_fstat(int fd, uint32_t stAddr)
{
#if TRACE_SYSCALLS
	RISCV_TRACE("sys_fstat(%d, %08Xh)", fd, stAddr);
#endif

	uint8_t* st = memVirtualToPhysical(g_SysMemory, stAddr);

	int r = -EBADF;
	if (fd >= 0 && fd <= 2) {
		r = _fstat32(fd, (struct _stat32*)st);
	} else {
		RISCV_CHECK(false, "Unknown file descriptor %d", fd);
	}

	return r;
}

size_t sys_lseek(int fd, size_t ptr, int dir)
{
#if TRACE_SYSCALLS
	RISCV_TRACE("sys_lseek(%d, %u, %d)", fd, (uint32_t)ptr, dir);
#endif

	size_t r = (size_t)(-EBADF);

	if (fd >= 0 && fd <= 2) {
		r = _lseek(fd, (long)ptr, dir);
	} else {
		RISCV_CHECK(false, "Unknown file descriptor %d", fd);
	}

	return r;
}

size_t sys_read(int fd, uint32_t bufAddr, size_t n)
{
#if TRACE_SYSCALLS
	RISCV_TRACE("sys_read(%d, %08Xh, %u)", fd, bufAddr, n);
#endif

	uint8_t* buf = memVirtualToPhysical(g_SysMemory, bufAddr);

	size_t r = (size_t)(-EBADF);

	if (fd >= 0 && fd <= 2) {
		r = _read(fd, buf, (uint32_t)n);
	} else {
		RISCV_CHECK(false, "Unknown file descriptor %d", fd);
	}

	return r;
}

size_t sys_write(int fd, uint32_t bufAddr, size_t n)
{
#if TRACE_SYSCALLS
	RISCV_TRACE("sys_write(%d, %08Xh, %u)", fd, bufAddr, n);
#endif

	const uint8_t* buf = memVirtualToPhysical(g_SysMemory, bufAddr);

	size_t r = (size_t)(-EBADF);

	if (fd >= 0 && fd <= 2) {
		r = _write(fd, buf, (uint32_t)n);
	} else {
		RISCV_CHECK(false, "Unknown file descriptor %d", fd);
	}

	return r;
}

int sys_close(int fd)
{
#if TRACE_SYSCALLS
	RISCV_TRACE("sys_close(%d)", fd);
#endif

	int r = -EBADF;
	if (fd >= 0 && fd <= 2) {
//		r = _close(fd);
		r = 0;
	} else {
		RISCV_CHECK(false, "Unknown file descriptor %d", fd);
	}

	return r;
}

size_t sys_brk(size_t addr)
{
#if TRACE_SYSCALLS
	RISCV_TRACE("sys_brk(%08Xh)", addr);
#endif

	if (addr < g_SysInitialBreak) {
		return g_SysInitialBreak;
	} else if (addr >= g_SysMemory->m_Size) {
		return g_SysCurrentBreak;
	}

	if (addr > g_SysCurrentBreak) {
		uint8_t* data = memVirtualToPhysical(g_SysMemory, g_SysCurrentBreak);
		bx::memSet(data, 0, (uint32_t)addr - g_SysCurrentBreak);

		memExpandOrAddRegion(g_SysMemory, g_SysInitialBreak, (uint32_t)addr - g_SysCurrentBreak, RegionFlags::Read | RegionFlags::Write);
	}

	g_SysCurrentBreak = (uint32_t)addr;

	return addr;
}

void sys_exit(int code)
{
#if TRACE_SYSCALLS
	RISCV_TRACE("sys_exit(%d)", code);
#endif

	g_SysRunning = false;
	g_SysExitCode = code;
}

// Internal
void sys__init(Memory* mem, uint32_t initialBreak)
{
	g_SysMemory = mem;
	g_SysInitialBreak = initialBreak;
	g_SysCurrentBreak = initialBreak;
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

