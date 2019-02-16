# TMS9918A Example Programs

Here I provide assembly and C libraries for use with my TMS9918A video card. I have also tried to come up with fun ways to demonstrate the various aspects of programming the TMS9918A video chip in the various examples.

## Libraries

### Assembly

- `tms.asm`: Reusable TMS9918A library; used by all the examples.
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
- `arkos.asm`: Arkos music player. Used to play the Nyan Cat theme on YM2149.
- `plasma.asm`: Plasma effect. Demonstrates tiled graphics (Graphics II Mode).
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

- `nyan.asm` uses [Arkos Player 1.0](http://www.julien-nevo.com/arkos/arkostracker1/) by Targhan. Nyan Cat images and song taken from [Nyan Cat for MSX](https://www.msx.org/news/en/nyan-cat-msx) by Dromedaar Vision.
- `tmsfont.asm` and `font.h` come from [Raster Fonts](https://github.com/idispatch/raster-fonts) by Oleg Kosenov.
- `mandel.asm` uses fixed point Mandelbrot routine originally from [Rosetta Code](https://rosettacode.org/wiki/Mandelbrot_set#Z80_Assembly).
- `plasma.asm` is converted from a [6809 program](https://github.com/74hc595/Ultim809/blob/master/code/user/plasma/plasma.asm) by Matt Sarnoff.
- `sprite.asm` uses globe bitmaps from the [TI VDP Programmer's Guide](http://map.grauw.nl/resources/video/ti-vdp-programmers-guide.pdf).
- `fern.c` and `fern.bas` are implementations of the [Barnsley Fern](https://en.wikipedia.org/wiki/Barnsley_fern) IFS fractal first described by Michael Barnsley.
- `hopalong.c` and `hopalong.bas` are implementations of the [Hopalong Attractor](https://brainwagon.org/2011/03/24/hopalong-from-dewdneys-armchair-universe/) discovered by Barry Martin of Aston University and named by A.K. Dewdney in his Computer Recreations column in the September 1986 issue of *Scientific American*.
- The remaining code was written by me, J.B. Langston.  Specifically, the `tms.asm`, `tmsc.asm` and `tms.h` library files.