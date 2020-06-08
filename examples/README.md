# TMS9918A Example Programs

Here I provide assembly and C libraries for use with my TMS9918A video card. They have been tested using my TMS9918A card with Steve Cousin's [SC126](https://smallcomputercentral.wordpress.com/sc126-z180-motherboard-rc2014/) Z180 motherboard, with Spencer Owen's [RC2014 Zed](https://www.tindie.com/products/semachthemonkey/rc2014-zed-homebrew-z80-computer-kit/) kit, and with my own [z80ctrl](https://github.com/jblang/z80ctrl) board. The demos will automatically detect the TMS9918A on common ports (ColecoVision on 0xBE, MSX on 0x98, Sord M5 on 0x10, or Tatung Einstein on 0x8).  The demos also auto-detect a Z180 processor and some demos use the enhanced features the Z180 provides.

I have tried to come up with fun ways to demonstrate the various aspects of programming the TMS9918A video chip in the various examples.

## Libraries

### Assembly

- `tms.asm`: Reusable TMS9918A library.
- `z180.asm`: Reusable Z180 library.
- `utility.asm`: Resuable BDOS and utility library.
- `tmsfont.asm`: 6x8 bitmap font for use in text mode.

### C

- `tmsc.asm`: zz8dk wrapper for assembly library.
- `tms.h`: C header for z88dk library wrapper.
- `font.h`: same 6x8 bitmap font in a C header.

## Examples

### Assembly

- `ascii.asm`: ASCII character set. Demonstrates text mode.
- `mandel.asm`: Mandelbrot renderer. Demonstrates pseudo-bitmap graphics (Graphics II Mode).
- `nyan.asm`: Nyan Cat. Demonstrates multi-color mode. Change the `incbin` directives to `binary` for z88dk's assembler.
- `PT3.asm`: PTx music player. Used to play the Nyan Cat theme on YM2149.
- `plasma.asm`: Plasma effect. Demonstrates tiled graphics (Graphics I Mode).
- `sprite.asm`: Bouncing globe. Demonstrates sprites.

I have tried to stick to a common subset of assembler features that will work with any of the following cross-assemblers:

- [Sjasm](http://www.xl2s.tk/): Windows binaries available for download.  Compiles on Linux using sources on [Github](https://github.com/Konamiman/Sjasm).
- [SjasmPlus](https://sourceforge.net/projects/sjasmplus/):  Windows binaries available for download.  Compiles on Linux using sources on [Github](https://github.com/sjasmplus/sjasmplus).
- [z80asm](https://www.nongnu.org/z80asm/): Binaries available in the Debian repository. Mac binaries on [Homebrew](https://brew.sh/). Compiles on Windows.
- [z88dk's z80asm](https://github.com/z88dk/z88dk) (not to be confused with z80asm above). Windows and Mac binaries available for download. Compiles on Linux.
- [pasmo](http://pasmo.speccy.org/): Windows and Mac binaries available for download. Binaries available in the Debain repository.

My preferred assembler is sjasm. Although I try to maintain compatibility with all of the above, I may not always test every change against the others.  If you have trouble assembling with any of the above, please try sjasm, and file a bug to let me know about the problem.

### C

- `hello.c`: Text mode demonstration for C wrapper.
- `fern.c`: Barnsley Fern. Demonstrates bitmap pixel-addressable mode via C wrapper.
- `hopalong.c`: Hopalong Attractor. Demonstrates pixel-addressable mode via C wrapper.

The C examples and libraries are compatible with [z88dk](https://github.com/z88dk/z88dk). Binaries available for download, and it compiles on Linux. With some effort, the code may be adapted to other Z80 C compilers, but I have not tried.

### MSX-BASIC

- `fern.bas`: Barnsley Fern in MSX-BASIC. 
- `hopalong.bas`: Hopalong Attractor in MSX-BASIC.

The BASIC examples require the graphic primitives of [MSX-BASIC](https://en.wikipedia.org/wiki/MSX_BASIC).  See [my instructions](https://hackaday.io/project/158338-z80ctrl/log/157750-msx-basic-on-rc2014) for running MSX-BASIC on [z80ctrl](https://hackaday.io/project/158338-z80ctrl) and TMS9918A video card.

## Credits

- `nyan.asm` uses [PtxTools](https://bulba.untergrund.net/progr_e.htm) by Sergey Bulba. Nyan Cat animations from Passan Kiskat by [Dromedaar Vision](http://www.dromedaar.com/). Nyan Cat theme by [Karbofos](https://zxart.ee/eng/authors/k/karbofos/tognyanftro/qid:136394/).
- `tmsfont.asm` and `font.h` come from [Raster Fonts](https://github.com/idispatch/raster-fonts) by Oleg Kosenov.
- `mandel.asm` uses fixed point Mandelbrot routine originally from [Rosetta Code](https://rosettacode.org/wiki/Mandelbrot_set#Z80_Assembly).  It has been enhanced with table-based multiplication from [CPC Wiki](http://www.cpcwiki.eu/index.php/Programming:Integer_Multiplication#Fast_8bit_.2A_8bit_Unsigned_with_only_512_bytes_of_tables) and Z180 hardware multiplication routines by [Phillip Stevens](https://feilipu.me/)
- `plasma.asm` is converted from a [6809 program](https://github.com/74hc595/Ultim809/blob/master/code/user/plasma/plasma.asm) by Matt Sarnoff.
- `sprite.asm` uses globe bitmaps from the [TI VDP Programmer's Guide](http://map.grauw.nl/resources/video/ti-vdp-programmers-guide.pdf).
- `fern.c` and `fern.bas` are implementations of the [Barnsley Fern](https://en.wikipedia.org/wiki/Barnsley_fern) IFS fractal first described by Michael Barnsley.
- `hopalong.c` and `hopalong.bas` are implementations of the [Hopalong Attractor](https://brainwagon.org/2011/03/24/hopalong-from-dewdneys-armchair-universe/) discovered by Barry Martin of Aston University and named by A.K. Dewdney in his Computer Recreations column in the September 1986 issue of *Scientific American*.
- The remaining code was written by me, J.B. Langston.  Specifically, the `tms.asm`, `tmsc.asm`, `z180.asm`, `utility.asm` and `tms.h` library files are my own work.