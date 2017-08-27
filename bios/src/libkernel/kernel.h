#ifndef LIBKERNEL_KERNEL_H
#define LIBKERNEL_KERNEL_H

#include <stdint.h>

void kinit();
void kshutdown();

void kpanic(const char* msg);

void kconsoleDelPrevChars(uint32_t n);
void kconsoleRawOutput(const uint8_t* buf, uint32_t len);

struct Task* kgettask();

int kexec(const char* path, int argc, char** argv);
int kkill(); // Kills the one and only user mode task.

#define kassert(expr, msg) do { if(!(expr)) { kpanic(msg); } } while(0);

#endif
