## Extemely simple BIOS/Kernel for the emulator

I don't know what's the correct name for this piece of code. It's the code that should run before anything else to setup the system. It runs in M-mode. Since the simulator supports only M and U modes, I guess either name should fit :)

*NOTE*: The code does the absolute minimum required for the emulator to function correctly. I.e. until interrupts are implemented in the emulator, this code won't touch any related registers.

Address space:
```
0x00000000 - 0x00100000 BIOS ROM/Stack (1)
0x00100000 - 0x7FFFFFFF RAM (2)
0x80000000 - 0xFFFFFFFF Devices (3)
```

Notes: 
1. The BIOS is mapped into the lowest 1MB of the address space. The generated binary has an entry point of 0x000000200. The first N pages are used for the binary's .text section (the emulator generates a ROM device in this range) and the next M pages are used for the BIOS' stack/heap (RAM device). The value of N is determined by the size of the generated .text section and the value of M by the STACK_SIZE constant at the top of entry.S.
2. RAM size is configurable from inside the emulator but the starting address should be fixed in order to be able to perform a memtest on boot (not implemented yet).
3. The region above 0x80000000 is reserved for external devices. Currently only a UART for the console has been implemented.

The code is based on ideas I got from other RISC-V kernels, such as the [RISC-V Proxy Kernel](https://github.com/riscv/riscv-pk/tree/master/pk) and the [4th RISC-V Workshop Tutorials demo](https://github.com/riscv/riscv-4th-workshop-tutorials/tree/master/microsemi_tutorial/software/demo_simple).

Finally, at this point, there's no way to load a user mode program, so everything you see runs in M-mode.
