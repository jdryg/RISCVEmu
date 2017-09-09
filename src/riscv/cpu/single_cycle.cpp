#include "single_cycle.h"
#include "../memory_map.h"
#include "../../debug.h"
#include <bx/bx.h>

namespace riscv
{
namespace cpu
{
SingleCycle::SingleCycle()
{
}

SingleCycle::~SingleCycle()
{
}

void SingleCycle::reset(word_t pc)
{
	tlbInit(&m_ITLB, 16);
	tlbInit(&m_DTLB, 16);

	m_NextState.m_PrivLevel = PrivLevel::Machine;
	m_NextState.m_IRegs[0] = 0;
	m_NextState.m_PC = pc;
	bx::memSet(m_NextState.m_CSR, 0, sizeof(word_t) * 4096);
	m_NextState.m_CSR[CSR::misa] = 0x40100100; // RV32IU
	m_NextState.m_CSR[CSR::mimpid] = 0x00010000; // v1.0
	m_NextState.m_CSR[CSR::mcounteren] = MCOUNTEREN_CY | MCOUNTEREN_IR;
	bx::memCopy(&m_State, &m_NextState, sizeof(State));
}

bool SingleCycle::tick(MemoryMap* mm)
{
	// Clear the breakpoint output
	m_NextState.m_Breakpoint = false;

	const uint32_t pc = m_State.m_PC;
	uint32_t nextPC = pc + 4;

	Instruction instr;
	if (!memRead(mm, &m_ITLB, pc, 0xFFFFFFFF, instr.m_Word, true)) {
		goto next_tick; // Exception or retry instruction after filling TLB.
	}

	// Opcode is common to all instruction types.
	const uint32_t opcode = instr.R.opcode;
	if ((opcode & 3) != 3) {
		raiseException(Exception::IllegalInstruction);
		goto next_tick;
	}

	switch (opcode) {
	case Opcode::Load:
	{
		const uint32_t loadSize = instr.I.funct3 & 0x03;
		if (loadSize > 2) {
			raiseException(Exception::IllegalInstruction);
			goto next_tick;
		} else {
			const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << loadSize) << 3));
			const uint32_t virtualAddr = readReg(instr.I.rs1) + immI(instr);

			uint32_t val;
			if (!memRead(mm, &m_DTLB, virtualAddr, byteMask, val, false)) {
				goto next_tick;
			}

			const uint32_t zeroExtend = instr.I.funct3 & 0x04;
			if (zeroExtend) {
				writeReg(instr.I.rd, val);
			} else {
				const uint32_t signBitPos = ((1 << loadSize) << 3) - 1;
				writeReg(instr.I.rd, sext(val, signBitPos));
			}
		}
	}
	break;
	case Opcode::MiscMem:
		// TODO: For now these are just NOPs.
		break;
	case Opcode::OpImm:
		switch (instr.I.funct3) {
		case ALUOp::AddSub:
			writeReg(instr.I.rd, readReg(instr.I.rs1) + immI(instr));
			break;
		case ALUOp::ShiftLeft:
		{
			const uint32_t shamt = instr.I.imm & 0x1F;
			writeReg(instr.I.rd, readReg(instr.I.rs1) << shamt);
		}
		break;
		case ALUOp::SLT:
			writeReg(instr.I.rd, (word_t)((int32_t)readReg(instr.I.rs1) < (int32_t)immI(instr) ? 1 : 0));
			break;
		case ALUOp::SLTU:
			writeReg(instr.I.rd, (word_t)(readReg(instr.I.rs1) < immI(instr) ? 1 : 0));
			break;
		case ALUOp::Xor:
			writeReg(instr.I.rd, readReg(instr.I.rs1) ^ immI(instr));
			break;
		case ALUOp::ShiftRight:
		{
			const uint32_t shamt = instr.I.imm & 0x1F;
			const uint32_t arithmeticShift = instr.I.imm & 0x800;
			if (arithmeticShift) {
				writeReg(instr.I.rd, (word_t)((int32_t)readReg(instr.I.rs1) >> shamt));
			} else {
				writeReg(instr.I.rd, readReg(instr.I.rs1) >> shamt);
			}
		}
		break;
		case ALUOp::Or:
			writeReg(instr.I.rd, readReg(instr.I.rs1) | immI(instr));
			break;
		case ALUOp::And:
			writeReg(instr.I.rd, readReg(instr.I.rs1) & immI(instr));
			break;
		}
		break;
	case Opcode::AUIPC:
		writeReg(instr.U.rd, pc + immU(instr));
		break;
	case Opcode::Store:
	{
		const uint32_t storeSize = instr.S.funct3;
		if (storeSize > 2) {
			raiseException(Exception::IllegalInstruction);
			goto next_tick;
		} else {
			const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << storeSize) << 3));
			const uint32_t virtualAddr = readReg(instr.S.rs1) + immS(instr);
			const uint32_t val = readReg(instr.S.rs2);

			if (!memWrite(mm, &m_DTLB, virtualAddr, byteMask, val)) {
				goto next_tick;
			}
		}
	}
	break;
	case Opcode::Op:
		switch (instr.R.funct3) {
		case ALUOp::AddSub:
			if (instr.R.funct7 != 0) {
				writeReg(instr.R.rd, readReg(instr.R.rs1) - readReg(instr.R.rs2));
			} else {
				writeReg(instr.R.rd, readReg(instr.R.rs1) + readReg(instr.R.rs2));
			}
			break;
		case ALUOp::ShiftLeft:
			writeReg(instr.R.rd, readReg(instr.R.rs1) << (readReg(instr.R.rs2) & 0x1F));
			break;
		case ALUOp::SLT:
			writeReg(instr.R.rd, (word_t)((int32_t)readReg(instr.R.rs1) < (int32_t)readReg(instr.R.rs2) ? 1 : 0));
			break;
		case ALUOp::SLTU:
			writeReg(instr.R.rd, (word_t)(readReg(instr.R.rs1) < readReg(instr.R.rs2) ? 1 : 0));
			break;
		case ALUOp::Xor:
			writeReg(instr.R.rd, readReg(instr.R.rs1) ^ readReg(instr.R.rs2));
			break;
		case ALUOp::ShiftRight:
			if (instr.R.funct7 != 0) {
				writeReg(instr.R.rd, (word_t)((int32_t)readReg(instr.R.rs1) >> (readReg(instr.R.rs2) & 0x1F)));
			} else {
				writeReg(instr.R.rd, readReg(instr.R.rs1) >> (readReg(instr.R.rs2) & 0x1F));
			}
			break;
		case ALUOp::Or:
			writeReg(instr.R.rd, readReg(instr.R.rs1) | readReg(instr.R.rs2));
			break;
		case ALUOp::And:
			writeReg(instr.R.rd, readReg(instr.R.rs1) & readReg(instr.R.rs2));
			break;
		}
		break;
	case Opcode::LUI:
		writeReg(instr.U.rd, immU(instr));
		break;
	case Opcode::Branch:
	{
		bool jump = false;
		switch (instr.B.funct3) {
		case BranchOp::Equal:
			jump = readReg(instr.B.rs1) == readReg(instr.B.rs2);
			break;
		case BranchOp::NotEqual:
			jump = readReg(instr.B.rs1) != readReg(instr.B.rs2);
			break;
		case BranchOp::LessThan:
			jump = (int32_t)readReg(instr.B.rs1) < (int32_t)readReg(instr.B.rs2);
			break;
		case BranchOp::GreaterEqual:
			jump = (int32_t)readReg(instr.B.rs1) >= (int32_t)readReg(instr.B.rs2);
			break;
		case BranchOp::LessThanUnsigned:
			jump = readReg(instr.B.rs1) < readReg(instr.B.rs2);
			break;
		case BranchOp::GreaterEqualUnsigned:
			jump = readReg(instr.B.rs1) >= readReg(instr.B.rs2);
			break;
		default:
			raiseException(Exception::IllegalInstruction);
			goto next_tick;
		}

		if (jump) {
			nextPC = pc + immB(instr);
		}
	}
	break;
	case Opcode::JALR:
		if (instr.I.funct3 != 0) {
			raiseException(Exception::IllegalInstruction);
			goto next_tick;
		} else {
			// The JAL and JALR instructions will generate a misaligned instruction fetch exception if the target
			// address is not aligned to a four-byte boundary.
			const uint32_t addr = (readReg(instr.I.rs1) + immI(instr));
			if (addr & 0x03) {
				raiseException(Exception::InstructionAddressMisaligned);
				goto next_tick;
			} else {
				writeReg(instr.I.rd, pc + 4);
				nextPC = addr & 0xFFFFFFFE;
			}
		}
		break;
	case Opcode::JAL:
	{
		// The JAL and JALR instructions will generate a misaligned instruction fetch exception if the target
		// address is not aligned to a four-byte boundary.
		const uint32_t addr = pc + immJ(instr);
		if (addr & 0x03) {
			raiseException(Exception::InstructionAddressMisaligned);
			goto next_tick;
		} else {
			writeReg(instr.J.rd, pc + 4);
			nextPC = addr;
		}
	}
	break;
	case Opcode::System:
		if (instr.m_Word == 0x00000073) {
			// ECALL
			if (m_State.m_PrivLevel == PrivLevel::User) {
				raiseException(Exception::EnvCallFromUser);
				goto next_tick;
			} else {
				raiseException(Exception::EnvCallFromMachine);
				goto next_tick;
			}
		} else if (instr.m_Word == 0x00100073) {
			// EBREAK
			m_NextState.m_Breakpoint = true;
		} else if (instr.m_Word == 0x30200073) {
			// MRET
			if (m_State.m_PrivLevel != PrivLevel::Machine) {
				raiseException(Exception::IllegalInstruction);
				goto next_tick;
			} else {
				returnFromException();
				goto next_tick;
			}
		} else if (instr.m_Word == 0x10200073  // SRET
			|| instr.m_Word == 0x00200073  // URET
			|| instr.m_Word == 0x10500073) // WFI
		{
			raiseException(Exception::IllegalInstruction);
			goto next_tick;
		} else {
			switch (instr.I.funct3) {
			case 0: // ECALL, EBREAK, xRET, SFENCE.VMA
				// NOTE: ECALL, EBREAK and xRET have been covered with the tests above. Only valid instruction
				// in this case is SFENCE.VMA.
				if (instr.R.funct7 == 9) {
					// SFENCE.VMA
					// Ignore rs1 and rs2 (afaict they are just hints). Flush both TLBs
					tlbFlush(&m_DTLB);
					tlbFlush(&m_ITLB);
				} else {
					raiseException(Exception::IllegalInstruction);
					goto next_tick;
				}
				break;
			case 1: // CSRRW
				if (instr.I.rd != 0) {
					writeReg(instr.I.rd, readCSR(instr.I.imm));
				}
				writeCSR(instr.I.imm, readReg(instr.I.rs1));
				break;
			case 2: // CSRRS
				writeReg(instr.I.rd, readCSR(instr.I.imm));
				if (instr.I.rs1 != 0) {
					writeCSR(instr.I.imm, readCSR(instr.I.imm) | readReg(instr.I.rs1));
				}
				break;
			case 3: // CSRRC
				writeReg(instr.I.rd, readCSR(instr.I.imm));
				if (instr.I.rs1 != 0) {
					writeCSR(instr.I.imm, readCSR(instr.I.imm) & (~readReg(instr.I.rs1)));
				}
				break;
			case 5: // CSRRWI
				if (instr.I.rd != 0) {
					writeReg(instr.I.rd, readCSR(instr.I.imm));
				}
				writeCSR(instr.I.imm, instr.I.rs1);
				break;
			case 6: // CSRRSI
				writeReg(instr.I.rd, readCSR(instr.I.imm));
				if (instr.I.rs1 != 0) {
					writeCSR(instr.I.imm, readCSR(instr.I.imm) | instr.I.rs1);
				}
				break;
			case 7: // CSRRCI
				writeReg(instr.I.rd, readCSR(instr.I.imm));
				if (instr.I.rs1 != 0) {
					writeCSR(instr.I.imm, readCSR(instr.I.imm) & (~instr.I.rs1));
				}
				break;
			default:
				raiseException(Exception::IllegalInstruction);
				goto next_tick;
			}
		}
		break;
	default:
		raiseException(Exception::IllegalInstruction);
		goto next_tick;
	}

	// Update counters
