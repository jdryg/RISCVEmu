#include "cpu.h"
#include "../debug.h"

namespace riscv
{
word_t cpuGetPC(CPU* cpu)
{
	return cpu->m_State.m_PC;
}

void cpuSetPC(CPU* cpu, word_t val)
{
	cpu->m_NextState.m_PC = val;
}

word_t cpuGetRegister(CPU* cpu, uint32_t reg)
{
	return cpu->m_State.m_IRegs[reg];
}

void cpuSetRegister(CPU* cpu, uint32_t reg, word_t val)
{
	if (reg != 0) {
		cpu->m_NextState.m_IRegs[reg] = val;
	}
}

void cpuSetCSR(CPU* cpu, uint32_t csr, word_t val)
{
	RISCV_CHECK(csr <= 0xFFF, "Invalid CSR");
	cpu->m_NextState.m_CSR[csr] = val;
}

word_t cpuGetCSR(CPU* cpu, uint32_t csr)
{
	RISCV_CHECK(csr <= 0xFFF, "Invalid CSR");
	return cpu->m_State.m_CSR[csr];
}
}
