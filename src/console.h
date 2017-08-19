#ifndef CONSOLE_H
#define CONSOLE_H

#include <stdint.h>

struct Console;

Console* consoleCreate(uint32_t numCols, uint32_t numRows);
void consoleDestroy(Console* con);

void consoleWrite(Console* con, uint8_t data);

const uint8_t* consoleGetBuffer(Console* con);

void consoleGetCursorPos(Console* con, uint32_t& x, uint32_t& y);

#endif