#if 0 
	// TODO: How should those be updated when running in U-mode?
	const uint32_t countersEnabled = readCSR(CSR::mcounteren);
	if (countersEnabled & MCOUNTEREN_CY) {
		cpuIncCounter64(cpu, CSR::mcycle, 1);
		cpuShadowCSR64(cpu, CSR::cycle, CSR::mcycle);
	}
	if (countersEnabled & MCOUNTEREN_IR) {
		cpuIncCounter64(cpu, CSR::minstret, 1);
		cpuShadowCSR64(cpu, CSR::instret, CSR::minstret);
	}
#endif

	// Switch states
	m_NextState.m_PC = nextPC;

next_tick:
	bx::memCopy(&m_State, &m_NextState, sizeof(State));

	return true;
}

PrivLevel::Enum SingleCycle::getPrivilegeLevel()
{
	return m_State.m_PrivLevel;
}

word_t SingleCycle::getPC()
{
	return m_State.m_PC;
}

word_t SingleCycle::getRegister(uint32_t reg)
{
	RISCV_CHECK(reg < 32, "Requested invalid register");
	return m_State.m_IRegs[reg];
}

word_t SingleCycle::getCSR(uint32_t csr)
{
	RISCV_CHECK(csr <= 0xFFF, "Requested invalid CSR");
	return m_State.m_CSR[csr];
}

