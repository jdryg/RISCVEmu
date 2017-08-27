#ifndef HAL_H
#define HAL_H

#include <stdint.h>

#define MSTATUS_SD          0x80000000
#define MSTATUS_TSR         0x00400000
#define MSTATUS_TW          0x00200000
#define MSTATUS_TVM         0x00100000
#define MSTATUS_MXR         0x00080000
#define MSTATUS_SUM         0x00040000
#define MSTATUS_MPRV        0x00020000
#define MSTATUS_XS          0x00018000
#define MSTATUS_FS          0x00006000
#define MSTATUS_MPP         0x00001800
#define MSTATUS_SPP         0x00000100
#define MSTATUS_MPIE        0x00000080
#define MSTATUS_SPIE        0x00000020
#define MSTATUS_UPIE        0x00000010
#define MSTATUS_MIE         0x00000008
#define MSTATUS_SIE         0x00000002
#define MSTATUS_UIE         0x00000001

#define MSTATUS_MPP_SHIFT   11

#define MSTATUS_BIT_MPP0    11
#define MSTATUS_BIT_MPP1    12

#define PRIVLEVEL_USER      0
#define PRIVLEVEL_MACHINE   3

#define CSR_MSTATUS 0x300

inline uint8_t halReadReg8(uintptr_t physicalAddress)
{
    volatile uint8_t* ptr = (uint8_t*)physicalAddress;
	return *ptr;
}

inline uint16_t halReadReg16(uintptr_t physicalAddress)
{
    volatile uint16_t* ptr = (uint16_t*)physicalAddress;
	return *ptr;
}

inline uint32_t halReadReg32(uintptr_t physicalAddress)
{
    volatile uint32_t* ptr = (uint32_t*)physicalAddress;
    return *ptr;
}

inline void halWriteReg8(uintptr_t physicalAddress, uint8_t val)
{
	volatile uint8_t* ptr = (uint8_t*)physicalAddress;
	*ptr = val;
}

inline void halWriteReg16(uintptr_t physicalAddress, uint16_t val)
{
	volatile uint16_t* ptr = (uint16_t*)physicalAddress;
	*ptr = val;
}

inline void halWriteReg32(uintptr_t physicalAddress, uint32_t val)
{
	volatile uint32_t* ptr = (uint32_t*)physicalAddress;
	*ptr = val;
}

// https://github.com/riscv/riscv-pk/blob/66701f82f88d08d3700d8b0bc5d5306abfd0044f/machine/encoding.h#L191
#define halReadCSR(reg) ({ unsigned long __tmp; \
	asm volatile ("csrr %0, " #reg : "=r"(__tmp)); \
	__tmp; })

#define halWriteCSR(reg, val) ({ \
	asm volatile ("csrw " #reg ", %0" :: "rK"(val)); })

#define halSwapCSR(reg, val) ({ unsigned long __tmp; \
	asm volatile ("csrrw %0, " #reg ", %1" : "=r"(__tmp) : "rK"(val)); \
	__tmp; })

#define halSetCSR(reg, bit) ({ unsigned long __tmp; \
	asm volatile ("csrrs %0, " #reg ", %1" : "=r"(__tmp) : "rK"(bit)); \
	__tmp; })

#define halClearCSR(reg, bit) ({ unsigned long __tmp; \
	asm volatile ("csrrc %0, " #reg ", %1" : "=r"(__tmp) : "rK"(bit)); \
	__tmp; })

#define halReadRegister(reg) ({ unsigned long __tmp; \
	asm volatile ("mv %0, " #reg : "=r"(__tmp)); \
	__tmp; })

#define halGetPC() ({ unsigned long __tmp; \
	asm volatile ("auipc %0, 0" : "=r"(__tmp)); \
	__tmp; })
#endif
