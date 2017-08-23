#include <stdint.h>
#include "file_system.h"
#include "syscall.h"
#include "libkernel/malloc.h"
#include "libkernel/string.h"
#include "libkernel/memory.h"
#include "libkernel/kernel.h"
#include "libkernel/stdio.h"

#define KEY_LEFT_ARROW 1
#define KEY_RIGHT_ARROW 4
#define KEY_HOME 2
#define KEY_END 3
#define KEY_DELETE 127
#define KEY_BACKSPACE 8
#define KEY_ESCAPE 27
#define KEY_TAB '\t'

#define CONSOLE_COMMAND 0xFF
#define CONSOLE_CMD_DEL_PREV 0
#define CONSOLE_CMD_RAW_OUTPUT 1

typedef struct CmdLine
{
	char* m_Buffer;
	uint32_t m_Size;
	uint32_t m_Capacity;

	char** m_Args;
	uint32_t m_NumArgs;
	uint32_t m_ArgsCapacity;
} CmdLine;

void cmdLineDestroy(CmdLine* cmdLine)
{
	kfree(cmdLine->m_Args);
	cmdLine->m_Args = 0;
	cmdLine->m_NumArgs = 0;
	cmdLine->m_ArgsCapacity = 0;

	kfree(cmdLine->m_Buffer);
	cmdLine->m_Buffer = 0;
	cmdLine->m_Size = 0;
	cmdLine->m_Capacity = 0;
}

void cmdLinePushChar(CmdLine* cmdLine, char c)
{
	if(cmdLine->m_Size == cmdLine->m_Capacity) {
		uint32_t oldCapacity = cmdLine->m_Capacity;
		cmdLine->m_Capacity += 64;
		cmdLine->m_Buffer = (char*)krealloc(cmdLine->m_Buffer, cmdLine->m_Capacity);
		kmemset(&cmdLine->m_Buffer[oldCapacity], 0, 64);
	}

	cmdLine->m_Buffer[cmdLine->m_Size++] = c;
}

void cmdLinePushArg(CmdLine* cmdLine, char* arg)
{
	if(cmdLine->m_NumArgs == cmdLine->m_ArgsCapacity) {
		uint32_t oldCapacity = cmdLine->m_ArgsCapacity;
		cmdLine->m_ArgsCapacity += 8;
		cmdLine->m_Args = (char**)krealloc(cmdLine->m_Args, sizeof(char*) * cmdLine->m_ArgsCapacity);
		kmemset(&cmdLine->m_Args[oldCapacity], 0, sizeof(char*) * 8);
	}

	cmdLine->m_Args[cmdLine->m_NumArgs++] = arg;
}

int isPrintableChar(char c)
{
	return (c >= 32 && c <= 126) ? 1 : 0;
}

char kgetchar()
{
	char c;
	while(!sys_read(0, &c, 1));
	return c;
}

int cmdLineReadStdIn(CmdLine* cmdLine)
{
	cmdLine->m_Size = 0;
	cmdLine->m_NumArgs = 0;

	char k;
    while ((k = kgetchar()) != '\n') {
        if (k == -1) {
            return cmdLine->m_Size;
		}

		if(!isPrintableChar(k)) {
			if(k == KEY_BACKSPACE) {
				// Send "Delete char" command to console.
				if(cmdLine->m_Size != 0) {
					--cmdLine->m_Size;

					uint8_t consoleCmd[3] = {
						CONSOLE_COMMAND,
						CONSOLE_CMD_DEL_PREV,
						1
					};
					sys_write(1, &consoleCmd[0], 3);
				}
			}

			continue;
		}

		// Echo
		// TODO: Q: Should this be handle by the console itself?
		sys_write(1, &k, 1);

		if(cmdLine->m_Size == 0 && k == ' ') {
			continue;
		}

		cmdLinePushChar(cmdLine, k);
    }

	cmdLinePushChar(cmdLine, '\0');

	k = '\n';
	sys_write(1, &k, 1);

	return cmdLine->m_Size - 1; // Size w/o the null terminating char.
}

