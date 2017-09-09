#include "multi_cycle.h"
#include "../memory_map.h"
#include "../../debug.h"
#include <bx/bx.h>

namespace riscv
{
namespace cpu
{
#define EXTRACT_BITS(word, startBit, numBits) ((word >> startBit) & ((1 << numBits) - 1))

MultiCycle::MultiCycle()
{
}

MultiCycle::~MultiCycle()
{
}

void MultiCycle::reset(word_t pc)
{
	tlbInit(&m_ITLB, 16);
	tlbInit(&m_DTLB, 16);

	m_NextState.m_Stage = Stage::InstructionFetch;
	m_NextState.m_PrivLevel = PrivLevel::Machine;
	m_NextState.m_IRegs[0] = 0;
	m_NextState.m_PC = pc;
	bx::memSet(m_NextState.m_CSR, 0, sizeof(word_t) * 4096);
	m_NextState.m_CSR[CSR::misa] = 0x40100100; // RV32IU
	m_NextState.m_CSR[CSR::mimpid] = 0x00010001; // v1.1
	m_NextState.m_CSR[CSR::mcounteren] = MCOUNTEREN_CY | MCOUNTEREN_IR;
	m_NextState.m_Exception.m_Enabled = 0;
	m_NextState.m_Breakpoint = false;

	bx::memCopy(&m_State, &m_NextState, sizeof(State));
}

bool MultiCycle::tick(MemoryMap* mm)
{
//	if (m_State.m_MemReq_valid) {
//		if (m_State.m_MemReq_rw) {
//			// TODO: call mmWrite and set m_NextState.m_MemRes_valid to true
//		} else {
//			// TODO: call mmRead and set m_NextState.m_MemRes_valid to true
//		}
//	}

	switch (m_State.m_Stage) {
	case Stage::InstructionFetch:
		stageInstructionFetch(mm);
		break;
	case Stage::Decode:
		stageDecode();
		break;
	case Stage::Execute:
		stageExecute();
		break;
	case Stage::Memory:
		stageMemory(mm);
		break;
	case Stage::WriteBack:
		stageWriteBack();
		break;
	}

	csr64Inc(CSR::mcycle, 1);

	bx::memCopy(&m_State, &m_NextState, sizeof(State));

	return m_State.m_Stage == Stage::InstructionFetch;
}

PrivLevel::Enum MultiCycle::getPrivilegeLevel()
{
	return m_State.m_PrivLevel;
}

word_t MultiCycle::getPC()
{
	return m_State.m_PC;
}

word_t MultiCycle::getRegister(uint32_t reg)
{
	return m_State.m_IRegs[reg];
}

word_t MultiCycle::getCSR(uint32_t csr)
{
	return m_State.m_CSR[csr];
}

dword_t MultiCycle::getCSR64(uint32_t csrLow)
{
	const word_t l = m_State.m_CSR[csrLow];
	const word_t h = m_State.m_CSR[csrLow | 0x80];
	return (dword_t)l | (((dword_t)h) << 32);
}

word_t MultiCycle::getOutputPin(OutputPin::Enum pin)
{
	if (pin == OutputPin::Breakpoint) {
		return m_State.m_Breakpoint ? 1 : 0;
	}

	return 0;
}

bool MultiCycle::getMemWord(MemoryMap* mm, word_t virtualAddress, word_t& data)
{
	const uint32_t satp = m_State.m_CSR[CSR::satp];
	if (m_State.m_PrivLevel == PrivLevel::Machine || (satp & SATP_MODE_MASK) == 0) {
		// Virtual address is the physical address.
		if (!mmRead(mm, virtualAddress, 0xFFFFFFFF, data)) {
			return false;
		}

		return true;
	}

	const uint32_t virtualPageNumber = (virtualAddress & PAGE_NUMBER_MASK) >> PAGE_SHIFT;

	uint32_t pageTablePhysicalAddr = (satp & SATP_PTPPN_MASK) << PAGE_SHIFT;
	int level = 1;
	uint32_t vpnLevel[2] = { virtualPageNumber & 1023, (virtualPageNumber >> 10) & 1023 };
	while (level >= 0) {
		const uint32_t pageTableEntryPhysicalAddr = pageTablePhysicalAddr + (vpnLevel[level] * sizeof(PageTableEntry));
		PageTableEntry pte;
		if (!mmRead(mm, pageTableEntryPhysicalAddr, 0xFFFFFFFF, pte.m_Word)) {
			break;
		}

		if (!pte.m_Fields.m_Valid || (pte.m_Fields.m_Read == 0 && pte.m_Fields.m_Write == 1)) {
			break;
		}

		if (pte.m_Fields.m_Read != 1 && pte.m_Fields.m_Execute != 1) {
			if (level == 0) {
				break;
			}

			--level;
			pageTablePhysicalAddr = pte.m_Fields.m_PhysicalPageNumber << PAGE_SHIFT;
			continue;
		}

		const uint32_t offset = virtualAddress & PAGE_ADDRESS_OFFSET_MASK;
		const TLB::physical_addr_t physicalAddress = (pte.m_Fields.m_PhysicalPageNumber << PAGE_SHIFT) | offset;
		return mmRead(mm, physicalAddress, 0xFFFFFFFF, data);
	}

	return false;
}

void MultiCycle::readState(CPUState* state)
{
	state->m_PC = m_State.m_PC;
	bx::memCopy(&state->m_IRegs[0], &m_State.m_IRegs[1], sizeof(word_t) * 31);
}

//////////////////////////////////////////////////////////////////////////
// Stages
//
void MultiCycle::stageInstructionFetch(MemoryMap* mm)
{
	if (!memRead(mm, &m_ITLB, m_State.m_PC, 0xFFFFFFFF, m_NextState.m_InstrReg, true)) {
		return;
	}

	m_NextState.m_Stage = Stage::Decode;
}

void MultiCycle::stageDecode()
{
	const word_t ir = m_State.m_InstrReg;

	const uint32_t opcode = EXTRACT_BITS(ir, 0, 7);
	const uint32_t rd     = EXTRACT_BITS(ir, 7, 5);
	const uint32_t funct3 = EXTRACT_BITS(ir, 12, 3);
	const uint32_t rs1    = EXTRACT_BITS(ir, 15, 5);
	const uint32_t rs2    = EXTRACT_BITS(ir, 20, 5);
	const uint32_t funct7 = EXTRACT_BITS(ir, 25, 7);

	const uint32_t aluSecondaryFunc = EXTRACT_BITS(ir, 30, 1);

	const uint32_t csr = rs2 | (funct7 << 5);
	const uint32_t imm_i = sext(csr, 11);
	const uint32_t imm_s = sext(rd | (funct7 << 5), 11);
	const uint32_t imm_u = EXTRACT_BITS(ir, 12, 20) << 12;
	const uint32_t imm_b = sext((EXTRACT_BITS(ir, 8, 4) << 1) | (EXTRACT_BITS(ir, 25, 6) << 5) | (EXTRACT_BITS(ir, 7, 1) << 11) | (EXTRACT_BITS(ir, 31, 1) << 12), 12);
	const uint32_t imm_j = sext((EXTRACT_BITS(ir, 21, 10) << 1) | (EXTRACT_BITS(ir, 20, 1) << 11) | (EXTRACT_BITS(ir, 12, 8) << 12) | (EXTRACT_BITS(ir, 31, 1) << 20), 20);

	MicroOp* uop = &m_NextState.m_MicroOp;
	uop_nop(uop);

	if ((opcode & 3) != 3) {
		raiseException(Exception::IllegalInstruction, ir);
	}

	switch (opcode) {
	case Opcode::Load:
		// lb/lh/lw rd, [rs1 + imm12]
		uopRegFile(uop, rs1, 0, rd, RegFileDataSrc::DataMemory);
		uopAddressCalc(uop, AddrCalcSrcA::RegFileA);
		uopDataMem(uop, funct3 & 0x03, false);
		uopALU(uop, ALUASrc::RegFileA, ALUBSrc::RegFileB, ALUFunction::Add_Sub, false); // ALU result unused
		m_NextState.m_Imm = imm_i;
		break;
	case Opcode::MiscMem:
		// Nop
		break;
	case Opcode::OpImm:
		// OPi rd, rs1, sext_imm12;
		uopRegFile(uop, rs1, 0, rd, RegFileDataSrc::ALU);
		uopALU(uop, ALUASrc::RegFileA, ALUBSrc::Imm, (ALUFunction::Enum)funct3, (aluSecondaryFunc && funct3 == ALUFunction::SRL_SRA));
		m_NextState.m_Imm = (funct3 & 0x03) == 0x01 ? rs2 : imm_i; // funct3[0:1] == 01 => Shift (Left/Right) => shamt == rs2
		break;
	case Opcode::AUIPC:
		// auipc rd, imm20
		uopRegFile(uop, 0, 0, rd, RegFileDataSrc::AddrCalc);
		uopAddressCalc(uop, AddrCalcSrcA::PC);
		m_NextState.m_Imm = imm_u;
		break;
	case Opcode::Store:
		// sb/sh/sw rs2, [rs1 + imm12]
		uopRegFile(uop, rs1, rs2, 0, RegFileDataSrc::DontCare);
		uopAddressCalc(uop, AddrCalcSrcA::RegFileA);
		uopDataMem(uop, funct3 & 0x03, true);
		uopALU(uop, ALUASrc::Zero, ALUBSrc::RegFileB, ALUFunction::Or, false); // rs2 = 0 | rs2 (NOTE: Data Memory always reads the ALU result).
		m_NextState.m_Imm = imm_s;
		break;
	case Opcode::Op:
		// OP rd, rs1, rs2
		uopRegFile(uop, rs1, rs2, rd, RegFileDataSrc::ALU);
		uopALU(uop, ALUASrc::RegFileA, ALUBSrc::RegFileB, (ALUFunction::Enum)funct3, aluSecondaryFunc == 1);
		break;
	case Opcode::LUI:
		// lui rd, imm20
		uopAddressCalc(uop, AddrCalcSrcA::RegFileA); // addr = 0 + imm
		uopRegFile(uop, 0, 0, rd, RegFileDataSrc::AddrCalc); // rd = addr
		m_NextState.m_Imm = imm_u;
		break;
	case Opcode::Branch:
		// bCC rs1, rs2, offset13;
		uopRegFile(uop, rs1, rs2, 0, RegFileDataSrc::DontCare);
		uopAddressCalc(uop, AddrCalcSrcA::PC);
		uopNextPC(uop, NextPCSrc::BranchTarget);
		m_NextState.m_Imm = imm_b;
		break;
	case Opcode::JALR:
		// jalr rd, rs1, imm12
		uopRegFile(uop, rs1, 0, rd, RegFileDataSrc::PC_plus_4); // rd = PC + 4
		uopAddressCalc(uop, AddrCalcSrcA::RegFileA); // addr = rs1 + imm
		uopNextPC(uop, NextPCSrc::AddrCalc);
		m_NextState.m_Imm = imm_i;
		break;
	case Opcode::JAL:
		// jal rd, soffset20
		uopRegFile(uop, 0, 0, rd, RegFileDataSrc::PC_plus_4); // rd = PC + 4
		uopAddressCalc(uop, AddrCalcSrcA::PC); // addr = PC + imm
		uopNextPC(uop, NextPCSrc::AddrCalc);
		m_NextState.m_Imm = imm_j;
		break;
	case Opcode::System:
		if(funct3 == 0) {
			if (rd == 0) {
				// ecall/ebreak/uret/sret/mret/wfi/sfence.vma
				if (funct7 == 0) {
					// ecall/ebreak/uret
					if (rs2 == 0) {
						// ecall
						raiseException((Exception::Enum)((uint32_t)Exception::EnvCallFromUser | (uint32_t)m_State.m_PrivLevel), 0);
					} else if (rs2 == 1) {
						// ebreak
						uopBreakpoint(uop);
					} else if (rs2 == 2) {
						// uret (unsupported)
						raiseException(Exception::IllegalInstruction, ir);
					} else {
						raiseException(Exception::IllegalInstruction, ir);
					}
				} else if (funct7 == 8) {
					if (rs2 == 2) {
						// sret (unsupported)
						raiseException(Exception::IllegalInstruction, ir);
					} else if (rs2 == 5) {
						// wfi (unsupported)
						raiseException(Exception::IllegalInstruction, ir);
					} else {
						raiseException(Exception::IllegalInstruction, ir);
					}
				} else if (funct7 == 9) {
					// sfence.vma
					uopFlushTLB(uop);
				} else if (funct7 == 24) {
					if (rs2 == 2) {
						// mret
						uopNextPC(uop, NextPCSrc::mepc);
					} else {
						raiseException(Exception::IllegalInstruction, ir);
					}
				}
			} else {
				raiseException(Exception::IllegalInstruction, ir);
			}
		} else if (funct3 == 1) {
			// csrrw
			uopRegFile(uop, rs1, 0, rd, RegFileDataSrc::CSR);
			uopCSR(uop, csr, true, CSRDataSrc::RegFileA);
		} else if (funct3 == 2) {
			// csrrs
			uopRegFile(uop, rs1, 0, rd, RegFileDataSrc::CSR);
			uopCSR(uop, csr, rs1 != 0, CSRDataSrc::CSR_or_RegFileA);
		} else if (funct3 == 3) {
			// csrrc
			uopRegFile(uop, rs1, 0, rd, RegFileDataSrc::CSR);
			uopCSR(uop, csr, rs1 != 0, CSRDataSrc::CSR_and_not_RegFileA);
		} else if (funct3 == 5) {
			// csrrwi
			uopRegFile(uop, 0, 0, rd, RegFileDataSrc::CSR);
			uopCSR(uop, csr, true, CSRDataSrc::Imm);
			m_NextState.m_Imm = rs1;
		} else if (funct3 == 6) {
			// csrrsi
			uopRegFile(uop, 0, 0, rd, RegFileDataSrc::CSR);
			uopCSR(uop, csr, rs1 != 0, CSRDataSrc::CSR_or_Imm);
			m_NextState.m_Imm = rs1;
		} else if (funct3 == 7) {
			// csrrci
			uopRegFile(uop, 0, 0, rd, RegFileDataSrc::CSR);
			uopCSR(uop, csr, rs1 != 0, CSRDataSrc::CSR_and_not_Imm);
			m_NextState.m_Imm = rs1;
		} else {
			// funct3 == 4
			raiseException(Exception::IllegalInstruction, ir);
		}
		break;
	}

	m_NextState.m_Stage = Stage::Execute;
}

void MultiCycle::stageExecute()
{
	const MicroOp* uop = &m_State.m_MicroOp;

	const word_t dA = m_State.m_IRegs[uop->m_Control.m_RegFile_rA];
	const word_t dB = m_State.m_IRegs[uop->m_Control.m_RegFile_rB];

	// ALU
	{
		const word_t a = uop->m_Control.m_ALU_srcA == ALUASrc::Zero ? 0 : dA;
		const word_t b = uop->m_Control.m_ALU_srcB == ALUBSrc::RegFileB ? dB : m_State.m_Imm;
		m_NextState.m_ALUResult = alu(a, b, (ALUFunction::Enum)uop->m_Control.m_ALU_func, uop->m_Control.m_ALU_secFunc);
	}

	// Address calc
	{
		m_NextState.m_EffectiveAddress = (uop->m_Control.m_AddrCalc_srcA == AddrCalcSrcA::PC ? m_State.m_PC : dA) + m_State.m_Imm;
	}

	// Comparator
	{
		const uint32_t funct3 = EXTRACT_BITS(m_State.m_InstrReg, 12, 3);

		const uint32_t invertResult = funct3 & 0x00000001;
		const uint32_t unsignedComparison = funct3 & 0x00000002;
		const uint32_t inequality = funct3 & 0x00000004;

		const uint32_t equal = (dA == dB) ? 1 : 0;
		const uint32_t lt = ((iword_t)dA < (iword_t)dB) ? 1 : 0;
		const uint32_t ltu = (dA < dB) ? 1 : 0;

		const uint32_t res = inequality ? (unsignedComparison ? ltu : lt) : equal;
		m_NextState.m_ComparatorResult = invertResult ? 1 - res : res;
	}

	// Register file 
	{
		m_NextState.m_RegFileA = dA;
	}

	m_NextState.m_Stage = Stage::Memory;
}

void MultiCycle::stageMemory(MemoryMap* mm)
{
	const MicroOp* uop = &m_State.m_MicroOp;

	if (uop->m_Control.m_DataMem_valid) {
		const uint32_t sz = uop->m_Control.m_DataMem_size;
		const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << sz) << 3));

