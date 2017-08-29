#include "cpu.h"
#include "memory_map.h"
#include "../debug.h"
#include <bx/bx.h>

namespace riscv
{
#define PTE_PROTECTION_MASK   0x0000000E
#define PTE_PROTECTION_SHIFT  1

#define PROTECTION_READ       0x00000001
#define PROTECTION_WRITE      0x00000002
#define PROTECTION_EXECUTE    0x00000004

#define MCOUNTEREN_CY         0x00000001
#define MCOUNTEREN_TM         0x00000002
#define MCOUNTEREN_IR         0x00000004

void cpuReset(CPU* cpu, word_t pc, word_t sp)
{
	tlbInit(&cpu->m_ITLB, 16);
	tlbInit(&cpu->m_DTLB, 16);

	cpu->m_NextState.m_PrivLevel = PrivLevel::Machine;
	cpu->m_NextState.m_IRegs[0] = 0;
	cpu->m_NextState.m_IRegs[2] = sp;
	cpu->m_NextState.m_PC = pc;
	bx::memSet(cpu->m_NextState.m_CSR, 0, sizeof(word_t) * 4096);
	cpu->m_NextState.m_CSR[CSR::misa] = 0x40100100; // RV32IU
	cpu->m_NextState.m_CSR[CSR::mimpid] = 0x00010000; // v1.0
	cpu->m_NextState.m_CSR[CSR::mcounteren] = MCOUNTEREN_CY | MCOUNTEREN_IR; // TODO: Q: Should those be enabled by the kernel?
	bx::memCopy(&cpu->m_State, &cpu->m_NextState, sizeof(CPUState));
}

bool cpuMemRead(CPU* cpu, MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t& data, bool isInstruction)
{
	if (tlb == nullptr || cpuGetPrivLevel(cpu) == PrivLevel::Machine) {
		// Virtual address is the physical address.
		if (!mmRead(mm, virtualAddress, byteMask, data)) {
			cpuRaiseException(cpu, Exception::LoadAccessFault); // Or is it LoadPageFault?
			return false;
		}

		return true;
	}

	// Memory read with a TLB
	const uint32_t virtualPageNumber = (virtualAddress & kVirtualPageNumberMask) >> kPageShift;
	TLBLookupResult tlbResult = tlbLookup(tlb, virtualPageNumber);
	if (tlbResult.m_Hit) {
		const uint32_t pageProtectionFlags = tlbResult.m_ProtectionFlags;
		const uint32_t requiredProtectionFlags = PROTECTION_READ | (isInstruction ? PROTECTION_EXECUTE : 0);
		if ((pageProtectionFlags & requiredProtectionFlags) == requiredProtectionFlags) {
			const uint32_t offset = virtualAddress & kAddressOffsetMask;
			const TLB::physical_addr_t physicalAddress = (tlbResult.m_PhysicalFrameNumber << kPageShift) | offset;
			if (mmRead(mm, physicalAddress, byteMask, data)) {
				return true;
			}
		}

		cpuRaiseException(cpu, Exception::LoadAccessFault);
		return false;
	}
	
	// NOTE: If the code below happens in the HW then we can access satp CSR without checking for the current
	// privilege mode. If it happens in SW we must raise an exception, switch to M-mode and then read the satp.
	// The problem with a SW implementation is that there are no instructions to update the TLB. So we either 
	// have to define new instructions (i.e. similarly to lowRISC/Rocket*) or implement this in HW.
	// (*): If I understood the code correctly (see http://www.lowrisc.org/docs/tagged-memory-v0.1/new-instructions/)
	const uint32_t satp = cpuGetCSR(cpu, CSR::satp);
	if ((satp & SATP_MODE_MASK) == 0) {
		// No translation needed
		// TODO: Should this check be moved before TLB lookup?
		if (mmRead(mm, virtualAddress, byteMask, data)) {
			return true;
		}

		cpuRaiseException(cpu, Exception::LoadAccessFault);
	} else {
		// TODO: Multilevel page table walk (check RWX for all zeros and move to the next level).
		const uint32_t pageTablePPN = satp & SATP_PTPPN_MASK;
		const uint32_t pageTablePhysicalAddr = pageTablePPN << kPageShift; // PT address should be always aligned to page boundaries.
		const uint32_t pageTableEntryPhysicalAddr = pageTablePhysicalAddr + (virtualPageNumber * sizeof(PageTableEntry));
		PageTableEntry pte;
		if (!mmRead(mm, pageTableEntryPhysicalAddr, 0xFFFFFFFF, pte.m_Word)) {
			cpuRaiseException(cpu, Exception::LoadAccessFault);
		} else {
			if (!pte.m_Fields.m_Valid) {
				cpuRaiseException(cpu, Exception::LoadPageFault);
			} else if (pte.m_Fields.m_Read != 1 && pte.m_Fields.m_Execute != 1) {
				cpuRaiseException(cpu, Exception::LoadAccessFault);
			} else {
				RISCV_CHECK(pte.m_Fields.m_Read != 0 || pte.m_Fields.m_Write != 0 || pte.m_Fields.m_Execute != 0, "PageTable: 2nd level pages not implemented yet");
				tlbInsert(tlb, virtualPageNumber, pte.m_Fields.m_PhysicalPageNumber, (pte.m_Word & PTE_PROTECTION_MASK) >> PTE_PROTECTION_SHIFT);
				
				// Retry instruction on next tick.
			}
		}
	}

	return false;
}

bool cpuMemWrite(CPU* cpu, MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t data)
{
	if (tlb == nullptr || cpuGetPrivLevel(cpu) == PrivLevel::Machine) {
		// Virtual address is the physical address.
		if (!mmWrite(mm, virtualAddress, byteMask, data)) {
			cpuRaiseException(cpu, Exception::StoreAccessFault);
			return false;
		}

		return true;
	}

	// Memory write with a TLB
	const uint32_t virtualPageNumber = (virtualAddress & kVirtualPageNumberMask) >> kPageShift;
	TLBLookupResult tlbResult = tlbLookup(tlb, virtualPageNumber);
	if (tlbResult.m_Hit) {
		const uint32_t pageProtectionFlags = tlbResult.m_ProtectionFlags;
		const uint32_t requiredProtectionFlags = PROTECTION_WRITE;
		if ((pageProtectionFlags & requiredProtectionFlags) == requiredProtectionFlags) {
			const uint32_t offset = virtualAddress & kAddressOffsetMask;
			const TLB::physical_addr_t physicalAddress = (tlbResult.m_PhysicalFrameNumber << kPageShift) | offset;
			if (mmWrite(mm, physicalAddress, byteMask, data)) {
				return true;
			}
		}

		cpuRaiseException(cpu, Exception::StoreAccessFault);
		return false;
	}

	// NOTE: If the code below happens in the HW then we can access satp CSR without checking for the current
	// privilege mode. If it happens in SW we must raise an exception, switch to M-mode and then read the satp.
	// The problem with a SW implementation is that there are no instructions to update the TLB. So we either 
	// have to define new instructions (i.e. similarly to lowRISC/Rocket*) or implement this in HW.
	// (*): If I understood the code correctly (see http://www.lowrisc.org/docs/tagged-memory-v0.1/new-instructions/)
	const uint32_t satp = cpuGetCSR(cpu, CSR::satp);
	if ((satp & SATP_MODE_MASK) == 0) {
		// No translation needed
		// TODO: Should this check be moved before TLB lookup?
		if (mmWrite(mm, virtualAddress, byteMask, data)) {
			return true;
		}

		cpuRaiseException(cpu, Exception::StoreAccessFault);
	} else {
		// TODO: Multilevel page table walk (check RWX for all zeros and move to the next level).
		const uint32_t pageTablePPN = satp & SATP_PTPPN_MASK;
		const uint32_t pageTablePhysicalAddr = pageTablePPN << kPageShift; // PT address should be always aligned to page boundaries.
		const uint32_t pageTableEntryPhysicalAddr = pageTablePhysicalAddr + (virtualPageNumber * sizeof(PageTableEntry));
		PageTableEntry pte;
		if (!mmRead(mm, pageTableEntryPhysicalAddr, 0xFFFFFFFF, pte.m_Word)) {
			cpuRaiseException(cpu, Exception::LoadAccessFault);
		} else {
			if (!pte.m_Fields.m_Valid) {
				cpuRaiseException(cpu, Exception::StorePageFault);
			} else if (pte.m_Fields.m_Write != 1) {
				cpuRaiseException(cpu, Exception::StoreAccessFault);
			} else {
				RISCV_CHECK(pte.m_Fields.m_Read != 0 || pte.m_Fields.m_Write != 0 || pte.m_Fields.m_Execute != 0, "PageTable: 2nd level pages not implemented yet");
				tlbInsert(tlb, virtualPageNumber, pte.m_Fields.m_PhysicalPageNumber, (pte.m_Word & PTE_PROTECTION_MASK) >> PTE_PROTECTION_SHIFT);

				// Retry instruction on next tick.
			}
		}
	}

	return false;
}

// Issues: Multiple memory reads and writes in a single cycle (assuming Von Neumann architecture).
// A single read (read next instruction) and a single write (i.e. from store instructions) can be implemented
// by using both the rising and falling edge of the clock. But a 2nd read (i.e. from load instructions) cannot
// be implemented (requires a combinational read from memory; if at all possible).
void cpuTick_SingleCycle(CPU* cpu, MemoryMap* mm)
{
	// Clear the breakpoint output
	cpu->m_NextState.m_Breakpoint = false;

	const uint32_t pc = cpuGetPC(cpu);
	uint32_t nextPC = pc + 4;

	Instruction instr;
	if (!cpuMemRead(cpu, mm, &cpu->m_ITLB, pc, 0xFFFFFFFF, instr.m_Word, true)) {
		goto next_tick; // Exception or retry instruction after filling TLB.
	}

	// Opcode is common to all instruction types.
	const uint32_t opcode = instr.R.opcode;
	if ((opcode & 3) != 3) {
		cpuRaiseException(cpu, Exception::IllegalInstruction);
		goto next_tick;
	}

	switch (opcode) {
	case Opcode::Load:
	{
		const uint32_t loadSize = instr.I.funct3 & 0x03;
		if (loadSize > 2) {
			cpuRaiseException(cpu, Exception::IllegalInstruction);
			goto next_tick;
		} else {
			const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << loadSize) << 3));
			const uint32_t virtualAddr = cpuGetRegister(cpu, instr.I.rs1) + immI(instr);

			uint32_t val;
			if (!cpuMemRead(cpu, mm, &cpu->m_DTLB, virtualAddr, byteMask, val, false)) {
				goto next_tick;
			}

			const uint32_t zeroExtend = instr.I.funct3 & 0x04;
			if (zeroExtend) {
				cpuSetRegister(cpu, instr.I.rd, val);
			} else {
				const uint32_t signBitPos = ((1 << loadSize) << 3) - 1;
				cpuSetRegister(cpu, instr.I.rd, sext(val, signBitPos));
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
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) + immI(instr));
			break;
		case ALUOp::ShiftLeft:
		{
			const uint32_t shamt = instr.I.imm & 0x1F;
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) << shamt);
		}
			break;
		case ALUOp::SLT:
			cpuSetRegister(cpu, instr.I.rd, (word_t)((int32_t)cpuGetRegister(cpu, instr.I.rs1) < (int32_t)immI(instr) ? 1 : 0));
			break;
		case ALUOp::SLTU:
			cpuSetRegister(cpu, instr.I.rd, (word_t)(cpuGetRegister(cpu, instr.I.rs1) < immI(instr) ? 1 : 0));
			break;
		case ALUOp::Xor:
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) ^ immI(instr));
			break;
		case ALUOp::ShiftRight:
		{
			const uint32_t shamt = instr.I.imm & 0x1F;
			const uint32_t arithmeticShift = instr.I.imm & 0x800;
			if (arithmeticShift) {
				cpuSetRegister(cpu, instr.I.rd, (word_t)((int32_t)cpuGetRegister(cpu, instr.I.rs1) >> shamt));
			} else {
				cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) >> shamt);
			}
		}
			break;
		case ALUOp::Or:
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) | immI(instr));
			break;
		case ALUOp::And:
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) & immI(instr));
			break;
		}
		break;
	case Opcode::AUIPC:
		cpuSetRegister(cpu, instr.U.rd, pc + immU(instr));
		break;
	case Opcode::Store:
	{
		const uint32_t storeSize = instr.S.funct3;
		if (storeSize > 2) {
			cpuRaiseException(cpu, Exception::IllegalInstruction);
			goto next_tick;
		} else {
			const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << storeSize) << 3));
			const uint32_t virtualAddr = cpuGetRegister(cpu, instr.S.rs1) + immS(instr);
			const uint32_t val = cpuGetRegister(cpu, instr.S.rs2);

			if (!cpuMemWrite(cpu, mm, &cpu->m_DTLB, virtualAddr, byteMask, val)) {
				goto next_tick;
			}
		}
	}
		break;
	case Opcode::Op:
		switch (instr.R.funct3) {
		case ALUOp::AddSub:
			if (instr.R.funct7 != 0) {
				cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) - cpuGetRegister(cpu, instr.R.rs2));
			} else {
				cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) + cpuGetRegister(cpu, instr.R.rs2));
			}
			break;
		case ALUOp::ShiftLeft:
			cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) << (cpuGetRegister(cpu, instr.R.rs2) & 0x1F));
			break;
		case ALUOp::SLT:
			cpuSetRegister(cpu, instr.R.rd, (word_t)((int32_t)cpuGetRegister(cpu, instr.R.rs1) < (int32_t)cpuGetRegister(cpu, instr.R.rs2) ? 1 : 0));
			break;
		case ALUOp::SLTU:
			cpuSetRegister(cpu, instr.R.rd, (word_t)(cpuGetRegister(cpu, instr.R.rs1) < cpuGetRegister(cpu, instr.R.rs2) ? 1 : 0));
			break;
		case ALUOp::Xor:
			cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) ^ cpuGetRegister(cpu, instr.R.rs2));
			break;
		case ALUOp::ShiftRight:
			if (instr.R.funct7 != 0) {
				cpuSetRegister(cpu, instr.R.rd, (word_t)((int32_t)cpuGetRegister(cpu, instr.R.rs1) >> (cpuGetRegister(cpu, instr.R.rs2) & 0x1F)));
			} else {
				cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) >> (cpuGetRegister(cpu, instr.R.rs2) & 0x1F));
			}
			break;
		case ALUOp::Or:
			cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) | cpuGetRegister(cpu, instr.R.rs2));
			break;
		case ALUOp::And:
			cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) & cpuGetRegister(cpu, instr.R.rs2));
			break;
		}
		break;
	case Opcode::LUI:
		cpuSetRegister(cpu, instr.U.rd, immU(instr));
		break;
	case Opcode::Branch:
	{
		bool jump = false;
		switch (instr.B.funct3) {
		case BranchOp::Equal:
			jump = cpuGetRegister(cpu, instr.B.rs1) == cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::NotEqual:
			jump = cpuGetRegister(cpu, instr.B.rs1) != cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::LessThan:
			jump = (int32_t)cpuGetRegister(cpu, instr.B.rs1) < (int32_t)cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::GreaterEqual:
			jump = (int32_t)cpuGetRegister(cpu, instr.B.rs1) >= (int32_t)cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::LessThanUnsigned:
			jump = cpuGetRegister(cpu, instr.B.rs1) < cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::GreaterEqualUnsigned:
			jump = cpuGetRegister(cpu, instr.B.rs1) >= cpuGetRegister(cpu, instr.B.rs2);
			break;
		default:
			cpuRaiseException(cpu, Exception::IllegalInstruction);
			goto next_tick;
		}

		if (jump) {
			nextPC = pc + immB(instr);
		}
	}
		break;
	case Opcode::JALR:
		if (instr.I.funct3 != 0) {
			cpuRaiseException(cpu, Exception::IllegalInstruction);
			goto next_tick;
		} else {
			// The JAL and JALR instructions will generate a misaligned instruction fetch exception if the target
			// address is not aligned to a four-byte boundary.
			const uint32_t addr = (cpuGetRegister(cpu, instr.I.rs1) + immI(instr));
			if (addr & 0x03) {
				cpuRaiseException(cpu, Exception::InstructionAddressMisaligned);
				goto next_tick;
			} else {
				cpuSetRegister(cpu, instr.I.rd, pc + 4);
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
			cpuRaiseException(cpu, Exception::InstructionAddressMisaligned);
			goto next_tick;
		} else {
			cpuSetRegister(cpu, instr.J.rd, pc + 4);
			nextPC = addr;
		}
	}
		break;
	case Opcode::System:
		if (instr.m_Word == 0x00000073) {
			// ECALL
			if (cpuGetPrivLevel(cpu) == PrivLevel::User) {
				cpuRaiseException(cpu, Exception::EnvCallFromUser);
				goto next_tick;
			} else {
				cpuRaiseException(cpu, Exception::EnvCallFromMachine);
				goto next_tick;
			}
		} else if (instr.m_Word == 0x00100073) {
			// EBREAK
			cpu->m_NextState.m_Breakpoint = true;
//			cpuRaiseException(cpu, Exception::Breakpoint);
//			goto next_tick;
		} else if (instr.m_Word == 0x30200073) {
			// MRET
			if (cpuGetPrivLevel(cpu) != PrivLevel::Machine) {
				cpuRaiseException(cpu, Exception::IllegalInstruction);
				goto next_tick;
			} else {
				cpuReturnFromException(cpu);
				goto next_tick;
			}
		} else if (instr.m_Word == 0x10200073  // SRET
			    || instr.m_Word == 0x00200073  // URET
			    || instr.m_Word == 0x10500073) // WFI
		{
			cpuRaiseException(cpu, Exception::IllegalInstruction);
			goto next_tick;
		} else {
			switch (instr.I.funct3) {
			case 0: // ECALL, EBREAK, xRET, SFENCE.VMA
				// NOTE: ECALL, EBREAK and xRET have been covered with the tests above. Only valid instruction
				// in this case is SFENCE.VMA.
				if (instr.R.funct7 == 9) {
					// SFENCE.VMA
					// Ignore rs1 and rs2 (afaict they are just hints). Flush both TLBs
					tlbFlush(&cpu->m_DTLB);
					tlbFlush(&cpu->m_ITLB);
				} else {
					cpuRaiseException(cpu, Exception::IllegalInstruction);
					goto next_tick;
				}
				break;
			case 1: // CSRRW
				if (instr.I.rd != 0) {
					cpuSetRegister(cpu, instr.I.rd, cpuReadCSR(cpu, instr.I.imm));
				}
				cpuWriteCSR(cpu, instr.I.imm, cpuGetRegister(cpu, instr.I.rs1));
				break;
			case 2: // CSRRS
				cpuSetRegister(cpu, instr.I.rd, cpuReadCSR(cpu, instr.I.imm));
				if (instr.I.rs1 != 0) {
					cpuWriteCSR(cpu, instr.I.imm, cpuReadCSR(cpu, instr.I.imm) | cpuGetRegister(cpu, instr.I.rs1));
				}
				break;
			case 3: // CSRRC
				cpuSetRegister(cpu, instr.I.rd, cpuReadCSR(cpu, instr.I.imm));
				if (instr.I.rs1 != 0) {
					cpuWriteCSR(cpu, instr.I.imm, cpuReadCSR(cpu, instr.I.imm) & (~cpuGetRegister(cpu, instr.I.rs1)));
				}
				break;
			case 5: // CSRRWI
				if (instr.I.rd != 0) {
					cpuSetRegister(cpu, instr.I.rd, cpuReadCSR(cpu, instr.I.imm));
				}
				cpuWriteCSR(cpu, instr.I.imm, instr.I.rs1);
				break;
			case 6: // CSRRSI
				cpuSetRegister(cpu, instr.I.rd, cpuReadCSR(cpu, instr.I.imm));
				if (instr.I.rs1 != 0) {
					cpuWriteCSR(cpu, instr.I.imm, cpuReadCSR(cpu, instr.I.imm) | instr.I.rs1);
				}
				break;
			case 7: // CSRRCI
				cpuSetRegister(cpu, instr.I.rd, cpuReadCSR(cpu, instr.I.imm));
				if (instr.I.rs1 != 0) {
					cpuWriteCSR(cpu, instr.I.imm, cpuReadCSR(cpu, instr.I.imm) & (~instr.I.rs1));
				}
				break;
			default:
				cpuRaiseException(cpu, Exception::IllegalInstruction);
				goto next_tick;
			}
		}
		break;
	default:
		cpuRaiseException(cpu, Exception::IllegalInstruction);
		goto next_tick;
	}

	// Update counters
#if 0 
	// TODO: How should those be updated when running in U-mode?
	const uint32_t countersEnabled = cpuReadCSR(cpu, CSR::mcounteren);
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
	cpuSetPC(cpu, nextPC);

next_tick:
	bx::memCopy(&cpu->m_State, &cpu->m_NextState, sizeof(CPUState));
}
}
