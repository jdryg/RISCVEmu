#ifndef CMD_LINE_H
#define CMD_LINE_H

#include <stdint.h>

typedef struct CmdLine
{
	char* m_Buffer;
	uint32_t m_Size;
	uint32_t m_Capacity;

	char** m_Args;
	uint32_t m_NumArgs;
	uint32_t m_ArgsCapacity;
} CmdLine;

void cmdLineInit(CmdLine* cmdLine);
void cmdLineDestroy(CmdLine* cmdLine);
int cmdLineReadStdIn(CmdLine* cmdLine);
void cmdLineTokenize(CmdLine* cmdLine);

#endif
