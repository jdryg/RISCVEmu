#include "stdio.h"
#include "string.h"
#include "kernel.h"
#include "memory.h"
#include "malloc.h"
#include "task.h"
#include "internal/file_system.h"
#include "../devices/hdd.h"

extern HDD g_HDD;

struct DIR
{
	dirent m_DirEnt;
	FileSystem* m_FS;
	FileSystemDir* m_Dir;
};

// TODO: Move mount points into the current Task? 
// I don't plan on implementing fork() to start a new process (it's a single-process OS)
// so having the mount points global to the whole system, make task initialization easier.
typedef struct MountPoint
{
	char* m_Target;
	uint32_t m_TargetLen;
	FileSystem* m_FileSystem;
} MountPoint;

MountPoint* g_MountPoints = 0;
uint32_t g_NumMountPoints = 0;

MountPoint* _getPathMountPoint(const char* path);

int kmount(const char* source, const char* target, const char* filesystemtype, unsigned long mountflags, const void* data)
{
	kassert(!kstrncmp(source, "/dev/sda", 8), "kmount(): Only '/dev/sdaX' sources are supported");
	kassert(!kstrcmp(filesystemtype, "auto"), "kmount(): Only 'auto' file system type is supported");

	// TODO: Check if target is already used and depending on mountflags either remount or fail.

	// Get the partition number out of the source
	// NOTE: In order to avoid writing an atoi/strtol function I'll do it this way :)
	uint32_t partitionID = ~0u;
	if(!kstrcmp(source, "/dev/sda1")) {
		partitionID = 0;
	} else if(!kstrcmp(source, "/dev/sda2")) {
		partitionID = 1;
	} else if(!kstrcmp(source, "/dev/sda3")) {
		partitionID = 2;
	} else if(!kstrcmp(source, "/dev/sda4")) {
		partitionID = 3;
	} else {
		// Invalid source (only 4 partitions per HDD)
		return -1;
	}

	kassert(partitionID != ~0u, "kmount(): Failed to identify partition number");

	PartitionTableEntry* pte = hddGetPartitionTableEntry(&g_HDD, partitionID);
	FileSystem* fs = fsInit(&g_HDD, pte);
	if(!fs) {
		return -1;
	}

	// Create a new mount point.
	++g_NumMountPoints;
	g_MountPoints = (MountPoint*)krealloc(g_MountPoints, sizeof(MountPoint) * g_NumMountPoints);
	kassert(g_MountPoints != 0, "kmount(): Failed to allocate new mount point.");

	// Initialize the mount point.
	MountPoint* mp = &g_MountPoints[g_NumMountPoints - 1];
	mp->m_Target = kstrdup(target);
	mp->m_TargetLen = kstrlen(target);
	mp->m_FileSystem = fs;

	return 0;
}

DIR* kopendir(const char* path)
{
	// Convert path to absolute path
	char absPath[PATH_MAX];
	if(!krealpath(path, absPath)) {
		// TODO: errno?
		return 0;
	}

	// Find the corresponding mount point.
	MountPoint* mp = _getPathMountPoint(absPath);
	if(!mp) {
		return 0;
	}

	// Get the mount-point-relative part of the absolute path
	const uint32_t absPathLen = (uint32_t)kstrlen(absPath);
	const uint32_t copyLen = absPathLen - (mp->m_TargetLen - 1);
	char mpRelPath[PATH_MAX];
	kmemcpy(&mpRelPath[0], &absPath[mp->m_TargetLen - 1], copyLen);
	mpRelPath[copyLen] = '\0';

	// Open the file using fsOpen()
	FileSystemDir* dir = fsOpenDir(mp->m_FileSystem, mpRelPath);
	if(!dir) {
		return 0;
	}

	DIR* d = (DIR*)kmalloc(sizeof(DIR));
	d->m_FS = mp->m_FileSystem;
	d->m_Dir = dir;
	return d;
}

int kclosedir(DIR* dir)
{
	if(!dir) {
		return -1;
	}

	fsCloseDir(dir->m_FS, dir->m_Dir);
	kfree(dir);

	return 0;
}

struct dirent* kreaddir(DIR* dir)
{
	FileSystemDirEnt* de = fsReadDir(dir->m_FS, dir->m_Dir);
	if(!de) {
		return 0;
	}

	dir->m_DirEnt.d_ino = de; // TODO: d_ino should be some kind of serial number for the file!
	kmemcpy(dir->m_DirEnt.d_name, de->m_FilenameLong, 256);

	return &dir->m_DirEnt;
}

int kchdir(const char* path)
{
	char absPath[PATH_MAX];
	if(!krealpath(path, absPath)) {
		// TODO: errno?
		return -1;
	}

	taskSetCurrentWorkingDirectory(kgettask(), absPath);

	return 0;
}

