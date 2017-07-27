#ifndef SYSCALL_H
#define SYSCALL_H

// https://github.com/riscv/riscv-pk/blob/f6b2274af4a91763ecdb94600d7d54d5f7f262b5/pk/syscall.h
#define SYS_close 0x39
#define SYS_write 0x40
#define SYS_fstat 0x50
#define SYS_exit  0x5D
#define SYS_brk   0xD6

int sys_fstat(int fd, void* st);
size_t sys_write(int fd, const char* buf, size_t n);
int sys_close(int fd);
size_t sys_brk(size_t pos);
void sys_exit(int code);

// Internal
void sys__init();
bool sys__isRunning();
int sys__getExitCode();

#endif
