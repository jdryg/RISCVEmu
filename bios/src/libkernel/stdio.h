#ifndef LIBKERNEL_STDIO_H
#define LIBKERNEL_STDIO_H

#include <stddef.h> // size_t
#include <unistd.h> // ssize_t

// printf.c
int kprintf(const char* fmt, ...);
int ksprintf(char* s, const char *fmt, ...);

// kernel.c
int kputs(const char *str);
int kputchar(int character);
int kgetchar();

// fs.c
#define O_RDONLY	0x0000
#define O_WRONLY	0x0001
#define O_RDWR		0x0002

#define PATH_MAX    256
#define NAME_MAX    256

#ifndef SEEK_SET
#define	SEEK_SET	0
#endif
#ifndef SEEK_CUR
#define	SEEK_CUR	1
#endif
#ifndef SEEK_END
#define	SEEK_END	2
#endif

typedef struct DIR DIR;

typedef struct dirent
{
    void* d_ino; // TODO: This is wrong!
    char d_name[NAME_MAX];
} dirent;

int kmount(const char* source, const char* target, const char* filesystemtype, unsigned long mountflags, const void* data);
DIR* kopendir(const char *name);
int kclosedir(DIR* dirp);
struct dirent* kreaddir(DIR* dirp);
int kchdir(const char* path);
int kopen(const char* path, int flags);
int kclose(int fd);
ssize_t kread(int fd, void *buf, size_t count);
off_t klseek(int fd, off_t offset, int whence);
char* krealpath(const char* path, char* resolved_path);
char* kgetcwd(char* buf, size_t size);

#endif
