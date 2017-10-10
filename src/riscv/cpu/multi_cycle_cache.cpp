#include "multi_cycle_cache.h"
#include "../memory_map.h"
#include "../cache.h"
#include "../../debug.h"
#include "../../math.h"
#include "../../imgui/imgui.h"
#include <bx/bx.h>
#include <bx/string.h>

namespace riscv
{
namespace cpu
{
MultiCycleCache::MultiCycleCache() 
	: m_ICache(nullptr)
	, m_DCache(nullptr)
	, m_SingleStep(false)
{
}

MultiCycleCache::~MultiCycleCache()
{
	if (m_ICache) {
		cacheDestroy(m_ICache);
		m_ICache = nullptr;
	}

	if (m_DCache) {
		cacheDestroy(m_DCache);
		m_DCache = nullptr;
	}
	
	tlbShutdown(&m_ITLB);
	tlbShutdown(&m_DTLB);
}

void MultiCycleCache::reset(word_t pc)
{
	tlbInit(&m_ITLB, 16);
	tlbInit(&m_DTLB, 16);

	m_ICache = cacheCreate(64, 8, 64);
	ccInit(&m_ICacheController, m_ICache);

	m_DCache = cacheCreate(64, 8, 64);
	ccInit(&m_DCacheController, m_DCache);

	m_NextState.m_Mode = Mode::InstrExec;
	m_NextState.m_Stage = Stage::InstructionFetch1;
	m_NextState.m_PrivLevel = PrivLevel::Machine;
	m_NextState.m_IRegs[0] = 0;
	m_NextState.m_PC = pc;
	bx::memSet(m_NextState.m_CSR, 0, sizeof(word_t) * 4096);
	m_NextState.m_CSR[CSR::misa] = 0x40100100; // RV32IU
	m_NextState.m_CSR[CSR::mimpid] = 0x00010002; // v1.2
	m_NextState.m_CSR[CSR::mcounteren] = MCOUNTEREN_CY | MCOUNTEREN_IR;
	m_NextState.m_Exception.m_Enabled = 0;
	m_NextState.m_Breakpoint = false;
	m_NextState.m_MMULookupException = MMUException::None;
	m_NextState.m_MMUTLB = nullptr;
	m_NextState.m_MMUVirtualAddr = 0;
	m_NextState.m_MMUPTWalkLevel = ~0u;
	m_MMUMemReq.m_Control.m_Fields.m_Valid = 0;
	m_ICacheReq.m_Control.m_Fields.m_Valid = 0;
	m_DCacheReq.m_Control.m_Fields.m_Valid = 0;
	m_UncachedMemReq.m_Control.m_Fields.m_Valid = 0;

	bx::memCopy(&m_State, &m_NextState, sizeof(State));
}

bool MultiCycleCache::tick(MemoryMap* mm)
{
	// Memory request. From highest priority to lowest priority
	// 1) MMU (page table walk)
	// 2) Data Memory (MemoryX stages)
	// 3) Instruction Memory (InstructionFetchX stages)
	if (m_MMUMemReq.m_Control.m_Fields.m_Valid) {
		m_MMUMemRes = mmRequest(mm, m_MMUMemReq);
		m_MMUMemReq.m_Control.m_Fields.m_Valid = 0;
	} else if (m_UncachedMemReq.m_Control.m_Fields.m_Valid) {
		m_UncachedMemRes = mmRequest(mm, m_UncachedMemReq);
		m_UncachedMemReq.m_Control.m_Fields.m_Valid = 0;
	} else if (m_DCacheMemReq.m_Control.m_Fields.m_Valid) {
		m_DCacheMemRes = mmRequest(mm, m_DCacheMemReq);
	} else if (m_ICacheMemReq.m_Control.m_Fields.m_Valid) {
		m_ICacheMemRes = mmRequest(mm, m_ICacheMemReq);
	}

	m_ICacheNeedsStall = ccSimulate(&m_ICacheController, &m_ICacheReq, &m_ICacheRes, &m_ICacheMemReq, &m_ICacheMemRes);
	m_DCacheNeedsStall = ccSimulate(&m_DCacheController, &m_DCacheReq, &m_DCacheRes, &m_DCacheMemReq, &m_DCacheMemRes);

	const word_t instrRetired = m_State.m_CSR[CSR::minstret];

	if (m_State.m_Mode == Mode::InstrExec) {
		if (!m_ICacheNeedsStall && !m_DCacheNeedsStall) {
			switch (m_State.m_Stage) {
			case Stage::InstructionFetch1:
				stageInstructionFetch1();
				break;
			case Stage::InstructionFetch2:
				stageInstructionFetch2();
				break;
			case Stage::Decode:
				stageDecode();
				break;
			case Stage::Execute:
				stageExecute();
				break;
			case Stage::Memory1:
				stageMemory1();
				break;
			case Stage::Memory2:
				stageMemory2();
				break;
			case Stage::WriteBack:
				stageWriteBack();
				break;
			}
		}
	} else if (m_State.m_Mode == Mode::PageTableWalk) {
		mmuPageTableWalk();
	}

	csr64Inc(CSR::mcycle, 1);

	ccTick(&m_ICacheController);
	ccTick(&m_DCacheController);
	bx::memCopy(&m_State, &m_NextState, sizeof(State));

	return m_SingleStep || instrRetired != m_State.m_CSR[CSR::minstret];
}

PrivLevel::Enum MultiCycleCache::getPrivilegeLevel()
{
	return m_State.m_PrivLevel;
}

word_t MultiCycleCache::getPC()
{
	return m_State.m_PC;
}

word_t MultiCycleCache::getRegister(uint32_t reg)
{
	return m_State.m_IRegs[reg];
}

word_t MultiCycleCache::getCSR(uint32_t csr)
{
	return m_State.m_CSR[csr];
}

dword_t MultiCycleCache::getCSR64(uint32_t csrLow)
{
	const word_t l = m_State.m_CSR[csrLow];
	const word_t h = m_State.m_CSR[csrLow | 0x80];
	return (dword_t)l | (((dword_t)h) << 32);
}

word_t MultiCycleCache::getOutputPin(OutputPin::Enum pin)
{
	if (pin == OutputPin::Breakpoint) {
		return m_State.m_Breakpoint ? 1 : 0;
	}

	return 0;
}

bool MultiCycleCache::getMemWord(MemoryMap* mm, word_t virtualAddress, word_t& data)
{
	// TODO: Use caches
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

void MultiCycleCache::readState(CPUState* state)
{
	state->m_PC = m_State.m_PC;
	bx::memCopy(&state->m_IRegs[0], &m_State.m_IRegs[1], sizeof(word_t) * 31);
}

//////////////////////////////////////////////////////////////////////////
// Stages
//
void MultiCycleCache::stageInstructionFetch1()
{
	MMULookupResult mmuLookup;
	mmuTranslateAddress(&mmuLookup, &m_ITLB, m_State.m_PC, PROTECTION_READ | PROTECTION_EXECUTE);
	if (mmuLookup.m_Ready) {
		if (!mmuLookup.m_Valid) {
			switch (mmuLookup.m_Exception) {
			case MMUException::AccessFault:
				raiseException(Exception::InstructionAccessFault, m_State.m_PC);
				break;
			case MMUException::PageFault:
				raiseException(Exception::InstructionPageFault, m_State.m_PC);
				break;
			default:
				RISCV_CHECK(false, "MMU result is invalid but no exception has been set!");
				break;
			}
		} else {
			MemoryRequest* req = mmuLookup.m_Cacheable ? &m_ICacheReq : &m_UncachedMemReq;
			req->m_Addr = mmuLookup.m_PhysicalAddress;
			req->m_Control.m_Fields.m_Valid = 1;
			req->m_Control.m_Fields.m_Size = MEMOP_SIZE_4;
			req->m_Control.m_Fields.m_WriteEnable = 0;
		}

		m_NextState.m_IFPhysicalAddress = mmuLookup.m_PhysicalAddress;
		m_NextState.m_Stage = Stage::InstructionFetch2;
	}
}

void MultiCycleCache::stageInstructionFetch2()
{
	const bool cacheable = (m_State.m_IFPhysicalAddress & 0x80000000) == 0;
	MemoryRequest* req = cacheable ? &m_ICacheReq : &m_UncachedMemReq;
	MemoryResponse* res = cacheable ? &m_ICacheRes : &m_UncachedMemRes;
	if (res->m_Control.m_Fields.m_Ready) {
		if (!res->m_Control.m_Fields.m_Valid) {
			raiseException(Exception::InstructionAccessFault, m_State.m_IFPhysicalAddress);
		} else {
			m_NextState.m_InstrReg = res->m_Data;
		}

		req->m_Control.m_Fields.m_Valid = 0;
		m_NextState.m_Stage = Stage::Decode;
	}
}

void MultiCycleCache::stageDecode()
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
					uopFlushCaches(uop);
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

void MultiCycleCache::stageExecute()
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

	m_NextState.m_Stage = Stage::Memory1;
}

void MultiCycleCache::stageMemory1()
{
	const MicroOp* uop = &m_State.m_MicroOp;

	if (uop->m_Control.m_DataMem_valid) {
		MMULookupResult mmuLookup;
		mmuTranslateAddress(&mmuLookup, &m_DTLB, m_State.m_EffectiveAddress, uop->m_Control.m_DataMem_we ? PROTECTION_WRITE : PROTECTION_READ);
		if (mmuLookup.m_Ready) {
			if (!mmuLookup.m_Valid) {
				switch (mmuLookup.m_Exception) {
				case MMUException::AccessFault:
					raiseException(uop->m_Control.m_DataMem_we ? Exception::StoreAccessFault : Exception::LoadAccessFault, m_State.m_PC);
					break;
				case MMUException::PageFault:
					raiseException(uop->m_Control.m_DataMem_we ? Exception::StorePageFault : Exception::LoadPageFault, m_State.m_PC);
					break;
				default:
					RISCV_CHECK(false, "MMU result is invalid but no exception has been set!");
					break;
				}
			} else {
				MemoryRequest* req = mmuLookup.m_Cacheable ? &m_DCacheReq : &m_UncachedMemReq;
				req->m_Addr = mmuLookup.m_PhysicalAddress;
				req->m_Data = m_State.m_ALUResult;
				req->m_Control.m_Fields.m_Size = uop->m_Control.m_DataMem_size;
				req->m_Control.m_Fields.m_WriteEnable = uop->m_Control.m_DataMem_we;
				req->m_Control.m_Fields.m_Valid = 1;
			}

			m_NextState.m_MemPhysicalAddress = mmuLookup.m_PhysicalAddress;

			m_NextState.m_Stage = Stage::Memory2;
		}
	} else {
		m_NextState.m_Stage = Stage::WriteBack;
	}
}

void MultiCycleCache::stageMemory2()
{
	const MicroOp* uop = &m_State.m_MicroOp;
	
	const bool cacheable = (m_State.m_MemPhysicalAddress & 0x80000000) == 0;
	MemoryRequest* req = cacheable ? &m_DCacheReq : &m_UncachedMemReq;
	MemoryResponse* res = cacheable ? &m_DCacheRes : &m_UncachedMemRes;
	if (res->m_Control.m_Fields.m_Ready) {
		if (!res->m_Control.m_Fields.m_Valid) {
			raiseException(uop->m_Control.m_DataMem_we ? Exception::StoreAccessFault : Exception::LoadAccessFault, m_State.m_MemPhysicalAddress);
		} else {
			m_NextState.m_DataMemResult = res->m_Data;
		}

		req->m_Control.m_Fields.m_Valid = 0;
		m_NextState.m_Stage = Stage::WriteBack;
	}
}

void MultiCycleCache::stageWriteBack()
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
		if (uop->m_Control.m_FlushCaches) {
			tlbFlush(&m_DTLB);
			tlbFlush(&m_ITLB);
			ccFlushCache(&m_ICacheController);
			ccFlushCache(&m_DCacheController);
		}
	}