int kopen(const char* path, int flags)
{
	// Convert path to absolute path
	char absPath[PATH_MAX];
	if(!krealpath(path, absPath)) {
		// TODO: errno?
		return -1;
	}

	// Find the corresponding mount point.
	MountPoint* mp = _getPathMountPoint(absPath);
	if(!mp) {
		return -1;
	}

	// Get the mount-point-relative part of the absolute path
	const uint32_t absPathLen = (uint32_t)kstrlen(absPath);
	const uint32_t copyLen = absPathLen - (mp->m_TargetLen - 1);
	char mpRelPath[PATH_MAX];
	kmemcpy(&mpRelPath[0], &absPath[mp->m_TargetLen - 1], copyLen);
	mpRelPath[copyLen] = '\0';

	// Open the file using fsOpen()
	FileSystemFile* file = fsOpenFile(mp->m_FileSystem, mpRelPath, flags);
	if(!file) {
		return -1;
	}

	// Allocate a file descriptor for this file.
	int fd = taskGetNextFreeFileDescriptor(kgettask());
	if(fd == FD_INVALID) {
		// Failed to allocate file descriptor.
		fsCloseFile(mp->m_FileSystem, file);
		return -1;
	}

	FileDescriptor* fileDesc = taskAllocFileDescriptor(kgettask(), fd);
	fileDesc->m_Device = mp->m_FileSystem;
	fileDesc->m_Data = file;
	fileDesc->m_Type = FD_TYPE_FILE;
	
	return fd;
}

int kclose(int fd)
{
	FileDescriptor* desc = taskGetFileDescriptor(kgettask(), fd);
	if(!desc) {
		return -1;
	}

	int err = fsCloseFile(desc->m_Device, desc->m_Data);

	taskFreeFileDescriptor(kgettask(), fd);

	return err;
}

ssize_t kread(int fd, void *buf, size_t count)
{
	FileDescriptor* desc = taskGetFileDescriptor(kgettask(), fd);
	if(!desc) {
		return -1;
	}

	return fsReadFile(desc->m_Device, desc->m_Data, buf, count);
}

off_t klseek(int fd, off_t offset, int whence)
{
	FileDescriptor* desc = taskGetFileDescriptor(kgettask(), fd);
	if(!desc) {
		return -1;
	}

	return fsSeekFile(desc->m_Device, desc->m_Data, offset, whence);
}

// NOTE: Only FAT16 is supported at the moment which doesn't support symbolic links.
// So this function has nothing to do with the actual file system. What it does is
// to strip ./ and ../ from the path and convert it to an absolute path (if it doesn't
// start with /).
// In other words, it should not fail if the path doesn't not exist. No checking is 
// performed during conversion.
// TODO: Bounds checking on both paths
char* krealpath(const char* path, char* resolved_path)
{
	int allocated = 0;
	if (!resolved_path) {
		resolved_path = (char*)kmalloc(PATH_MAX);
		allocated = 1;
	}

	const char* src = path;
	char* dst = resolved_path;

	// Check if path is absolute (starts with '/')
	if (*src == '/') {
		*dst++ = *src++;
		*dst = '\0';

		// If path is the root path, we are done.
		if (*src == '\0') {
			return resolved_path;
		}
	} else {
		// This is a relative path. Read the current working directory 
		// (which is an absolute path) into resolved_path.
		if (!kgetcwd(dst, PATH_MAX)) {
			// Something terrible happened
			kassert(0, "krealpath(): kgetcwd() failed");
			return 0; // unreachable code
		}

		dst += kstrlen(dst);

		// We haven't read anything from path yet so src stays put.
	}

	if ((size_t)(src - path) >= PATH_MAX ||
		(size_t)(dst - resolved_path) >= PATH_MAX) {
		// TODO: errno = ENAMETOOLONG;
		if (allocated) {
			kfree(resolved_path);
		}

		return 0;
	}

	while (src && *src != '\0') {
		const char* nextSlash = kstrchr(src, '/');
		size_t fragmentLen = nextSlash != 0 ? (nextSlash - src) : kstrlen(src);

		// Make sure the currently resolved path ends with a slash.
		if (*(dst - 1) != '/') {
			*dst++ = '/';
			*dst = '\0';
		}

		if (fragmentLen == 0) {
			// Multiple successive slashes. Nothing to do.
			src = nextSlash ? nextSlash + 1 : 0;
			continue;
		} else if (fragmentLen == 1 && *src == '.') {
			// "./" inside the path. Nothing to do.
			src = nextSlash ? nextSlash + 1 : 0;
			continue;
		} else if (fragmentLen == 2 && src[0] == '.' && src[1] == '.') {
			// "../" inside the path. Strip the last resolved fragment
			// (unless resolved_path contains only the a single slash)
			if ((size_t)(dst - resolved_path) > 1) {
				// Search resolved_path backwards and put a null char after the previous slash
				*(--dst) = '\0';
				while (*dst != '/' && dst > resolved_path) {
					--dst;
				}
				*(++dst) = '\0';
			}

			src = nextSlash ? nextSlash + 1 : 0;
			continue;
		}

		// Copy the fragment to resolved_path
		kmemcpy(dst, src, fragmentLen);
		dst += fragmentLen;
		src = nextSlash ? nextSlash + 1 : 0;
	}

	*dst = '\0';

	return resolved_path;
}

char* kgetcwd(char* buf, size_t size)
{
	if(taskGetCurrentWorkingDirectory(kgettask(), buf, size) == -1) {
		return 0;
	}

	return buf;
}

MountPoint* _getPathMountPoint(const char* path)
{
	MountPoint* mp = 0;

	const uint32_t n = g_NumMountPoints;
	for(uint32_t i = 0;i < n;++i) {
		MountPoint* cmp = &g_MountPoints[i];
		if(!kstrncmp(path, cmp->m_Target, cmp->m_TargetLen)) {
			// path starts with the mount points target. If we already found a 
			// mount point (mp != 0), check which one of the two has the longest 
			// target. 
			if(!mp || (mp && mp->m_TargetLen < cmp->m_TargetLen)) {
				mp = cmp;
			}
		}
	}

	return mp;
}