		const word_t virtualAddr = m_State.m_EffectiveAddress;

		if (uop->m_Control.m_DataMem_we) {
			const word_t val = m_State.m_ALUResult;
			if (!memWrite(mm, &m_DTLB, virtualAddr, byteMask, val)) {
				return;
			}
		} else {
			if (!memRead(mm, &m_DTLB, virtualAddr, byteMask, m_NextState.m_DataMemResult, false)) {
				return;
			}
		}
	}

	m_NextState.m_Stage = Stage::WriteBack;
}

void MultiCycle::stageWriteBack()
{
	const MicroOp* uop = &m_State.m_MicroOp;

	// Register file
	{
		const uint32_t rD = uop->m_Control.m_RegFile_rD;
		if (rD != 0) {
			const uint32_t dDSrc = uop->m_Control.m_RegFile_dD_src;

			const word_t aluResult = m_State.m_ALUResult;
			const word_t dataMem = m_State.m_DataMemResult;
			const word_t addr = m_State.m_EffectiveAddress;
			const word_t pcPlus4 = m_State.m_PC + 4;
			const word_t csr = m_State.m_CSR[uop->m_Control.m_CSR_id];

			word_t dD = aluResult;
			switch (dDSrc) {
			case RegFileDataSrc::ALU:
				dD = aluResult;
				break;
			case RegFileDataSrc::DataMemory:
				dD = dataMem;
				break;
			case RegFileDataSrc::AddrCalc:
				dD = addr;
				break;
			case RegFileDataSrc::PC_plus_4:
				dD = pcPlus4;
				break;
			case RegFileDataSrc::CSR:
				dD = csr;
				break;
			default:
				RISCV_CHECK(false, "Invalid Register File data source");
			}

			m_NextState.m_IRegs[rD] = dD;
		}
	}

	// CSR
	{
		if (uop->m_Control.m_CSR_we) {
			const word_t dA = m_State.m_RegFileA;
			const word_t imm = m_State.m_Imm;
			const word_t csr = m_State.m_CSR[uop->m_Control.m_CSR_id];

			word_t val = csr;
			switch (uop->m_Control.m_CSR_src) {
			case CSRDataSrc::RegFileA:
				val = dA;
				break;
			case CSRDataSrc::Imm:
				val = imm;
				break;
			case CSRDataSrc::CSR_or_RegFileA:
				val = csr | dA;
				break;
			case CSRDataSrc::CSR_or_Imm:
				val = csr | imm;
				break;
			case CSRDataSrc::CSR_and_not_RegFileA:
				val = csr & (~dA);
				break;
			case CSRDataSrc::CSR_and_not_Imm:
				val = csr & (~imm);
				break;
			default:
				RISCV_CHECK(false, "Invalid CSR data source");
			}

			m_NextState.m_CSR[uop->m_Control.m_CSR_id] = val;
		}
	}

	// PC
	{
		if (m_State.m_Exception.m_Enabled) {
			m_NextState.m_PC = m_State.m_CSR[CSR::mtvec];
		} else {
			const word_t pcPlus4 = m_State.m_PC + 4;
			const word_t branchAddr = m_State.m_EffectiveAddress;
			const word_t cond = m_State.m_ComparatorResult;
			const word_t mepc = m_State.m_CSR[CSR::mepc];
			const word_t nextPCSrc = uop->m_Control.m_NextPCSrc;

			word_t nextPC = pcPlus4;
			switch (nextPCSrc) {
			case NextPCSrc::PC_plus_4:
				nextPC = pcPlus4;
				break;
			case NextPCSrc::BranchTarget:
				nextPC = cond ? branchAddr : pcPlus4;
				break;
			case NextPCSrc::AddrCalc:
				nextPC = branchAddr;
				break;
			case NextPCSrc::mepc:
				nextPC = mepc;
				break;
			default:
				RISCV_CHECK(false, "Invalid Next PC selection");
			}

			m_NextState.m_PC = nextPC;
		}
	}

	// Exception
	{
		if (m_State.m_Exception.m_Enabled) {
			const word_t mstatus = m_State.m_CSR[CSR::mstatus];
			m_NextState.m_CSR[CSR::mstatus] = (mstatus & ~MSTATUS_MASK_MPP) | (m_State.m_PrivLevel << PRIV_LEVEL_TO_MSTATUS_MPP_SHIFT);
			m_NextState.m_CSR[CSR::mcause] = (word_t)m_State.m_Exception.m_Cause;
			m_NextState.m_CSR[CSR::mepc] = m_State.m_PC;
			m_NextState.m_PrivLevel = PrivLevel::Machine;
		}
	}

	// Privilege level
	{
		if (uop->m_Control.m_NextPCSrc == NextPCSrc::mepc) {
			const word_t mstatus = m_State.m_CSR[CSR::mstatus];
			m_NextState.m_PrivLevel = (PrivLevel::Enum)((mstatus & MSTATUS_MASK_MPP) >> PRIV_LEVEL_TO_MSTATUS_MPP_SHIFT);
		}
	}

	// Breakpoint
	{
		m_NextState.m_Breakpoint = uop->m_Control.m_Breakpoint == 1 ? true : false;
	}

	// TLB flush
	{
		if (uop->m_Control.m_FlushTLB) {
			tlbFlush(&m_DTLB);
			tlbFlush(&m_ITLB);
		}
	}

	// Performance counters
	{
		csr64Inc(CSR::minstret, 1);
	}

	clearException();

	m_NextState.m_Stage = Stage::InstructionFetch;
}

