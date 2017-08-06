#include "cpu.h"
#include "../debug.h"

namespace riscv
{
#define CSR_RW_MASK 0xC00
#define CSR_RW_SHIFT 10

#define CSR_PRIV_MASK 0x300
#define CSR_PRIV_SHIFT 8

#define CSR_FLAG_RO 0x03

// Volume II: RISC-V Privileged Architectures V1.10
#define MSTATUS_MASK_SD     0x80000000 // If both XS and FS are hardwired to zero, then SD is also always zero.
#define MSTATUS_MASK_TSR    0x00400000 // TSR (Trap SRET) is hardwired to 0 when S-mode is not supported
#define MSTATUS_MASK_TW     0x00200000 // TW (Timeout Wait) is hardwired to 0 when S-mode is not supported
#define MSTATUS_MASK_TVM    0x00100000 // TVM (Trap Virtual Memory) is hardwired to 0 when S-mode is not supported
#define MSTATUS_MASK_MXR    0x00080000 // MXR (Make eXecutable Readable) is hardwired to 0 when S-mode is not supported
#define MSTATUS_MASK_SUM    0x00040000 // SUM (permit Supervisor User Memory access) is hardwired to 0 when S-mode is not supported
#define MSTATUS_MASK_MPRV   0x00020000 // MPRV (Modify PRiVilege) See section 3.1.9
#define MSTATUS_MASK_XS     0x00018000 // In systems without additional user extensions requiring new state, the XS field is hardwired to zero
#define MSTATUS_MASK_FS     0x00006000 // In systems that do not implement S-mode and do not have a floating-point unit, the FS field is hardwired to zero
#define MSTATUS_MASK_MPP    0x00001800
#define MSTATUS_MASK_SPP    0x00000100
#define MSTATUS_MASK_MPIE   0x00000080
#define MSTATUS_MASK_SPIE   0x00000020
#define MSTATUS_MASK_UPIE   0x00000010
#define MSTATUS_MASK_MIE    0x00000008
#define MSTATUS_MASK_SIE    0x00000002
#define MSTATUS_MASK_UIE    0x00000001

#define PRIV_LEVEL_TO_MSTATUS_MPP_SHIFT 11

inline bool csrIsReadOnly(uint32_t csr)
{
	return ((csr & CSR_RW_MASK) >> CSR_RW_SHIFT) == CSR_FLAG_RO;
}

inline uint32_t csrGetMinPrivLevel(uint32_t csr)
{
	return ((csr & CSR_PRIV_MASK) >> CSR_PRIV_SHIFT);
}

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
	RISCV_CHECK(csr <= 0xFFF, "Illegal instruction exception: Invalid CSR");

	if (csrIsReadOnly(csr)) {
		RISCV_CHECK(false, "Illegal instruction exception: Trying to write to a read-only CSR");
		return;
	};

	if (csrGetMinPrivLevel(csr) > cpu->m_State.m_PrivLevel) {
		RISCV_CHECK(false, "Illegal instruction exception: Trying to access a privileged CSR");
		return;
	}

	cpu->m_NextState.m_CSR[csr] = val;
}

word_t cpuGetCSR(CPU* cpu, uint32_t csr)
{
	RISCV_CHECK(csr <= 0xFFF, "Illegal instruction exception: Invalid CSR");

	if (csrGetMinPrivLevel(csr) > cpu->m_State.m_PrivLevel) {
		RISCV_CHECK(false, "Illegal instruction exception: Trying to access a privileged CSR");
		return 0;
	}

	return cpu->m_State.m_CSR[csr];
}

word_t cpuReadCSR(CPU* cpu, uint32_t csr)
{
	RISCV_CHECK(csr <= 0xFFF, "Illegal instruction exception: Invalid CSR");
	return cpu->m_State.m_CSR[csr];
}

uint32_t cpuGetPrivLevel(CPU* cpu)
{
	return cpu->m_State.m_PrivLevel;
}

void cpuRaiseException(CPU* cpu, Exception::Enum cause)
{
	// TODO: Set mtval in case the exception has a valid value.
	const uint32_t mstatus = cpu->m_State.m_CSR[CSR::mstatus];
	cpuSetCSR(cpu, CSR::mstatus, (mstatus & ~MSTATUS_MASK_MPP) | (cpuGetPrivLevel(cpu) << PRIV_LEVEL_TO_MSTATUS_MPP_SHIFT));
	cpuSetCSR(cpu, CSR::mcause, (word_t)cause);
	cpuSetCSR(cpu, CSR::mepc, cpuGetPC(cpu));
	cpuSetPC(cpu, cpuGetCSR(cpu, CSR::mtvec));
	cpu->m_NextState.m_PrivLevel = PrivLevel::Machine;
}

void cpuReturnFromException(CPU* cpu)
{
	RISCV_CHECK(cpu->m_State.m_PrivLevel == PrivLevel::Machine, "Illegal instruction exception");
	cpu->m_NextState.m_PrivLevel = (PrivLevel::Enum)((cpuGetCSR(cpu, CSR::mstatus) & MSTATUS_MASK_MPP) >> PRIV_LEVEL_TO_MSTATUS_MPP_SHIFT);
	cpuSetPC(cpu, cpuGetCSR(cpu, CSR::mepc));
}

void cpuIncCounter64(CPU* cpu, CSR::Enum csrLow, uint32_t n)
{
	const uint64_t cnt = cpuGetCSR64(cpu, csrLow);
	const uint64_t cntNew = cnt + n;
	const uint32_t nl = (uint32_t)(cntNew & 0x00000000FFFFFFFF);
	const uint32_t hi = (uint32_t)((cntNew & 0xFFFFFFFF00000000) >> 32);

	cpuSetCSR(cpu, csrLow, nl);
	cpuSetCSR(cpu, csrLow | 0x80, hi);
}

void cpuShadowCSR64(CPU* cpu, CSR::Enum dst, CSR::Enum src)
{
	// NOTE: Don't call cpuSetCSR() because the shadowed CSRs might be marked as readonly.
	cpu->m_NextState.m_CSR[dst] = cpuGetCSR(cpu, src);
	cpu->m_NextState.m_CSR[dst | 0x80] = cpuGetCSR(cpu, src | 0x80);
}

uint64_t cpuGetCSR64(CPU* cpu, CSR::Enum csrLow)
{
	const uint32_t l = cpuGetCSR(cpu, csrLow);
	const uint32_t h = cpuGetCSR(cpu, csrLow | 0x80);
	return (uint64_t)l | (((uint64_t)h) << 32);
}
}
