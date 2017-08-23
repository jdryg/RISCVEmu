#include "cmd_line.h"
#include "libkernel/kernel.h"
#include "libkernel/memory.h"
#include "libkernel/malloc.h"
#include "libkernel/string.h"
#include "libkernel/stdio.h"
#include "libkernel/ctype.h"

#define CHAR_BACKSPACE 0x08

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

void cmdLineInit(CmdLine* cmdLine)
{
    kmemset(cmdLine, 0, sizeof(CmdLine));
}

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

int cmdLineReadStdIn(CmdLine* cmdLine)
{
	cmdLine->m_Size = 0;
	cmdLine->m_NumArgs = 0;

	char k;
    while ((k = kgetchar()) != '\n') {
        if (k == -1) {
            return cmdLine->m_Size;
		}

		if(!kisprint(k)) {
			if(k == CHAR_BACKSPACE) {
				// Send "Delete char" command to console.
				if(cmdLine->m_Size != 0) {
					--cmdLine->m_Size;
                    kconsoleDelPrevChars(1);
				}
			}

			continue;
		}

		// Echo
		kputchar(k);

		if(cmdLine->m_Size == 0 && k == ' ') {
			continue;
		}

		cmdLinePushChar(cmdLine, k);
    }

	cmdLinePushChar(cmdLine, '\0');

    kputchar('\n');

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
