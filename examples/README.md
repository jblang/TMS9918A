# TMS9918A Example Programs

In these programs, I have tried to come up with fun ways to demonstrate the various aspects of programming the TMS9918A video chip.  `tms.asm` is a code library used by all of these examples that you can use in your programs too.

## Assembling

I have tried to stick to a common subset of assembler features that will work with any of the following cross-assemblers:

- [Sjasm](http://www.xl2s.tk/): Windows binaries available for download.  Compiles on Linux using sources on [Github](https://github.com/Konamiman/Sjasm).
- [SjasmPlus](https://sourceforge.net/projects/sjasmplus/):  Windows binaries available for download.  Compiles on Linux using sources on [Github](https://github.com/sjasmplus/sjasmplus).
- [z80asm](https://www.nongnu.org/z80asm/): Binaries available in the Debian repository. Mac binaries on [Homebrew](https://brew.sh/). Compiles on Windows.
- [z88dk](https://github.com/z88dk/z88dk)'s z80asm (not to be confused with above). Windows and Mac binaries available for download. Compiles on Linux.
- [pasmo](http://pasmo.speccy.org/): Windows and Mac binaries available for download. Binaries available in the Debain repository.

My preferred assembler is sjasm. I try to maintain compatibility with all of the above, but may not always test every change against the others.  If you have trouble assembling with any of the above, please try sjasm, and file a bug to let me know about the problem.

## About the Programs

- `tms.asm`: Reusable TMS9918A library; used by all the other programs.
- `tmsfont.asm`: 6x8 bitmap font for use in text mode.
- `ascii.asm`: ASCII character set. Demonstrates text mode.
- `mandel.asm`: Mandelbrot renderer. Demonstrates pseudo-bitmap graphics (Graphics II Mode).
- `nyan.asm`: Nyan Cat. Demonstrates multi-color mode. Change the `incbin` directives to `binary` for z88dk's assembler.
- `arkos.asm`: Arkos music player. Used to play the Nyan Cat theme on YM2149.
- `plasma.asm`: Plasma effect. Demonstrates tiled graphics (Graphics II Mode).
- `sprite.asm`: Bouncing globe. Demonstrates sprites.

## Credits

- `nyan.asm` uses [Arkos Player 1.0](http://www.julien-nevo.com/arkos/arkostracker1/) by Targhan. Nyan Cat images and song taken from [Nyan Cat for MSX](https://www.msx.org/news/en/nyan-cat-msx) by Dromedaar Vision.
- `tmsfont.asm` comes from [Raster Fonts](https://github.com/idispatch/raster-fonts) by Oleg Kosenov.
- `mandel.asm` uses fixed point Mandelbrot routine originally from [Rosetta Code](https://rosettacode.org/wiki/Mandelbrot_set#Z80_Assembly)
- `plasma.asm` is converted from a [6809 program](https://github.com/74hc595/Ultim809/blob/master/code/user/plasma/plasma.asm) by Matt Sarnoff.
- `sprite.asm` uses globe bitmaps from the [TI VDP Programmer's Guide](http://map.grauw.nl/resources/video/ti-vdp-programmers-guide.pdf).
- The rest of the code, especially the `tms.asm` library, was written by me, J.B. Langston.