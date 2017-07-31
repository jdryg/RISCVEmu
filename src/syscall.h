#ifndef SYSCALL_H
#define SYSCALL_H

#include <stdint.h>

struct Memory;

// https://github.com/riscv/riscv-pk/blob/f6b2274af4a91763ecdb94600d7d54d5f7f262b5/pk/syscall.h
#define SYS_close 0x39
#define SYS_lseek 0x3E
#define SYS_read  0x3F
#define SYS_write 0x40
#define SYS_fstat 0x50
#define SYS_exit  0x5D
#define SYS_brk   0xD6

int sys_fstat(int fd, uint32_t stAddr);
size_t sys_lseek(int fd, size_t ptr, int dir);
size_t sys_read(int fd, uint32_t bufAddr, size_t n);
size_t sys_write(int fd, uint32_t bufAddr, size_t n);
int sys_close(int fd);
size_t sys_brk(size_t pos);
void sys_exit(int code);

// Internal
void sys__init(Memory* memory, uint32_t initialBreak);
bool sys__isRunning();
int sys__getExitCode();

#endif
