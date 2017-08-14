#define STACK_SIZE ((1 << 12) - 128)

    .text
    .globl _start
_start:
    j reset

trap_vector:
    j trap

reset:
    # initialize trap vector and machine mode CSRs
    la t0, trap;
    csrw mtvec, t0;
    csrwi mstatus, 0; # set MPP to U-mode. When mret is executed the machine will be put in U-mode.
    csrwi mideleg, 0;
    csrwi medeleg, 0;
    csrwi mie, 0;

    # initialize global pointer
    la gp, _gp;

    # initialize stack pointer
    la sp, stack_top;

    # store machine mode stack ptr to mscratch
    csrw mscratch, sp;

    # continue initialization in C
    j _init

trap:
    li t1, 0x00001800;  # t1 = MPP bit mask
    csrr t0, mstatus;   # t0 = mstatus
    and t0, t0, t1;     # t0 = mstatus & MPP_BIT_MASK
    bnez t0, save_regs; # if MPP field is not 0 (== U-mode) skip swapping stack spaces.

    # swap user mode stack ptr with mscratch
    csrrw sp, mscratch, sp

save_regs:
    # allocate stack memory for 32 registers
    addi sp, sp, -128;

    # copy registers to stack
#   sw x0, 0(sp);
    sw x1, 4(sp);
    sw x2, 8(sp);
    sw x3, 12(sp);
    sw x4, 16(sp);
    sw x5, 20(sp);
    sw x6, 24(sp);
    sw x7, 28(sp);
    sw x8, 32(sp);
    sw x9, 36(sp);
    sw x10, 40(sp);
    sw x11, 44(sp);
    sw x12, 48(sp);
    sw x13, 52(sp);
    sw x14, 56(sp);
    sw x15, 60(sp);
    sw x16, 64(sp);
    sw x17, 68(sp);
    sw x18, 72(sp);
    sw x19, 76(sp);
    sw x20, 80(sp);
    sw x21, 84(sp);
    sw x22, 88(sp);
    sw x23, 92(sp);
    sw x24, 96(sp);
    sw x25, 100(sp);
    sw x26, 104(sp);
    sw x27, 108(sp);
    sw x28, 112(sp);
    sw x29, 116(sp);
    sw x30, 120(sp);
    sw x31, 124(sp);
    
    # call trapHandler(cause, epc, regs)
    csrr a0, mcause;
    csrr a1, mepc;
    mv a2, sp;
    jal trapHandler;
    csrw mepc, a0; # trapHandler retval is the new PC

    # copy back registers from stack
#   lw x0, 0(sp);
    lw x1, 4(sp);
    lw x2, 8(sp);
    lw x3, 12(sp);
    lw x4, 16(sp);
    lw x5, 20(sp);
    lw x6, 24(sp);
    lw x7, 28(sp);
    lw x8, 32(sp);
    lw x9, 36(sp);
    lw x10, 40(sp);
    lw x11, 44(sp);
    lw x12, 48(sp);
    lw x13, 52(sp);
    lw x14, 56(sp);
    lw x15, 60(sp);
    lw x16, 64(sp);
    lw x17, 68(sp);
    lw x18, 72(sp);
    lw x19, 76(sp);
    lw x20, 80(sp);
    lw x21, 84(sp);
    lw x22, 88(sp);
    lw x23, 92(sp);
    lw x24, 96(sp);
    lw x25, 100(sp);
    lw x26, 104(sp);
    lw x27, 108(sp);
    lw x28, 112(sp);
    lw x29, 116(sp);
    lw x30, 120(sp);
    lw x31, 124(sp);

    # free allocated stack memory
    addi sp, sp, 128

    csrr t0, mstatus;
    and t0, t0, t1; # MPP field
    bnez t0, end; # if MPP field is not 0 (== User mode) skip swapping stack spaces.

    # swap machine mode stack ptr with mscratch
    csrrw sp, mscratch, sp

end:
    # return to user mode
    mret

    .bss
    .align 4
stack_bottom:
    .skip STACK_SIZE;
stack_top:
