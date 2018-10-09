# rc9918

This is a TMS9918A-based video card for the RC2014. It allows the RC2014 to produce NTSC composite graphics using a classic chip of the 1980s. The TMS9918A was used in the TI-99/4A, MSX, ColecoVision, original Sega SG-1000. Enhanced derivatives were used in later MSX computers, the Sega Master System, and the Sega Genesis. The chip's designer claims it also influenced the architecture of the PPU in the Nintendo Entertainment System. 

This board is based on a [circuit](https://retrobrewcomputers.org/n8vem-pbwiki-archive/0/35845334/48860720/33053543/SRAM%20Replacement%20for%20TMS99x8%20VRAM.pdf) described by Tom LeMense for interfacing the TMS9918A with SRAM.  I started with his schematics, added port address decoding and laid out the circuit on an RC2014 module.

This board can be configured to use the same ports as the MSX, so it's possible to run some MSX software on it unmodified. I have successfully gotten the Bold demo to run. The graphics from other programs should work as well, but other parts of the MSX, such as I/O may need additional hardware to work.

The board has been built and tested using the gerber files generated from this project. The gerber files are available for direct download below, and the project has also been shared on OSH Park.

[Ready-to-Assemble](https://www.tindie.com/products/mfkamprath/tms9918a-video-module-for-rc2014/) kits are available on Tindie.  These are sold by Michael Kamprath with my permission.  However, I offer no warranty or guarantee of support.

## Bill of Materials 

| Component | Description |
|---|---|
| PCB | rc9918 PCB ([OSH Park](https://oshpark.com/projects/KfwMvnwH) - [Gerbers](https://cdn.hackaday.io/files/1590576805094688/rc9918_rev3.zip)) |
| U1 | 74HCT32 Quad OR gate |
| U2 | 74HCT138 |
| U3 | TMS9918A chip. Available on ebay. The TMS9918 without the A is missing a graphics mode. |
| U4 | 74HCT04 Hex Inverter |
| U5, U6, U7 | 74HCT574 Octal Flip-Flops |
| U8 | AS6C62256-55PCN, HM62256BLP-7, or compatible 32KB SRAM.  I have put two footprints so either a wide or narrow DIP-28 will work as long as the pin-out is the same. I have also tested the circuit with a UM61M256K-15 32K SRAM salvaged off of an old Pentium motherboard where it was used for cache. |
| R1 | 75 ohm resistor |
| R2 | 0 ohm resistors. Wire jumper can be used in place of 0 ohm resistor. |
| R3 | 470 ohm resistor |
| L1 | FBA04HA600VB-00 ferrite bead. I got a message from Mouser that it is end of life now.  Other ferrite beads should work fine. The closer in size to the footprint of a 1/4W resistor, the better it will fit. |
| Y1 | LFXTAL029962REEL 10.73866MHz crystal |
| C1, C2 | 16pf ceramic or MLCC capacitor |
| C3-C11 | 0.1uf caps (bypass caps for each chip and one for the video output circuit) |
| Q1 | 2N4401 NPN transistor. Any NPN with similar characteristics should work. |
| J1 & J5 | 2x40 pin right angle header, with pins from upper row removed to fit J5 |
| J2 | KLPX-0848A-2-Y RCA connector. Other models may not fit.  |
| J4 | 2x8 pin straight header and 1 jumper block |
| J6 | 2x3 pin straight header and 1 jumper block |
| J7 | 1x4 pin straight header and 1 jumper block |
| JP1 | 1x3 pin straight header and 1 jumper block |
| JP2 | 1x3 pin straight header and 1 jumper block |
| JP4 | 1x3 pin straight header and 1 jumper block |

Aside from the board and the TMS9918A itself, all parts are available from Mouser and probably other suppliers as well.

## Jumper Descriptions
### Default Jumper Configurations
The default jumper configurations for the RC2014 are below. 

| Jumper | Jumper Block Configuration | Results |
|---|---|---|
| `J4` | 5th from left | Port 80-9F |
| `J6` | Right | Upper half of port range selected by `J4` |
| `JP1` | Upper | Ports 98 & 99 |
| `JP2` | Upper | Ports 98 & 99 | 
| `JP4` | Upper Pair | TMS9918A interrupts sent to INT |
| `J7` | _None_ | This is the clock signal header |

See jumper description at [the Hackaday.io article](https://hackaday.io/project/159057-rc9918/log/149923-new-board-revision) for more detail on each jumper.

### Port Address Jumpers

* J4 configures address bits 7-5 which lets you select a block of 32 addresses: 00-1F (left) ... E0-FF (right). For ColecoVision, you would set this to A0-BF (6th position). For MSX, you'd set it to 80-9F (5th position).  For Sord M5, you'd set it to 00-1F (1st position).
* J6 configures address bit 4. There are 3 options: ignore (left), 0 (middle), or 1 (right). This lets you use the entire 32 address range, the lower half, or the upper half, respectively. For ColecoVision, you would set this to ignore (left). For MSX and Sord, you would set it to 1 (right).
* JP1 configures address bit 2 and 1. In the upper position, they must both be 0. In the lower position, they are ignored.  For MSX, you would set this to the upper position. For ColecoVision and Sord, you would set it to the lower position.
* JP2 configures address bit 3. In the upper position, it must be 1. In the lower position, it is ignored.  For MSX, you would set this to the upper position. For ColecoVision or Sord, you would set it to the lower position.

### Interrupt Configuration Jumper
The jumper `JP4` is used to determine where the TMS9918A interrupt signal to either INT (upper position) or NMI (lower position) on the RC2014 bus. ColecoVision connects the video interrupt to NMI, so this change was necessary for compatibility.  MSX uses INT, and most other systems do as well.

**Warning**: do not put the jumper in the INT position if you have other cards that make use of
the /INT line, such as the SIO card that comes with the RC2014. The TMS9918A does not have an
open collector interrupt output so it will fight with other cards for control of the interrupt.
This will prevent proper operation and may damage one or both cards.

### Clock Header 
The `J7` header has pins for (left to right) CPUCLK, GROMCLK, EXTVDP, and GND. This should allow the CPUCLK and GROMCLK signals to be used via jumper cables with other boards the need them, for example on the Sord M5.  It should also be possible to daisy-chain multiple TMS9918A chips using the EXTVDP signal, or to genlock an external video source. The GND pin can be used with an external video source if needed.  

## Resources

- [TMS9918 Manual](http://map.grauw.nl/resources/video/texasinstruments_tms9918.pdf)
- [TI VDP Programmer's Guide](http://map.grauw.nl/resources/video/ti-vdp-programmers-guide.pdf)
- [More TMS9918 Documents](https://github.com/cbmeeks/TMS9918)
- [Discussion Thread](https://groups.google.com/d/topic/rc2014-z80/0m0kbzIJ3tw/discussion)
- [Hackaday Page](https://hackaday.io/project/159057-rc9918)
- [Example Assembly Programs](examples)
- [z80ctrl](https://github.com/jblang/z80ctrl): my other RC2014 project with support for this board.

## License

Copyright 2018 J.B. Langston

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.