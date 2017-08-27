#include "task.h"
#include "memory.h"
#include "malloc.h"
#include "string.h"

Task* taskCreate()
{
    Task* task = (Task*)kmalloc(sizeof(Task));
    kmemset(task, 0, sizeof(Task));
    return task;
}

void taskDestroy(Task* task)
{
    kfree(task);
}

int taskGetNextFreeFileDescriptor(Task* task)
{
    for(uint32_t i = 0;i < TASK_MAX_FILE_DESCRIPTORS; ++i) {
        if(!task->m_FileDesc[i].m_IsOpen) {
            return i;
        }
    }

    return FD_INVALID;
}

FileDescriptor* taskAllocFileDescriptor(Task* task, int fd)
{
    if(fd == FD_INVALID || fd >= TASK_MAX_FILE_DESCRIPTORS) {
        return 0;
    }

    FileDescriptor* desc = &task->m_FileDesc[fd];
    if(desc->m_IsOpen) {
        return 0; // Cannot reopen opened fd.
    }

    desc->m_IsOpen = 1;

    return desc;
}

void taskFreeFileDescriptor(Task* task, int fd)
{
    if(fd == FD_INVALID || fd >= TASK_MAX_FILE_DESCRIPTORS) {
        return; // error?
    }

    FileDescriptor* desc = &task->m_FileDesc[fd];
    if(!desc->m_IsOpen) {
        return; // error?
    }

    desc->m_IsOpen = 0;
}

void taskFreeAllFileDescriptors(Task* task)
{
    // Nothing meaningful to do here at the moment.
    // TODO: If I implement writing to files, this is a good place to flush any 
    // pending writes to disk.
}

FileDescriptor* taskGetFileDescriptor(Task* task, int fd)
{
    if(fd == FD_INVALID || fd >= TASK_MAX_FILE_DESCRIPTORS) {
        return 0;
    }

    FileDescriptor* desc = &task->m_FileDesc[fd];
    if(!desc->m_IsOpen) {
        // Cannot access unused fd
        return 0;
    }

    return desc;
}

int taskGetCurrentWorkingDirectory(Task* task, char* path, size_t maxLen)
{
    size_t pathLen = kstrlen(task->m_CWD);
    if(pathLen >= maxLen) {
        return -1;
    }

    kmemcpy(path, task->m_CWD, pathLen);
    path[pathLen] = '\0';

    return pathLen;
}

void taskSetCurrentWorkingDirectory(Task* task, const char* path)
{
    size_t pathLen = kstrlen(path);
    size_t copyLen = pathLen < PATH_MAX ? pathLen : (PATH_MAX - 1);
    kmemcpy(task->m_CWD, path, copyLen);
    task->m_CWD[copyLen] = '\0';
}

void taskSetPC(Task* task, uint32_t pc)
{
    task->m_PC = pc;
}

void taskSetPageTable(Task* task, PageTable* pt)
{
    task->m_PageTable = pt;
}

PageTable* taskGetPageTable(Task* task)
{
    return task->m_PageTable;
}
