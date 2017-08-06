#include "cpu.h"
#include "memory_map.h"
#include "../debug.h"
#include "../syscall.h"
#include <bx/bx.h>

namespace riscv
{
#define SATP_MODE_MASK        0x80000000
#define SATP_PTPPN_MASK       0x003FFFFF // Page Table Physical Page Number

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

bool cpuMemRead(CPU* cpu, MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t& data, bool isInstruction)
{
	if (tlb == nullptr) {
		// Virtual address is the physical address.
		return mmRead(mm, virtualAddress, 0xFFFFFFFF, data);
	}

	// Memory read with a TLB
	const uint32_t virtualPageNumber = (virtualAddress & kVirtualPageNumberMask) >> kPageShift;
	TLBLookupResult tlbResult = tlbLookup(tlb, virtualPageNumber);
	if (tlbResult.m_Hit) {
		const uint32_t pageProtectionFlags = tlbResult.m_ProtectionFlags;
		const uint32_t requiredProtectionFlags = PROTECTION_READ | (isInstruction ? PROTECTION_EXECUTE : 0);
		if ((pageProtectionFlags & requiredProtectionFlags) != requiredProtectionFlags) {
			const uint32_t offset = virtualAddress & kAddressOffsetMask;
			const TLB::physical_addr_t physicalAddress = (tlbResult.m_PhysicalFrameNumber << kPageShift) | offset;
			return mmRead(mm, physicalAddress, 0xFFFFFFFF, data);
		} else {
			RISCV_CHECK(false, "Protection fault"); // TODO: Raise exception
		}
	} else {
		// NOTE: If the code below happens in the HW then we can access satp CSR without checking for the current
		// privilege mode. If it happens in SW we must raise an exception, switch to M-mode and then read the satp.
		// The problem with a SW implementation is that there are no instructions to update the TLB. So we either 
		// have to define new instructions (i.e. similarly to lowRISC/Rocket*) or implement this in HW.
		// (*): If I understood the code correctly (see http://www.lowrisc.org/docs/tagged-memory-v0.1/new-instructions/)
		const uint32_t satp = cpuReadCSR(cpu, CSR::satp);
		if ((satp & SATP_MODE_MASK) == 0) {
			// No translation needed
			// TODO: Should this check be moved before TLB lookup?
			return mmRead(mm, virtualAddress, 0xFFFFFFFF, data);
		} else {
			// TODO: Multilevel page table walk (check RWX for all zeros and move to the next level).
			const uint32_t pageTablePPN = satp & SATP_PTPPN_MASK;
			const uint32_t pageTablePhysicalAddr = pageTablePPN << kPageShift; // PT address should be always aligned to page boundaries.
			const uint32_t pageTableEntryPhysicalAddr = pageTablePhysicalAddr + (virtualPageNumber * sizeof(PageTableEntry));
			PageTableEntry pte;
			if (!mmRead(mm, pageTableEntryPhysicalAddr, 0xFFFFFFFF, pte.m_Word)) {
				RISCV_CHECK(false, "Failed to read physical address %08Xh", pageTableEntryPhysicalAddr);
			} else {
				if (!pte.m_Fields.m_Valid) {
					RISCV_CHECK(false, "Segmentation fault"); // TODO: Raise exception
				} else if (pte.m_Fields.m_Read != 1 && pte.m_Fields.m_Execute != 1) {
					RISCV_CHECK(false, "Protection fault"); // TODO: Raise exception
				} else {
					RISCV_CHECK(pte.m_Fields.m_Read != 0 || pte.m_Fields.m_Write != 0 || pte.m_Fields.m_Execute != 0, "PageTable: 2nd level pages not implemented yet");
					tlbInsert(tlb, virtualPageNumber, pte.m_Fields.m_PhysicalPageNumber, (pte.m_Word & PTE_PROTECTION_MASK) >> PTE_PROTECTION_SHIFT);

					// Retry instruction on next tick.
				}
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
	const uint32_t pc = cpuGetPC(cpu);

	Instruction instr;
	if (!cpuMemRead(cpu, mm, &cpu->m_ITLB, pc, instr.m_Word, true)) {
		return; // Exception or retry instruction after filling TLB.
	}
	
	cpuSetPC(cpu, pc + 4);

	// Opcode is common to all instruction types.
	const uint32_t opcode = instr.R.opcode;
	if ((opcode & 3) != 3) {
		cpuRaiseException(cpu, Exception::IllegalInstruction);
		return;
	}

	switch (opcode) {
	case Opcode::Load:
	{
		const uint32_t loadSize = instr.I.funct3 & 0x03;
		if (loadSize > 2) {
			cpuRaiseException(cpu, Exception::IllegalInstruction);
		} else {
			const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << loadSize) << 3));
			const uint32_t virtualAddr = cpuGetRegister(cpu, instr.I.rs1) + immI(instr);

			// TODO: Address translation
			uint32_t val;
			if (!mmRead(mm, virtualAddr, byteMask, val)) {
				cpuRaiseException(cpu, Exception::LoadAccessFault); // Or is it LoadPageFault?
			} else {
				const uint32_t zeroExtend = instr.I.funct3 & 0x04;
				if (zeroExtend) {
					cpuSetRegister(cpu, instr.I.rd, val);
				} else {
					const uint32_t signBitPos = ((1 << loadSize) << 3) - 1;
					cpuSetRegister(cpu, instr.I.rd, sext(val, signBitPos));
				}
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
		} else {
			const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << storeSize) << 3));
			const uint32_t virtualAddr = cpuGetRegister(cpu, instr.S.rs1) + immS(instr);
			const uint32_t val = cpuGetRegister(cpu, instr.S.rs2);

			// TODO: Address translation
			if (!mmWrite(mm, virtualAddr, byteMask, val)) {
				cpuRaiseException(cpu, Exception::StoreAccessFault); // Or is it StorePageFault?
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
			break;
		}

		if (jump) {
			cpuSetPC(cpu, pc + immB(instr));
		}
	}
		break;
	case Opcode::JALR:
		if (instr.I.funct3 != 0) {
			cpuRaiseException(cpu, Exception::IllegalInstruction);
		} else {
			// The JAL and JALR instructions will generate a misaligned instruction fetch exception if the target
			// address is not aligned to a four-byte boundary.
			const uint32_t addr = (cpuGetRegister(cpu, instr.I.rs1) + immI(instr));
			if (addr & 0x03) {
				cpuRaiseException(cpu, Exception::InstructionAddressMisaligned);
			} else {
				cpuSetRegister(cpu, instr.I.rd, pc + 4);
				cpuSetPC(cpu, addr & 0xFFFFFFFE);
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
		} else {
			cpuSetRegister(cpu, instr.J.rd, pc + 4);
			cpuSetPC(cpu, addr);
		}
	}
		break;
	case Opcode::System:
		switch (instr.I.funct3) {
		case 0: // ECALL, EBREAK, XRET
			if (instr.I.rd != 0 || instr.I.rs1 != 0) {
				cpuRaiseException(cpu, Exception::IllegalInstruction);
			} else {
				switch (instr.I.imm) {
				case 0: // ECALL
					if (cpuGetPrivLevel(cpu) == PrivLevel::User) {
						cpuRaiseException(cpu, Exception::EnvCallFromUser);
					} else {
						RISCV_CHECK(false, "This should neven happen because the return of the syscall handler will call mret which return us to user mode.");
						cpuRaiseException(cpu, Exception::EnvCallFromMachine);
					}
					break;
				case 1: // EBREAK
					cpuRaiseException(cpu, Exception::Breakpoint);
					break;
				default:
					if ((instr.I.imm & 0x1F) == 2) {
						// XRET
						if ((instr.I.imm >> 8) > cpuGetPrivLevel(cpu)) {
							cpuRaiseException(cpu, Exception::IllegalInstruction);
						} else {
							cpuReturnFromException(cpu);
						}
					} else {
						cpuRaiseException(cpu, Exception::IllegalInstruction);
					}
					break;
				}
			}
			break;
		case 1: // CSRRW
			if (instr.I.rd != 0) {
				cpuSetRegister(cpu, instr.I.rd, cpuGetCSR(cpu, instr.I.imm));
			}
			cpuSetCSR(cpu, instr.I.imm, cpuGetRegister(cpu, instr.I.rs1));
			break;
		case 2: // CSRRS
			cpuSetRegister(cpu, instr.I.rd, cpuGetCSR(cpu, instr.I.imm));
			if (instr.I.rs1 != 0) {
				cpuSetCSR(cpu, instr.I.imm, cpuGetCSR(cpu, instr.I.imm) | cpuGetRegister(cpu, instr.I.rs1));
			}
			break;
		case 3: // CSRRC
			cpuSetRegister(cpu, instr.I.rd, cpuGetCSR(cpu, instr.I.imm));
			if (instr.I.rs1 != 0) {
				cpuSetCSR(cpu, instr.I.imm, cpuGetCSR(cpu, instr.I.imm) & (~cpuGetRegister(cpu, instr.I.rs1)));
			}
			break;
		case 5: // CSRRWI
			if (instr.I.rd != 0) {
				cpuSetRegister(cpu, instr.I.rd, cpuGetCSR(cpu, instr.I.imm));
			}
			cpuSetCSR(cpu, instr.I.imm, instr.I.rs1);
			break;
		case 6: // CSRRSI
			cpuSetRegister(cpu, instr.I.rd, cpuGetCSR(cpu, instr.I.imm));
			if (instr.I.rs1 != 0) {
				cpuSetCSR(cpu, instr.I.imm, cpuGetCSR(cpu, instr.I.imm) | instr.I.rs1);
			}
			break;
		case 7: // CSRRCI
			cpuSetRegister(cpu, instr.I.rd, cpuGetCSR(cpu, instr.I.imm));
			if (instr.I.rs1 != 0) {
				cpuSetCSR(cpu, instr.I.imm, cpuGetCSR(cpu, instr.I.imm) & (~instr.I.rs1));
			}
			break;
		default:
			// Invalid instruction
			break;
		}
		break;
	default:
		cpuRaiseException(cpu, Exception::IllegalInstruction);
		break;
	}

	// Update counters
	const uint32_t countersEnabled = cpuGetCSR(cpu, CSR::mcounteren);
	if (countersEnabled & MCOUNTEREN_CY) {
		cpuIncCounter64(cpu, CSR::mcycle, 1);
		cpuShadowCSR64(cpu, CSR::cycle, CSR::mcycle);
	}
	if (countersEnabled & MCOUNTEREN_IR) {
		cpuIncCounter64(cpu, CSR::minstret, 1);
		cpuShadowCSR64(cpu, CSR::instret, CSR::minstret);
	}

	// Switch states
	bx::memCopy(&cpu->m_State, &cpu->m_NextState, sizeof(CPUState));
}
}
