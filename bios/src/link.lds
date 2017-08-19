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
        PROVIDE_HIDDEN(___rodata_end = .);
    } > ROM

    /* RAM */
    .data : AT(___rodata_end) {
        __data_load_start = LOADADDR(.data);
        __data_start = .;
        *(.data*)
        *(.sdata*)
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
        PROVIDE_HIDDEN(___heap_alignment = ALIGN(16) - .);
        . = ALIGN(16);

        __heap_start = .;
        . += ram_size - (SIZEOF(.data) + SIZEOF(.bss) + ___heap_alignment);
        __stack_top = .;
    } > RAM
}