dword_t SingleCycle::getCSR64(uint32_t csrLow)
{
	RISCV_CHECK(csrLow <= 0xFFE, "Requested invalid CSR");

	const word_t l = m_State.m_CSR[csrLow];
	const word_t h = m_State.m_CSR[csrLow | 0x80];
	return (dword_t)l | (((dword_t)h) << 32);
}

word_t SingleCycle::getOutputPin(OutputPin::Enum pin)
{
	if (pin == OutputPin::Breakpoint) {
		return m_State.m_Breakpoint ? 1 : 0;
	}

	return 0;
}

bool SingleCycle::getMemWord(MemoryMap* mm, word_t virtualAddress, word_t& data)
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

void SingleCycle::readState(CPUState* state)
{
	state->m_PC = m_State.m_PC;
	bx::memCopy(&state->m_IRegs[0], &m_State.m_IRegs[1], sizeof(word_t) * 31);
}

void SingleCycle::writeCSR(uint32_t csr, word_t val)
{
	RISCV_CHECK(csr <= 0xFFF, "Illegal instruction exception: Invalid CSR");

	if (csrIsReadOnly(csr)) {
		RISCV_CHECK(false, "Illegal instruction exception: Trying to write to a read-only CSR");
		return;
	};

	if (csrGetMinPrivLevel(csr) > m_State.m_PrivLevel) {
		RISCV_CHECK(false, "Illegal instruction exception: Trying to access a privileged CSR");
		return;
	}

	m_NextState.m_CSR[csr] = val;
}

