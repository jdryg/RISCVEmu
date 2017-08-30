# RISCVEmu
Toy RISC-V emulator

**WARNING**: If you are interested in testing your RISCV executables with an emulator, save yourself some time and use the official ones. This is a WIP and it's lacking A LOT of stuff. Also, the BIOS/Kernel isn't Linux-compatible, so it's probably not what you are looking for.

## What's this about?

Ok, you are still here. My goal for this project is to build a basic RISC-V simulator (targeting RV32I only) which will be expanded to include a pipeline, caches, OoO execution, etc. If I manage to make it that far (which I doubt) the next step will be to translate the code to a circuit in [DLS](https://makingartstudios.itch.io/dls) (my simple logic simulator).

It's a long way until then, though. Currently the code simulates (poorly) a single cycle CPU. The main focus at the moment is to build a minimal BIOS/Kernel for loading test apps and testing the CPU.

![Screenshot](https://cdn.rawgit.com/jdryg/RISCVEmu/master/img/screenshot_2017_08_30.png.png)

## 3rd party libraries

This project uses the following 3rd party libraries

1. [dear imgui](https://github.com/ocornut/imgui)
2. [bx](https://github.com/bkaradzic/bx)
3. [GLFW](http://www.glfw.org/)
4. [nativefiledialog](https://github.com/mlabbe/nativefiledialog)
5. [mmx JSON parser](https://github.com/vurtun/mmx)

## License

```
MIT License

Copyright (c) 2017 Jim Drygiannakis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```