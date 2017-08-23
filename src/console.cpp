#include "console.h"
#include "debug.h"
#include <malloc.h>
#include <bx/bx.h>

#define CONSOLE_COMMAND              0xFF

#define CONSOLE_CMD_DEL_PREV         0x00
#define CONSOLE_CMD_RAW_OUTPUT       0x01

struct ConsoleState
{
	enum Enum : uint8_t
	{
		Normal,
		CommandStart,
		CommandData
	};
};

struct Console
{
	uint8_t* m_Buffer;
	uint32_t m_NumCols;
	uint32_t m_NumRows;
	uint32_t m_CursorPos;
	ConsoleState::Enum m_State;
	uint8_t m_Command;
	uint8_t m_CommandDataByte;
	uint16_t m_NumRawOutputBytes;
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
	bx::memSet(con->m_Buffer, ' ', sizeof(uint8_t) * numCols * numRows);
	con->m_State = ConsoleState::Normal;
	con->m_Command = 0;
	con->m_CommandDataByte = 0;
	con->m_NumRawOutputBytes = 0;

	return con;
}

void consoleDestroy(Console* con)
{
	free(con->m_Buffer);
	free(con);
}

void consoleWrite(Console* con, uint8_t data)
{
	if (con->m_State == ConsoleState::Normal) {
		if (con->m_NumRawOutputBytes) {
			if (data == 0) {
				data = ' ';
			}
			con->m_Buffer[con->m_CursorPos++] = data;
			--con->m_NumRawOutputBytes;
		} else {
			if (data == CONSOLE_COMMAND) {
				con->m_State = ConsoleState::CommandStart;
				return;
			}

			if (data == '\n') {
				con->m_CursorPos += con->m_NumCols;
				// LF implies CR
				// NOTE: This change has been made to allow printing of binary data. No extra bytes
				// are send to the UART in case a LF char is to be printed. Previous versions of the 
				// kernel examined each char sent to the UART and if it was a LF, a CR was added after
				// it.
				con->m_CursorPos -= con->m_CursorPos % con->m_NumCols;
			} else if (data == '\r') {
				con->m_CursorPos -= con->m_CursorPos % con->m_NumCols;
			} else if (data == '\t') {
				// Ignore tabs for now.
//				con->m_CursorPos += 4;
			} else {
				con->m_Buffer[con->m_CursorPos++] = data;
			}
		}

		if (con->m_CursorPos >= con->m_NumCols * con->m_NumRows) {
			bx::memMove(&con->m_Buffer[0], &con->m_Buffer[con->m_NumCols], con->m_NumCols * (con->m_NumRows - 1));
			con->m_CursorPos -= con->m_NumCols;

			// Erase the whole line even if the cursor is in the middle of the line (i.e. from a \n char)
			const uint32_t startOfRow = con->m_CursorPos - (con->m_CursorPos % con->m_NumCols);
			bx::memSet(&con->m_Buffer[startOfRow], ' ', con->m_NumCols);
		}
	} else if (con->m_State == ConsoleState::CommandStart) {
		con->m_Command = data;
		con->m_CommandDataByte = 0;
		con->m_State = ConsoleState::CommandData;
	} else if (con->m_State == ConsoleState::CommandData) {
		if (con->m_Command == CONSOLE_CMD_DEL_PREV) {
			uint8_t n = data;
			while (n-- > 0) {
				con->m_Buffer[--con->m_CursorPos] = ' ';
			}

			con->m_State = ConsoleState::Normal;
		} else if (con->m_Command == CONSOLE_CMD_RAW_OUTPUT) {
			con->m_NumRawOutputBytes = ((uint16_t)data) << (con->m_CommandDataByte * 8);
			++con->m_CommandDataByte;
			if (con->m_CommandDataByte == 2) {
				con->m_State = ConsoleState::Normal;
			}
		} else {
			RISCV_CHECK(false, "Unknown console command received");
		}
	}
}

const uint8_t* consoleGetBuffer(Console* con)
{
	return con->m_Buffer;
}

void consoleGetCursorPos(Console* con, uint32_t& x, uint32_t& y)
{
	x = con->m_CursorPos % con->m_NumCols;
	y = con->m_CursorPos / con->m_NumCols;
}
