#include <stdint.h>
#include "file_system.h"
#include "syscall.h"
#include "cmd_line.h"
#include "libkernel/malloc.h"
#include "libkernel/string.h"
#include "libkernel/memory.h"
#include "libkernel/kernel.h"
#include "libkernel/stdio.h"
#include "libkernel/ctype.h"

extern FileSystem* g_FS;

typedef int(*BuildInCommandFunc)(int argc, char** argv);

typedef struct BuildInCommand
{
	const char* m_Name;
	BuildInCommandFunc m_Func;
} BuildInCommand;

int cmdExit(int argc, char** argv);
int cmdListDirectoryContents(int argc, char** argv);
int cmdChangeWorkingDirectory(int argc, char** argv);
int cmdDisplayFileContents(int argc, char** argv);

BuildInCommand g_BuildInCommands[] = {
	{ "exit", cmdExit },
	{ "ls", cmdListDirectoryContents },
	{ "cd", cmdChangeWorkingDirectory },
	{ "cat", cmdDisplayFileContents }
};
const uint32_t kNumBuildInCommands = sizeof(g_BuildInCommands) / sizeof(BuildInCommand);

// ls
int cmdListDirectoryContents(int argc, char** argv)
{
	const char* dirName = argc <= 1 ? "." : argv[1];

	FileSystemDir* rootDir = fsOpenDir(g_FS, dirName);
	if (rootDir) {
		FileSystemDirEnt* fsde;
		while ((fsde = fsReadDir(g_FS, rootDir)) != 0) {
			const uint8_t attrs = fsde->m_DirEntry.m_Attrs;
			char attrStr[6] = "-----";
			if (attrs & ATTR_ARCHIVE)    { attrStr[0] = 'a'; }
			if (attrs & ATTR_DIRECTORY)  { attrStr[1] = 'd'; }
			if (attrs & ATTR_HIDDEN)     { attrStr[2] = 'h'; }
			if (attrs & ATTR_READ_ONLY)  { attrStr[3] = 'r'; }
			if (attrs & ATTR_SYSTEM)     { attrStr[4] = 's'; }

			kprintf("%s %16u %s\n", attrStr, fsde->m_DirEntry.m_FileSize, fsde->m_FilenameLong);
		}

		fsCloseDir(g_FS, rootDir);
	}

	return 1;
}

// cat
int cmdDisplayFileContents(int argc, char** argv)
{
	if(argc <= 1) {
		kputs("(x) Expected argument to command 'cat'\n");
	} else {
		FileSystemFile* file = fsOpenFile(g_FS, argv[1], FILE_OPEN_READ | FILE_OPEN_BINARY);
		if(!file) {
			kprintf("(x) Failed to open \"%s\" for reading\n", argv[1]);
		} else {
			char buf[512];
			while(!fsEOF(g_FS, file)) {
				uint32_t numBytesRead = (uint32_t)fsReadFile(g_FS, file, &buf[0], 512);
				kconsoleRawOutput(&buf[0], numBytesRead);
			}

			fsCloseFile(g_FS, file);

			kputchar('\n');
		}
	}

	return 1;
}

// cd
int cmdChangeWorkingDirectory(int argc, char** argv)
{
	if(argc <= 1) {
		kputs("Error: Expected argument to command 'cd'\n");
	} else {
		fsChangeDir(g_FS, argv[1]);
	}

	return 1;
}

// exit
int cmdExit(int argc, char** argv)
{
	return 0;
}

int executeCommandLine(CmdLine* cmdLine)
{
	char** argv = cmdLine->m_Args;
	int argc = (int)cmdLine->m_NumArgs;

	for(uint32_t i = 0; i < kNumBuildInCommands; ++i) {
		if(!kstrcmp(argv[0], g_BuildInCommands[i].m_Name)) {
			return g_BuildInCommands[i].m_Func(argc, argv);
		}
	}

	// TODO: exec() cmdline as user-mode program.

	return 1;
}

int main()
{
	CmdLine cmdLine;
	cmdLineInit(&cmdLine);

	int status = 1;
	while(status) {
		kprintf("> ");
		if(!cmdLineReadStdIn(&cmdLine)) {
			continue;
		}

		cmdLineTokenize(&cmdLine);
		kassert(cmdLine.m_NumArgs != 0, "cmdLineTokenize() failed");

		status = executeCommandLine(&cmdLine);
	}

	cmdLineDestroy(&cmdLine);

	return 0;
}
