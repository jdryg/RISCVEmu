#ifndef DEBUG_H
#define DEBUG_H

#ifndef RISCV_CONFIG_DEBUG
#define RISCV_CONFIG_DEBUG 1
#endif

#if RISCV_CONFIG_DEBUG
#define RISCV_TRACE(_format, ...) \
	do { \
		bx::debugPrintf(BX_FILE_LINE_LITERAL "RISCVEmu " _format "\n", ##__VA_ARGS__); \
	} while(0)

#define RISCV_WARN(_condition, _format, ...) \
	do { \
		if (!(_condition) ) { \
			RISCV_TRACE(BX_FILE_LINE_LITERAL _format, ##__VA_ARGS__); \
		} \
	} while(0)

#define RISCV_CHECK(_condition, _format, ...) \
	do { \
		if (!(_condition) ) { \
			RISCV_TRACE(BX_FILE_LINE_LITERAL _format, ##__VA_ARGS__); \
			bx::debugBreak(); \
		} \
	} while(0)
#endif

#include <bx/bx.h>
#include <bx/debug.h>

#if RISCV_CONFIG_DEBUG
BX_PRAGMA_DIAGNOSTIC_IGNORED_MSVC(4127) // conditional expression is constant
#endif

#endif
