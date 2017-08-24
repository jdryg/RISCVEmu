#ifndef LIBKERNEL_TASK_H
#define LIBKERNEL_TASK_H

#include <stdint.h>
#include "stdio.h" // PATH_MAX

#define TASK_MAX_FILE_DESCRIPTORS 64

#define FD_TYPE_TTY 0 // default stdin, stdout, stderr
#define FD_TYPE_FILE 1

#define FD_INVALID -1

typedef struct FileDescriptor
{
    void* m_Device; // i.e. FileSystem
    void* m_Data; // i.e. FileSystemFile
    uint8_t m_Type; // i.e. FD_TYPE_FILE
    uint8_t m_IsOpen; // Whether the FD is currently used or not.
} FileDescriptor;

typedef struct Task
{
    FileDescriptor m_FileDesc[TASK_MAX_FILE_DESCRIPTORS];
    char m_CWD[PATH_MAX]; // current working directory
} Task;

void taskInit(Task* task);
void taskShutdown(Task* task);

int taskGetNextFreeFileDescriptor(Task* task);
FileDescriptor* taskAllocFileDescriptor(Task* task, int fd);
void taskFreeFileDescriptor(Task* task, int fd);
FileDescriptor* taskGetFileDescriptor(Task* task, int fd);

int taskGetCurrentWorkingDirectory(Task* task, char* path, size_t maxlen);
void taskSetCurrentWorkingDirectory(Task* task, const char* path);

#endif