word_t SingleCycle::readCSR(uint32_t csr)
{
	RISCV_CHECK(csr <= 0xFFF, "Illegal instruction exception: Invalid CSR");

	if (csrGetMinPrivLevel(csr) > m_State.m_PrivLevel) {
		RISCV_CHECK(false, "Illegal instruction exception: Trying to access a privileged CSR");
		return 0;
	}

	return m_State.m_CSR[csr];
}

void SingleCycle::raiseException(Exception::Enum cause)
{
	// TODO: Set mtval in case the exception has a valid value.
	const uint32_t mstatus = m_State.m_CSR[CSR::mstatus];
	m_NextState.m_CSR[CSR::mstatus] = (mstatus & ~MSTATUS_MASK_MPP) | (m_State.m_PrivLevel << PRIV_LEVEL_TO_MSTATUS_MPP_SHIFT);
	m_NextState.m_CSR[CSR::mcause] = (word_t)cause;
	m_NextState.m_CSR[CSR::mepc] = m_State.m_PC;
	m_NextState.m_PrivLevel = PrivLevel::Machine;
	m_NextState.m_PC = m_State.m_CSR[CSR::mtvec];
}

void SingleCycle::returnFromException()
{
	RISCV_CHECK(m_State.m_PrivLevel == PrivLevel::Machine, "Illegal instruction exception");

	// Switch to the priviledge level indicated by MPP bits in mstatus register.
	m_NextState.m_PrivLevel = (PrivLevel::Enum)((readCSR(CSR::mstatus) & MSTATUS_MASK_MPP) >> PRIV_LEVEL_TO_MSTATUS_MPP_SHIFT);
	m_NextState.m_PC = readCSR(CSR::mepc);
}