//////////////////////////////////////////////////////////////////////////
// Memory
//
bool MultiCycle::memRead(MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t& data, bool isInstruction)
{
	RISCV_CHECK(tlb != nullptr, "No TLB specified for memory read");

	const uint32_t satp = m_State.m_CSR[CSR::satp];
	const uint32_t virtualPageNumber = (virtualAddress & PAGE_NUMBER_MASK) >> PAGE_SHIFT;

	if (m_State.m_PrivLevel == PrivLevel::Machine || (satp & SATP_MODE_MASK) == 0) {
		// Virtual address is the physical address.
		if (!mmRead(mm, virtualAddress, byteMask, data)) {
			raiseException(Exception::LoadAccessFault, virtualAddress); // Or is it LoadPageFault?
		}

		return true;
	} else {
		RISCV_CHECK(m_State.m_PrivLevel == PrivLevel::User, "Invalid privilege level");

		TLBLookupResult tlbResult = tlbLookup(tlb, virtualPageNumber);
		if (tlbResult.m_Hit) {
			const uint32_t pageProtectionFlags = tlbResult.m_ProtectionFlags;
			const uint32_t requiredProtectionFlags = PROTECTION_READ | (isInstruction ? PROTECTION_EXECUTE : 0);
			if ((pageProtectionFlags & requiredProtectionFlags) == requiredProtectionFlags) {
				const uint32_t offset = virtualAddress & PAGE_ADDRESS_OFFSET_MASK;
				const TLB::physical_addr_t physicalAddress = (tlbResult.m_PhysicalFrameNumber << PAGE_SHIFT) | offset;
				if (!mmRead(mm, physicalAddress, byteMask, data)) {
					raiseException(Exception::LoadAccessFault, virtualAddress);
				}
			} else {
				raiseException(Exception::LoadAccessFault, virtualAddress);
			}

			return true;
		} else {
			// NOTE: If the code below happens in the HW then we can access satp CSR without checking for the current
			// privilege mode. If it happens in SW we must raise an exception, switch to M-mode and then read the satp.
			// The problem with a SW implementation is that there are no instructions to update the TLB. So we either 
			// have to define new instructions (i.e. similarly to lowRISC/Rocket*) or implement this in HW.
			// (*): If I understood the code correctly (see http://www.lowrisc.org/docs/tagged-memory-v0.1/new-instructions/)
			if (!pageTableWalk(mm, tlb, satp, virtualPageNumber, true, false, isInstruction, false)) {
				// Page table walk failed. Exception should have been raised. Continue to the next stage.
				return true;
			}
		}
	}

	return false;
}

