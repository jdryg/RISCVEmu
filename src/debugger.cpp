#include "debugger.h"
#include <set>

typedef std::set<uint32_t> Uint32Set;

struct Debugger
{
	Uint32Set m_CodeBreakpoints;
};

Debugger* dbgCreate()
{
	Debugger* dbg = new Debugger();
	
	return dbg;
}

void dbgDestroy(Debugger* dbg)
{
	delete dbg;
}

bool dbgHasCodeBreakpoint(const Debugger* dbg, uint32_t addr)
{
	Uint32Set::const_iterator iter = dbg->m_CodeBreakpoints.find(addr);
	return iter != dbg->m_CodeBreakpoints.end();
}

void dbgAddCodeBreakpoint(Debugger* dbg, uint32_t addr)
{
	dbg->m_CodeBreakpoints.insert(addr);
}

void dbgRemoveCodeBreakpoint(Debugger* dbg, uint32_t addr)
{
	Uint32Set::iterator iter = dbg->m_CodeBreakpoints.find(addr);
	if (iter != dbg->m_CodeBreakpoints.end()) {
		dbg->m_CodeBreakpoints.erase(iter);
	}
}
