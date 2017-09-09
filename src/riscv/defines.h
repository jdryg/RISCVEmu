#ifndef RISCV_DEFINES_H
#define RISCV_DEFINES_H

#ifndef XLEN
#define XLEN 32
#endif

#if XLEN == 32
typedef uint32_t word_t;
typedef int32_t iword_t;
typedef uint64_t dword_t;

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

#define MCOUNTEREN_CY       0x00000001
#define MCOUNTEREN_TM       0x00000002
#define MCOUNTEREN_IR       0x00000004

#define PRIV_LEVEL_TO_MSTATUS_MPP_SHIFT 11

#define SATP_MODE_MASK        0x80000000
#define SATP_PTPPN_MASK       0x003FFFFF // Page Table Physical Page Number

#define PTE_PROTECTION_MASK   0x0000000E
#define PTE_PROTECTION_SHIFT  1

#define PROTECTION_READ       0x00000001
#define PROTECTION_WRITE      0x00000002
#define PROTECTION_EXECUTE    0x00000004

#define PAGE_SHIFT                12 // 4k
#define PAGE_SIZE                 4096 // virtual and physical
#define PAGE_ADDRESS_OFFSET_MASK  0x00000FFF // 4095
#define PAGE_NUMBER_MASK          0xFFFFF000 // ~4095

#elif XLEN == 64
typedef uint64_t word_t;
#error "Not implemented yet!";
#else
#error "Invalid XLEN value";
#endif

#endif
