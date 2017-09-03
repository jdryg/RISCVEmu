#include "cpu.h"
#include "alu.h"
#include "../debug.h"

namespace riscv
{
bool cpuMemRead(CPU* cpu, MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t& data, bool isInstruction);
bool cpuMemWrite(CPU* cpu, MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t data);

void cpuTick_5stage(CPU* cpu, MemoryMap* mm)
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

	// Decode
	switch (opcode) {
	case Opcode::Load:
	{
		// Decode
		const uint32_t loadSize = instr.I.funct3 & 0x03;
		if (loadSize > 2) {
			cpuRaiseException(cpu, Exception::IllegalInstruction);
			goto next_tick;
		} else {
			const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << loadSize) << 3));

			// Execute
			uint32_t virtualAddr = alu(cpuGetRegister(cpu, instr.I.rs1), immI(instr), ALUOperation::Add);

			// Memory
			uint32_t val;
			if (!cpuMemRead(cpu, mm, &cpu->m_DTLB, virtualAddr, byteMask, val, false)) {
				goto next_tick;
			}

			val = instr.I.funct3 & 0x04 // Zero-extend?
				? val
				: sext(val, ((1 << loadSize) << 3) - 1);

			// Write-back
			cpuSetRegister(cpu, instr.I.rd, val);
		}
	}
	break;
	case Opcode::MiscMem:
		// TODO: For now these are just NOPs.
		break;
	case Opcode::OpImm:
	{
		uint32_t res;
		// Decode/Execute
		switch (instr.I.funct3) {
		case ALUOp::AddSub:
			res = alu(cpuGetRegister(cpu, instr.I.rs1), immI(instr), ALUOperation::Add);
			break;
		case ALUOp::ShiftLeft:
			res = alu(cpuGetRegister(cpu, instr.I.rs1), instr.I.imm & 0x1F, ALUOperation::SLL);
			break;
		case ALUOp::SLT:
			res = alu(cpuGetRegister(cpu, instr.I.rs1), immI(instr), ALUOperation::SLT);
			break;
		case ALUOp::SLTU:
			res = alu(cpuGetRegister(cpu, instr.I.rs1), immI(instr), ALUOperation::SLTU);
			break;
		case ALUOp::Xor:
			res = alu(cpuGetRegister(cpu, instr.I.rs1), immI(instr), ALUOperation::Xor);
			break;
		case ALUOp::ShiftRight:
			res = alu(cpuGetRegister(cpu, instr.I.rs1), instr.I.imm & 0x1F, (instr.I.imm & 0x800) ? ALUOperation::SRA : ALUOperation::SRL);
			break;
		case ALUOp::Or:
			res = alu(cpuGetRegister(cpu, instr.I.rs1), immI(instr), ALUOperation::Or);
			break;
		case ALUOp::And:
			res = alu(cpuGetRegister(cpu, instr.I.rs1), immI(instr), ALUOperation::And);
			break;
		default:
			RISCV_CHECK(false, "Invalid funct3 field");
		}

		// Write-back
		cpuSetRegister(cpu, instr.I.rd, res);
	}
	break;
	case Opcode::AUIPC:
	{
		// Execute
		uint32_t res = alu(cpuGetPC(cpu), immU(instr), ALUOperation::Add);

		// Write-back
		cpuSetRegister(cpu, instr.U.rd, res);
	}
	break;
	case Opcode::Store:
	{
		// Decode
		const uint32_t storeSize = instr.S.funct3;
		if (storeSize > 2) {
			cpuRaiseException(cpu, Exception::IllegalInstruction);
			goto next_tick;
		} else {
			const uint32_t byteMask = 0xFFFFFFFF >> (32 - ((1 << storeSize) << 3));

			// Decode
			const uint32_t val = cpuGetRegister(cpu, instr.S.rs2);

			// Decode/Execute
			uint32_t virtualAddr = alu(cpuGetRegister(cpu, instr.S.rs1), immS(instr), ALUOperation::Add);

			// Memory
			if (!cpuMemWrite(cpu, mm, &cpu->m_DTLB, virtualAddr, byteMask, val)) {
				goto next_tick;
			}
		}
	}
	break;
	case Opcode::Op:
	{
		// Decode/Execute
		uint32_t res;
		switch (instr.R.funct3) {
		case ALUOp::AddSub:
			res = alu(cpuGetRegister(cpu, instr.R.rs1), cpuGetRegister(cpu, instr.R.rs2), instr.R.funct7 != 0 ? ALUOperation::Sub : ALUOperation::Add);
			break;
		case ALUOp::ShiftLeft:
			res = alu(cpuGetRegister(cpu, instr.R.rs1), cpuGetRegister(cpu, instr.R.rs2) & 0x1F, ALUOperation::SLL);
			break;
		case ALUOp::SLT:
			res = alu(cpuGetRegister(cpu, instr.R.rs1), cpuGetRegister(cpu, instr.R.rs2), ALUOperation::SLT);
			break;
		case ALUOp::SLTU:
			res = alu(cpuGetRegister(cpu, instr.R.rs1), cpuGetRegister(cpu, instr.R.rs2), ALUOperation::SLTU);
			break;
		case ALUOp::Xor:
			res = alu(cpuGetRegister(cpu, instr.R.rs1), cpuGetRegister(cpu, instr.R.rs2), ALUOperation::Xor);
			break;
		case ALUOp::ShiftRight:
			res = alu(cpuGetRegister(cpu, instr.R.rs1), cpuGetRegister(cpu, instr.R.rs2) & 0x1F, instr.R.funct7 != 0 ? ALUOperation::SRA : ALUOperation::SRL);
			break;
		case ALUOp::Or:
			res = alu(cpuGetRegister(cpu, instr.R.rs1), cpuGetRegister(cpu, instr.R.rs2), ALUOperation::Or);
			break;
		case ALUOp::And:
			res = alu(cpuGetRegister(cpu, instr.R.rs1), cpuGetRegister(cpu, instr.R.rs2), ALUOperation::And);
			break;
		}

		// Write-back
		cpuSetRegister(cpu, instr.R.rd, res);
	}
	break;
	case Opcode::LUI:
		// Decode/Write-back
		cpuSetRegister(cpu, instr.U.rd, immU(instr));
		break;
	case Opcode::Branch:
	{
		// Decode
		const uint32_t polarity = instr.B.funct3 & 0x01;
		const uint32_t unsignedComparison = instr.B.funct3 & 0x02;
		const uint32_t inequality = instr.B.funct3 & 0x04;

		// Execute
		uint32_t res = alu(cpuGetRegister(cpu, instr.B.rs1), cpuGetRegister(cpu, instr.B.rs2), inequality ? (unsignedComparison ? ALUOperation::SLTU : ALUOperation::SLT) : ALUOperation::SEQ);
		res = polarity ? (1 - res) : res;

		// Write-back (PC)
		if (res) {
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
			// Execute
			const uint32_t addr = alu(cpuGetRegister(cpu, instr.I.rs1), immI(instr), ALUOperation::Add);
			if (addr & 0x03) {
				cpuRaiseException(cpu, Exception::InstructionAddressMisaligned);
				goto next_tick;
			} else {
				// Write-back
				cpuSetRegister(cpu, instr.I.rd, pc + 4);

				// Write-back (PC)
				nextPC = addr & 0xFFFFFFFE;
			}
		}
		break;
	case Opcode::JAL:
	{
		// The JAL and JALR instructions will generate a misaligned instruction fetch exception if the target
		// address is not aligned to a four-byte boundary.
		// Execute
		const uint32_t addr = alu(pc, immJ(instr), ALUOperation::Add);
		if (addr & 0x03) {
			cpuRaiseException(cpu, Exception::InstructionAddressMisaligned);
			goto next_tick;
		} else {
			// Write-back
			cpuSetRegister(cpu, instr.J.rd, pc + 4);

			// Write-back (PC)
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