// NOTE: Doesn't support superpages. Pages are always 4k independent of their level in the hierarchy.
void SingleCycle::pageTableWalk(MemoryMap* mm, TLB* tlb, uint32_t satp, uint32_t vpn, bool read, bool write, bool execute, bool isStore)
{
	// Algorithm from section 4.3.2 (RISC-V Privileged Architectures v1.10)
	// 1. Let pageTablePPN be satp.ppn * PAGESIZE, and let level = LEVELS - 1. (For Sv32, PAGESIZE = 212 and LEVELS = 2.)
	uint32_t pageTablePhysicalAddr = (satp & SATP_PTPPN_MASK) << PAGE_SHIFT;
	uint32_t level = 1;
	uint32_t vpnLevel[2] = { vpn & 1023, (vpn >> 10) & 1023 };
	while (true) {
		// 2. Let pte be the value of the PTE at address a + va.vpn[i] * PTESIZE. (For Sv32, PTESIZE=4.)
		const uint32_t pageTableEntryPhysicalAddr = pageTablePhysicalAddr + (vpnLevel[level] * sizeof(PageTableEntry));
		PageTableEntry pte;
		if (!mmRead(mm, pageTableEntryPhysicalAddr, 0xFFFFFFFF, pte.m_Word)) {
			// 2. If accessing pte violates a PMA or PMP check, raise an access exception.
			raiseException(isStore ? Exception::StoreAccessFault : Exception::LoadAccessFault);
			break;
		} else {
			// 3. If pte.v = 0, or if pte.r = 0 and pte.w = 1, stop and raise a page-fault exception.
			if (!pte.m_Fields.m_Valid || (pte.m_Fields.m_Read == 0 && pte.m_Fields.m_Write == 1)) {
				raiseException(isStore ? Exception::StorePageFault : Exception::LoadPageFault);
				break;
			} else {
				// 4. Otherwise, the PTE is valid. 
				// If pte.r = 1 or pte.x = 1, go to step 5. Otherwise, this PTE is a pointer to the next level 
				// of the page table. Let level = level - 1. If level < 0, stop and raise a page-fault exception.
				// Otherwise, let pageTablePhysicalAddr = pte.ppn * PAGESIZE and go to step 2.
				if (pte.m_Fields.m_Read != 1 && pte.m_Fields.m_Execute != 1) {
					if (level == 0) {
						raiseException(isStore ? Exception::StorePageFault : Exception::LoadPageFault);
						break;
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
					raiseException(isStore ? Exception::StorePageFault : Exception::LoadPageFault);
					break;
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
}

bool SingleCycle::memRead(MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t& data, bool isInstruction)
{
	if (tlb == nullptr || m_State.m_PrivLevel == PrivLevel::Machine) {
		// Virtual address is the physical address.
		if (!mmRead(mm, virtualAddress, byteMask, data)) {
			raiseException(Exception::LoadAccessFault); // Or is it LoadPageFault?
			return false;
		}

		return true;
	}

	// Memory read with a TLB
	const uint32_t virtualPageNumber = (virtualAddress & PAGE_NUMBER_MASK) >> PAGE_SHIFT;
	TLBLookupResult tlbResult = tlbLookup(tlb, virtualPageNumber);
	if (tlbResult.m_Hit) {
		const uint32_t pageProtectionFlags = tlbResult.m_ProtectionFlags;
		const uint32_t requiredProtectionFlags = PROTECTION_READ | (isInstruction ? PROTECTION_EXECUTE : 0);
		if ((pageProtectionFlags & requiredProtectionFlags) == requiredProtectionFlags) {
			const uint32_t offset = virtualAddress & PAGE_ADDRESS_OFFSET_MASK;
			const TLB::physical_addr_t physicalAddress = (tlbResult.m_PhysicalFrameNumber << PAGE_SHIFT) | offset;
			if (mmRead(mm, physicalAddress, byteMask, data)) {
				return true;
			}
		}

		raiseException(Exception::LoadAccessFault);
		return false;
	}

	// NOTE: If the code below happens in the HW then we can access satp CSR without checking for the current
	// privilege mode. If it happens in SW we must raise an exception, switch to M-mode and then read the satp.
	// The problem with a SW implementation is that there are no instructions to update the TLB. So we either 
	// have to define new instructions (i.e. similarly to lowRISC/Rocket*) or implement this in HW.
	// (*): If I understood the code correctly (see http://www.lowrisc.org/docs/tagged-memory-v0.1/new-instructions/)
	const uint32_t satp = m_State.m_CSR[CSR::satp];
	if ((satp & SATP_MODE_MASK) == 0) {
		// No translation needed
		// TODO: Should this check be moved before TLB lookup?
		if (mmRead(mm, virtualAddress, byteMask, data)) {
			return true;
		}

		raiseException(Exception::LoadAccessFault);
	} else {
		pageTableWalk(mm, tlb, satp, virtualPageNumber, true, false, isInstruction, false);
	}

	return false;
}

bool SingleCycle::memWrite(MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t data)
{
	if (tlb == nullptr || m_State.m_PrivLevel == PrivLevel::Machine) {
		// Virtual address is the physical address.
		if (!mmWrite(mm, virtualAddress, byteMask, data)) {
			raiseException(Exception::StoreAccessFault);
			return false;
		}

		return true;
	}

	// Memory write with a TLB
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

		raiseException(Exception::StoreAccessFault);
		return false;
	}

	const uint32_t satp = m_State.m_CSR[CSR::satp];
	if ((satp & SATP_MODE_MASK) == 0) {
		if (mmWrite(mm, virtualAddress, byteMask, data)) {
			return true;
		}

		raiseException(Exception::StoreAccessFault);
	} else {
		pageTableWalk(mm, tlb, satp, virtualPageNumber, false, true, false, true);
	}

	return false;
}
} // namespace cpu
} // namespace riscv
