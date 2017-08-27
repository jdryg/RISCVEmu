#include <stdint.h>
#include "cmd_line.h"
#include "libkernel/malloc.h"
#include "libkernel/string.h"
#include "libkernel/memory.h"
#include "libkernel/kernel.h"
#include "libkernel/stdio.h"
#include "libkernel/ctype.h"

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

	DIR* rootDir = kopendir(dirName);
	if (rootDir) {
		struct dirent* fsde;
		while ((fsde = kreaddir(rootDir)) != 0) {
//			const uint8_t attrs = fsde->m_DirEntry.m_Attrs;
//			char attrStr[6] = "-----";
//			if (attrs & ATTR_ARCHIVE)    { attrStr[0] = 'a'; }
//			if (attrs & ATTR_DIRECTORY)  { attrStr[1] = 'd'; }
//			if (attrs & ATTR_HIDDEN)     { attrStr[2] = 'h'; }
//			if (attrs & ATTR_READ_ONLY)  { attrStr[3] = 'r'; }
//			if (attrs & ATTR_SYSTEM)     { attrStr[4] = 's'; }
//
//			kprintf("%s %16u %s\n", attrStr, fsde->m_DirEntry.m_FileSize, fsde->m_FilenameLong);

			kprintf("%s\n", fsde->d_name);
		}

		kclosedir(rootDir);
	}

	return 1;
}

// cat
int cmdDisplayFileContents(int argc, char** argv)
{
	if(argc <= 1) {
		kputs("(x) Expected argument to command 'cat'\n");
	} else {
		int fd = kopen(argv[1], O_RDONLY);
		if(fd == -1) {
			kprintf("(x) Failed to open \"%s\" for reading\n", argv[1]);
		} else {
			char buf[512];
			uint32_t numBytesRead = (uint32_t)kread(fd, &buf[0], 512);
			while(numBytesRead) {
				kconsoleRawOutput(&buf[0], numBytesRead);

				numBytesRead = (uint32_t)kread(fd, &buf[0], 512);
			}

			kclose(fd);

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
		kchdir(argv[1]);
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

	if(!kexec(argv[0], argc, argc > 1 ? &argv[1] : 0)) {
		kprintf("(x) Unknown command \"%s\"\n", argv[0]);
	}

	return 1;
}

int shell_main()
{
	CmdLine cmdLine;
	cmdLineInit(&cmdLine);

	char cwd[PATH_MAX];
	int status = 1;
	while(status) {
		kprintf("\n%s > ", kgetcwd(cwd, PATH_MAX));
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
