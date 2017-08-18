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
rom_size = 64K;
ram_size = 128K;
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
        __rodata_end = .;
    } > ROM

    /* RAM */
    .data : AT(__rodata_end) {
        __data_load_start = LOADADDR(.data);
        __data_start = .;
        *(.data*)
    } > RAM
    __data_size = SIZEOF(.data);

    .bss : {
        __bss_start = .;
        *(.bss*)
        *(.sbss*)
        *(COMMON)
    } > RAM
    __bss_size = SIZEOF(.bss);

    .ram : {
        __heap_start = .;
        . += ram_size - SIZEOF(.data) - SIZEOF(.bss);
        __stack_top = .;
    } > RAM
}
