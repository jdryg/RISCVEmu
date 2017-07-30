#ifndef DEBUGGER_H
#define DEBUGGER_H

#include <stdint.h>

struct Debugger;

Debugger* dbgCreate();
void dbgDestroy(Debugger* dbg);

bool dbgHasCodeBreakpoint(const Debugger* dbg, uint32_t addr);
void dbgAddCodeBreakpoint(Debugger* dbg, uint32_t addr);
void dbgRemoveCodeBreakpoint(Debugger* dbg, uint32_t addr);
uint32_t dbgGetNumCodeBreakpoints(const Debugger* dbg);
uint32_t dbgGetCodeBreakpointAddressByID(const Debugger* dbg, uint32_t id);

#endif
