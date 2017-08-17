/*
This script is supposed to build an ELF with 2 headers/memory regions.
1. A RX region starting at address 0, containing .text, .rodata 
   and the initial values for the .data section.
2. An empty 128KB RW region starting at address 0x10000 (for .data, .bss and .ram)

Observed output: 
2 ELF headers.
- The first contains .text and .rodata
- The second contains .data, .bss and .ram

data_load_start has the correct value but the actual data aren't included
in the 1st (ROM) region/header.

readelf output:

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x000000 0x00000000 0x00000000 0x01c4c 0x01c4c R E 0x1000
  LOAD           0x002000 0x00010000 0x00001c4c 0x00040 0x20000 RW  0x1000

What I expected is: 
- The PhysAddr of the 2nd header should be 0 and FileSiz should be 0.
- The FileSiz and MemSiz of the 1st header should be 0x01c4c + 0x00040 = 0x01c8c
*/

OUTPUT_ARCH("riscv")

ENTRY(_start)

entry_point = 0x200;
rom_size = 65536;  /* 64k ROM */
ram_size = 131072; /* 128k RAM */
ram_origin = rom_size; /* start immediatelly after the ROM */

MEMORY
{
    ROM (rx): ORIGIN = entry_point, LENGTH = rom_size - entry_point
    RAM (rw): ORIGIN = ram_origin, LENGTH = ram_size
}

SECTIONS
{
    /* ROM */
    . = ORIGIN(ROM);
    .text : {
        *(.text.init)
        *(.text*)
    } > ROM

    .rodata : {
        *(.rodata*)
        rodata_end = .;
    } > ROM

    /* RAM */
    .data : AT(rodata_end) {
        data_load_start = LOADADDR(.data);
        data_start = .;
        *(.data*)
        data_end = .;
    } > RAM

    .bss : {
        *(.bss*)
        *(COMMON)
    } > RAM

    .ram : {
        . = ALIGN(16);
        __heap_start = .;
        /* TODO: I don't know why I need to subtract 32 but if I don't .ram section doesn't fit in RAM region :| */
        /* Probably due to alignment? */
        . += ram_size - SIZEOF(.data) - SIZEOF(.bss) - 32;
        __stack_top = .;
    } > RAM
}