bool MultiCycle::memWrite(MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t data)
{
	RISCV_CHECK(tlb != nullptr, "No TLB specified for memory read");

	const uint32_t satp = m_State.m_CSR[CSR::satp];

	if (m_State.m_PrivLevel == PrivLevel::Machine || (satp & SATP_MODE_MASK) == 0) {
		// Virtual address is the physical address.
		if (!mmWrite(mm, virtualAddress, byteMask, data)) {
			raiseException(Exception::StoreAccessFault, virtualAddress);
		}

		return true;
	} else {
		const uint32_t virtualPageNumber = (virtualAddress & PAGE_NUMBER_MASK) >> PAGE_SHIFT;
		TLBLookupResult tlbResult = tlbLookup(tlb, virtualPageNumber);
		if (tlbResult.m_Hit) {
			const uint32_t pageProtectionFlags = tlbResult.m_ProtectionFlags;
			const uint32_t requiredProtectionFlags = PROTECTION_WRITE;
			if ((pageProtectionFlags & requiredProtectionFlags) == requiredProtectionFlags) {
				const uint32_t offset = virtualAddress & PAGE_ADDRESS_OFFSET_MASK;
				const TLB::physical_addr_t physicalAddress = (tlbResult.m_PhysicalFrameNumber << PAGE_SHIFT) | offset;
				if (mmWrite(mm, physicalAddress, byteMask, data)) {
					return true;
				}
			}

			raiseException(Exception::StoreAccessFault, virtualAddress);
			return true;
		} else {
			if (!pageTableWalk(mm, tlb, satp, virtualPageNumber, false, true, false, true)) {
				// Page table walk failed. Exception should have been raised. Continue to the next stage.
				return true;
			}
		}
	}

	return false;
}