	// Performance counters
	{
		csr64Inc(CSR::minstret, 1);
	}

	clearException();

	m_NextState.m_Stage = Stage::InstructionFetch1;
}

//////////////////////////////////////////////////////////////////////////
// MMU
//
void MultiCycleCache::mmuTranslateAddress(MMULookupResult* res, TLB* tlb, word_t virtualAddress, uint32_t requiredProtectionFlags)
{
	const word_t satp = m_State.m_CSR[CSR::satp];
	const bool noTranslationNeeded = m_State.m_PrivLevel == PrivLevel::Machine || (satp & SATP_MODE_MASK) == 0;
	if (noTranslationNeeded) {
		res->m_PhysicalAddress = virtualAddress;
		res->m_Exception = MMUException::None;
		res->m_Ready = true;
		res->m_Valid = true;
		res->m_Cacheable = (res->m_PhysicalAddress & 0x80000000) == 0;
		return;
	}

	const word_t virtualPageNumber = (virtualAddress & PAGE_NUMBER_MASK) >> PAGE_SHIFT;
	const TLBLookupResult tlbResult = tlbLookup(tlb, virtualPageNumber);

	if (tlbResult.m_Hit) {
		const uint32_t pageProtectionFlags = tlbResult.m_ProtectionFlags;
		const uint32_t offset = virtualAddress & PAGE_ADDRESS_OFFSET_MASK;
		const word_t physicalAddress = (tlbResult.m_PhysicalFrameNumber << PAGE_SHIFT) | offset;

		res->m_Ready = true;
		res->m_Valid = ((pageProtectionFlags & requiredProtectionFlags) == requiredProtectionFlags);
		res->m_Exception = MMUException::AccessFault; // In case the request was invalid.
		res->m_PhysicalAddress = physicalAddress;
		res->m_Cacheable = (res->m_PhysicalAddress & 0x80000000) == 0;
		return;
	}

	// Address translation is required and TLB lookup failed. 
	// Prepare a memory request for the PTE in the level-1 PT.
	const uint32_t pageTablePhysicalAddr = (satp & SATP_PTPPN_MASK) << PAGE_SHIFT;
	const uint32_t vpn = (virtualPageNumber >> 10) & 1023;
	const uint32_t pageTableEntryPhysicalAddr = pageTablePhysicalAddr + (vpn * sizeof(PageTableEntry));

	m_MMUMemReq.m_Addr = pageTableEntryPhysicalAddr;
	m_MMUMemReq.m_Control.m_Fields.m_Size = MEMOP_SIZE_4;
	m_MMUMemReq.m_Control.m_Fields.m_WriteEnable = 0;
	m_MMUMemReq.m_Control.m_Fields.m_Valid = 1;

	// Switch to PT walk mode
	m_NextState.m_Mode = Mode::PageTableWalk;
	m_NextState.m_MMUVirtualAddr = virtualAddress;
	m_NextState.m_MMULookupException = MMUException::None;
	m_NextState.m_MMUTLB = tlb;
	m_NextState.m_MMUPTWalkLevel = 1;

	res->m_Ready = m_State.m_MMULookupException != MMUException::None;
	res->m_Valid = false;
	res->m_PhysicalAddress = ~0u;
	res->m_Exception = m_State.m_MMULookupException;
	res->m_Cacheable = (res->m_PhysicalAddress & 0x80000000) == 0;
}

