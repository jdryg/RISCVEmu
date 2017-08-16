OUTPUT_ARCH("riscv")

ENTRY(_start)

MEMORY
{
    ROM : ORIGIN = 0x00000200, LENGTH = 65024
    RAM : ORIGIN = 0x00010000, LENGTH = 65536
}
REGION_ALIAS("REGION_TEXT", ROM);
REGION_ALIAS("REGION_RODATA", ROM);
REGION_ALIAS("REGION_DATA", RAM);
REGION_ALIAS("REGION_BSS", RAM);
REGION_ALIAS("REGION_STACK", RAM);

stack_size = 4096;

SECTIONS
{
    . = 0x200;
    .text : {
        *(.text*)
    } > REGION_TEXT

    .rodata : {
        *(.rodata*)
        rodata_end = .;
    } > REGION_RODATA

    .data : AT (rodata_end) {
        data_start = .;
        *(.data*)
    } > REGION_DATA
    data_size = SIZEOF(.data);
    data_load_start = LOADADDR(.data);

    .bss : {
        *(.bss*)
    } > REGION_BSS

    . = ALIGN(16);
    .stack : {
        __stack_start = .;
        . = . + stack_size;
        __stack_end = .;
    } > REGION_STACK
}
