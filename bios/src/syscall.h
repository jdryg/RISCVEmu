#ifndef SYSCALL_H
#define SYSCALL_H

#include <sys/types.h>

#define SYSCALL_CLOSE 0x39
#define SYSCALL_LSEEK 0x3E
#define SYSCALL_READ  0x3F
#define SYSCALL_WRITE 0x40
#define SYSCALL_FSTAT 0x50
#define SYSCALL_EXIT  0x5D
#define SYSCALL_BRK   0xD6

void sys_write_hex(int fd, uint32_t hex);
void sys_write_dec(int fd, uint32_t v);
ssize_t sys_write(int fd, const void* ptr, size_t len);
ssize_t sys_read(int fd, void* ptr, size_t len);

void sys_exit(int code);

uintptr_t syscallHandler(uintptr_t syscallID, const uintptr_t* args);

#endif