void MultiCycleCache::mmuPageTableWalk()
{
	m_MMUMemReq.m_Control.m_Fields.m_Valid = 0;

	if (m_MMUMemRes.m_Control.m_Fields.m_Ready) {
		if (!m_MMUMemRes.m_Control.m_Fields.m_Valid) {
			m_NextState.m_MMULookupException = MMUException::AccessFault;
			m_NextState.m_Mode = Mode::InstrExec;
		} else {
			PageTableEntry pte;
			pte.m_Word = m_MMUMemRes.m_Data;
			if (!pte.m_Fields.m_Valid || (pte.m_Fields.m_Read == 0 && pte.m_Fields.m_Write == 1)) {
				m_NextState.m_MMULookupException = MMUException::PageFault;
				m_NextState.m_Mode = Mode::InstrExec;
			} else {
				const word_t virtualAddress = m_State.m_MMUVirtualAddr;
				const word_t virtualPageNumber = (virtualAddress & PAGE_NUMBER_MASK) >> PAGE_SHIFT;
				const uint32_t level = m_State.m_MMUPTWalkLevel;

				RISCV_CHECK(level <= 1, "Invalid page table walk level");

				if (level == 1) {
					if (pte.m_Fields.m_Read == 1 || pte.m_Fields.m_Execute == 1) {
						m_NextState.m_MMULookupException = MMUException::PageFault;
						m_NextState.m_Mode = Mode::InstrExec;
					} else {
						const word_t pageTablePhysicalAddr = pte.m_Fields.m_PhysicalPageNumber << PAGE_SHIFT;
						const uint32_t vpn = virtualPageNumber & 1023;
						const word_t pageTableEntryPhysicalAddr = pageTablePhysicalAddr + (vpn * sizeof(PageTableEntry));

						m_MMUMemReq.m_Addr = pageTableEntryPhysicalAddr;
						m_MMUMemReq.m_Control.m_Fields.m_Size = MEMOP_SIZE_4;
						m_MMUMemReq.m_Control.m_Fields.m_WriteEnable = 0;
						m_MMUMemReq.m_Control.m_Fields.m_Valid = 1;

						m_NextState.m_MMUPTWalkLevel = 0;
					}
				} else if (level == 0) {
					tlbInsert(m_State.m_MMUTLB, virtualPageNumber, pte.m_Fields.m_PhysicalPageNumber, (pte.m_Word & PTE_PROTECTION_MASK) >> PTE_PROTECTION_SHIFT);
					m_NextState.m_Mode = Mode::InstrExec;
				}
			}
		}
	}
}