void cmdLineTokenize(CmdLine* cmdLine)
{
	cmdLine->m_NumArgs = 0;

	if(cmdLine->m_Size <= 1) {
		return;
	}

	char* ptr = cmdLine->m_Buffer;
	cmdLinePushArg(cmdLine, ptr);

	char* space = (char*)kstrchr(ptr, ' ');
	while(space != 0) {
		*space = '\0';

		ptr = ++space;
		cmdLinePushArg(cmdLine, ptr);

		space = (char*)kstrchr(ptr, ' ');
	}
}

// ls
void listDir(FileSystem* fs, const char* dirName)
{
	FileSystemDir* rootDir = fsOpenDir(fs, dirName);
	if (rootDir) {
		FileSystemDirEnt* fsde;
		while ((fsde = fsReadDir(fs, rootDir)) != 0) {
			const uint8_t attrs = fsde->m_DirEntry.m_Attrs;
			char attrStr[6] = "-----";
			if (attrs & ATTR_ARCHIVE)    { attrStr[0] = 'a'; }
			if (attrs & ATTR_DIRECTORY)  { attrStr[1] = 'd'; }
			if (attrs & ATTR_HIDDEN)     { attrStr[2] = 'h'; }
			if (attrs & ATTR_READ_ONLY)  { attrStr[3] = 'r'; }
			if (attrs & ATTR_SYSTEM)     { attrStr[4] = 's'; }

			kprintf("%s %16u %s\n", attrStr, fsde->m_DirEntry.m_FileSize, fsde->m_FilenameLong);
		}

		fsCloseDir(fs, rootDir);
	}
}

// cat
void displayFileContents(FileSystem* fs, const char* filename)
{
	FileSystemFile* file = fsOpenFile(fs, filename, FILE_OPEN_READ | FILE_OPEN_BINARY);
	if(!file) {
		return;
	}

	char buf[516]; // 2 (CONSOLE_COMMAND + CONSOLE_CMD_RAW_OUTPUT) + 2 (raw output length) + 512 bytes
	while(!fsEOF(fs, file)) {
		uint32_t numBytesRead = (uint32_t)fsReadFile(fs, file, &buf[4], 512);

		buf[0] = CONSOLE_COMMAND;
		buf[1] = CONSOLE_CMD_RAW_OUTPUT;
		buf[2] = (uint8_t)numBytesRead & 0x000000FF;
		buf[3] = (uint8_t)((numBytesRead >> 8) & 0x000000FF);

		sys_write(1, &buf[0], numBytesRead + 4);
	}

	fsCloseFile(fs, file);

	char newline = '\n';
	sys_write(1, &newline, 1);
}

int main()
{
	extern FileSystem* g_FS;

	CmdLine cmdLine;
	kmemset(&cmdLine, 0, sizeof(CmdLine));

	while(1) {
		kprintf("> ");
		if(!cmdLineReadStdIn(&cmdLine)) {
			continue;
		}

		cmdLineTokenize(&cmdLine);
		kassert(cmdLine.m_NumArgs != 0, "tokenizeCmdLine() failed");

		const char** argv = (const char**)cmdLine.m_Args;
		const uint32_t argc = cmdLine.m_NumArgs;
		if(!kstrcmp(argv[0], "exit")) {
			break;
		} else if(!kstrcmp(argv[0], "ls")) {
			if(!g_FS) {
				kprintf("No valid file system found.\n");
				continue;
			}

			listDir(g_FS, argc == 1 ? "." : argv[1]);
		} else if(!kstrcmp(argv[0], "cd")) {
			if(!g_FS) {
				kprintf("No valid file system found.\n");
				continue;
			}

			if(argc == 1) {
				kprintf("No folder specified.\n");
				continue;
			}
			
			kprintf("Entering folder \"%s\"...\n", argv[1]);
			if(fsChangeDir(g_FS, argv[1])) {
				kprintf("Folder \"%s\" not found or not a folder.\n", argv[1]);
			}
		} else if(!kstrcmp(argv[0], "cat")) {
			if(!g_FS) {
				kprintf("No valid file system found.\n");
				continue;
			}

			displayFileContents(g_FS, argv[1]);
		} else {
			kprintf("Unknown command: %s\n", argv[0]);
		}
	}

	cmdLineDestroy(&cmdLine);

	return 0;
}