// NOTE: Doesn't support superpages. Pages are always 4k independent of their level in the hierarchy.
bool MultiCycle::pageTableWalk(MemoryMap* mm, TLB* tlb, uint32_t satp, uint32_t vpn, bool read, bool write, bool execute, bool isStore)
{
	// Algorithm from section 4.3.2 (RISC-V Privileged Architectures v1.10)
	// 1. Let pageTablePPN be satp.ppn * PAGESIZE, and let level = LEVELS - 1. (For Sv32, PAGESIZE = 4096 and LEVELS = 2)
	uint32_t pageTablePhysicalAddr = (satp & SATP_PTPPN_MASK) << PAGE_SHIFT;
	uint32_t level = 1;
	uint32_t vpnLevel[2] = { vpn & 1023, (vpn >> 10) & 1023 };
	while (true) {
		// 2. Let pte be the value of the PTE at address pageTablePPN + va.vpn[i] * PTESIZE. (For Sv32, PTESIZE=4)
		const uint32_t pageTableEntryPhysicalAddr = pageTablePhysicalAddr + (vpnLevel[level] * sizeof(PageTableEntry));
		PageTableEntry pte;
		if (!mmRead(mm, pageTableEntryPhysicalAddr, 0xFFFFFFFF, pte.m_Word)) {
			// 2. If accessing pte violates a PMA or PMP check, raise an access exception.
			raiseException(isStore ? Exception::StoreAccessFault : Exception::LoadAccessFault, pageTableEntryPhysicalAddr);
			return false;
		} else {
			// 3. If pte.v = 0, or if pte.r = 0 and pte.w = 1, stop and raise a page-fault exception.
			if (!pte.m_Fields.m_Valid || (pte.m_Fields.m_Read == 0 && pte.m_Fields.m_Write == 1)) {
				raiseException(isStore ? Exception::StorePageFault : Exception::LoadPageFault, pageTableEntryPhysicalAddr);
				return false;
			} else {
				// 4. Otherwise, the PTE is valid. 
				// If pte.r = 1 or pte.x = 1, go to step 5. Otherwise, this PTE is a pointer to the next level 
				// of the page table. Let level = level - 1. If level < 0, stop and raise a page-fault exception.
				// Otherwise, let pageTablePhysicalAddr = pte.ppn * PAGESIZE and go to step 2.
				if (pte.m_Fields.m_Read != 1 && pte.m_Fields.m_Execute != 1) {
					if (level == 0) {
						raiseException(isStore ? Exception::StorePageFault : Exception::LoadPageFault, pageTableEntryPhysicalAddr);
						return false;
					}

					--level;
					pageTablePhysicalAddr = pte.m_Fields.m_PhysicalPageNumber << PAGE_SHIFT;
					continue;
				}

				// 5. A leaf PTE has been found. Determine if the requested memory access is allowed by the
				// pte.r, pte.w, pte.x, and pte.u bits, given the current privilege mode and the value of the SUM
				// and MXR fields of the mstatus register. If not, stop and raise a page-fault exception.
				if ((read && !pte.m_Fields.m_Read) ||
					(write && !pte.m_Fields.m_Write) ||
					(execute && !pte.m_Fields.m_Execute)) {
					raiseException(isStore ? Exception::StorePageFault : Exception::LoadPageFault, pageTableEntryPhysicalAddr);
					return false;
				} else {
					// TODO: 6. If i > 0 and pa.ppn[i - 1:0] != 0, this is a misaligned superpage; stop and raise a page-fault exception.
					// TODO: 7. If pte.a = 0, or if the memory access is a store and pte.d = 0, either raise a page-fault exception or...

					// 8. The translation is successful. The translated physical address is given as follows: ...
					tlbInsert(tlb, vpn, pte.m_Fields.m_PhysicalPageNumber, (pte.m_Word & PTE_PROTECTION_MASK) >> PTE_PROTECTION_SHIFT);
					break;
				}
			}
		}
	}

	return true;
}
} // namespace cpu
} // namespace riscv