void MultiCycleCache::gui()
{
	// NOTE: Should match Stage::Enum
	static const char* s_Stages[] = {
		"Instruction Fetch #1",
		"Instruction Fetch #2",
		"Decode",
		"Execute",
		"Memory #1",
		"Memory #2",
		"Write Back"
	};

	ImGui::Checkbox("Execute 1 step per tick", &m_SingleStep);

	{
		bool running = m_State.m_Mode == Mode::InstrExec && !m_ICacheNeedsStall && !m_DCacheNeedsStall;
		bool stalled = m_State.m_Mode == Mode::InstrExec && (m_ICacheNeedsStall || m_DCacheNeedsStall);
		bool ptWalk = m_State.m_Mode == Mode::PageTableWalk;
		ImGui::Checkbox("Running", &running);
		ImGui::SameLine();
		ImGui::Checkbox("Stalled", &stalled);
		ImGui::SameLine();
		ImGui::Checkbox("PT Walk", &ptWalk);
	}

	{
		ImGui::PushStyleColor(ImGuiCol_Header, ImVec4(0.26f, 0.59f, 0.98f, 0.80f));
		ImGui::PushStyleColor(ImGuiCol_HeaderHovered, ImVec4(0.26f, 0.59f, 0.98f, 0.31f));
		int stageID = m_State.m_Stage;
		ImGui::ListBox("Stage", &stageID, &s_Stages[0], BX_COUNTOF(s_Stages), -1);
		ImGui::PopStyleColor(2);
	}

	bool icacheCPUReqValid = m_ICacheReq.m_Control.m_Fields.m_Valid == 1;
	ImGui::Checkbox("CPU -> L1 I-Cache", &icacheCPUReqValid);
	ImGui::SameLine();
	{
		char str[256];
		bx::snprintf(str, 256, "0x%08X", m_ICacheReq.m_Addr);
		ImGui::PushItemWidth(80.0f);
		ImGui::InputText("Address", str, 256, ImGuiInputTextFlags_ReadOnly);
		ImGui::PopItemWidth();
	}

	bool dcacheCPUReqValid = m_DCacheReq.m_Control.m_Fields.m_Valid == 1;
	ImGui::Checkbox("CPU -> L1 D-Cache", &dcacheCPUReqValid);
	ImGui::SameLine();
	{
		char str[256];
		bx::snprintf(str, 256, "0x%08X", m_DCacheReq.m_Addr);
		ImGui::PushItemWidth(80.0f);
		ImGui::InputText("Address", str, 256, ImGuiInputTextFlags_ReadOnly);
		ImGui::PopItemWidth();
	}

	bool icacheMemReqValid = m_ICacheMemReq.m_Control.m_Fields.m_Valid == 1;
	ImGui::Checkbox("L1 I-Cache -> RAM", &icacheMemReqValid);
	ImGui::SameLine();
	{
		char str[256];
		bx::snprintf(str, 256, "0x%08X", m_ICacheMemReq.m_Addr);
		ImGui::PushItemWidth(80.0f);
		ImGui::InputText("Address", str, 256, ImGuiInputTextFlags_ReadOnly);
		ImGui::PopItemWidth();
	}

	bool dcacheMemReqValid = m_DCacheMemReq.m_Control.m_Fields.m_Valid == 1;
	ImGui::Checkbox("L1 D-Cache -> RAM", &dcacheMemReqValid);
	ImGui::SameLine();
	{
		char str[256];
		bx::snprintf(str, 256, "0x%08X", m_DCacheMemReq.m_Addr);
		ImGui::PushItemWidth(80.0f);
		ImGui::InputText("Address", str, 256, ImGuiInputTextFlags_ReadOnly);
		ImGui::PopItemWidth();
	}
}
} // namespace cpu
} // namespace riscv
