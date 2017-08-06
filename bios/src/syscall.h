#ifndef SYSCALL_H
#define SYSCALL_H

#define SYSCALL_CLOSE 0x39
#define SYSCALL_LSEEK 0x3E
#define SYSCALL_READ  0x3F
#define SYSCALL_WRITE 0x40
#define SYSCALL_FSTAT 0x50
#define SYSCALL_EXIT  0x5D
#define SYSCALL_BRK   0xD6

void write_hex(int fd, uint32_t hex);
ssize_t write(int fd, const void* ptr, size_t len);

uintptr_t syscallHandler(uintptr_t syscallID, const uintptr_t* args);

#endif