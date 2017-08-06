OUTPUT_ARCH( "riscv" )

SECTIONS
{
    . = 0x00000200;
    .text : 
    {
        entry.o(.text)
        *(.text)
    }

    /* Put initialized data into separate page */
    . = ALIGN(0x1000);

    /* data segment */
    .data : { *(.data) }

    .sdata : {
        _gp = . + 0x800;
        *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2)
        *(.srodata*)
        *(.sdata .sdata.* .gnu.linkonce.s.*)
    }

    . = ALIGN(4);
    
    /* bss segment */
    .sbss : {
        *(.sbss .sbss.* .gnu.linkonce.sb.*)
        *(.scommon)
    }
    .bss : { *(.bss) }

    /* End of uninitalized data segement */
    _end = .;
    _heap_end = .;
}
