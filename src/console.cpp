#include "console.h"
#include <malloc.h>
#include <bx/bx.h>

struct Console
{
	uint8_t* m_Buffer;
	uint32_t m_NumCols;
	uint32_t m_NumRows;
	uint32_t m_CursorPos;
};

Console* consoleCreate(uint32_t numCols, uint32_t numRows)
{
	Console* con = (Console*)malloc(sizeof(Console));
	if (!con) {
		return nullptr;
	}

	con->m_NumCols = numCols;
	con->m_NumRows = numRows;
	con->m_CursorPos = 0;
	con->m_Buffer = (uint8_t*)malloc(sizeof(uint8_t) * numCols * numRows);
	bx::memSet(con->m_Buffer, 0, sizeof(uint8_t) * numCols * numRows);

	return con;
}

void consoleDestroy(Console* con)
{
	free(con->m_Buffer);
	free(con);
}

void consoleWrite(Console* con, uint8_t data)
{
	// Escape characters
	if (data == '\n') {
		con->m_CursorPos += con->m_NumCols;
	} else if (data == '\r') {
		con->m_CursorPos -= con->m_CursorPos % con->m_NumCols;
	} else if (data == '\t') {
		con->m_CursorPos += 4;
	} else {
		con->m_Buffer[con->m_CursorPos++] = data;
	}

	if (con->m_CursorPos > con->m_NumCols * con->m_NumRows) {
		bx::memMove(&con->m_Buffer[0], &con->m_Buffer[con->m_NumCols], con->m_NumCols);
	}
}

const uint8_t* consoleGetBuffer(Console* con)
{
	return con->m_Buffer;
}
