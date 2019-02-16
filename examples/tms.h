/*
 * z88dk wrapper for TMS9918A graphics subroutines
 * Copyright 2018 J.B. Langston
 *
 * Permission is hereby granted, free of charge, to any person obtaining a 
 * copy of this software and associated documentation files (the "Software"), 
 * to deal in the Software without restriction, including without limitation 
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 * and/or sell copies of the Software, and to permit persons to whom the 
 * Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
 * DEALINGS IN THE SOFTWARE.
 */

#ifndef TMS_H
#define TMS_H
#include <stdint.h>

extern void tmsintenable();
extern void tmsintdisable();

#define TMS_BITMAPCOLORTBL 0x2000
#define TMS_BITMAPCOLORLEN 0x1800

extern void tmswrite(uint16_t source, uint16_t dest, uint16_t len);
extern void tmsfill(uint8_t value, uint16_t dest, uint16_t len);

enum tmscolors {
    TMS_TRANSPARENT,
    TMS_BLACK,
    TMS_MEDGREEN,
    TMS_LIGHTGREEN,
    TMS_DARKBLUE,
    TMS_LIGHTBLUE,
    TMS_DARKRED,
    TMS_CYAN,
    TMS_MEDRED,
    TMS_LIGHTRED,
    TMS_DARKYELLOW,
    TMS_LIGHTYELLOW,
    TMS_DARKGREEN,
    TMS_MAGENTA,
    TMS_GRAY,
    TMS_WHITE
};
#define TMS_FGBG(fg, bg) ((fg) << 4 | (bg))

extern void tmsbackground(uint8_t color);
extern void tmstextcolor(uint8_t color);

extern void tmstextpos(uint8_t x, uint8_t y);
extern void tmsstrout(char *str);
extern void tmschrout(char chr);
extern void tmschrrpt(char chr, uint8_t count);

#define TMS_CLEARPIXEL 0xA02F
#define TMS_SETPIXEL 0x00B0

extern void tmspixelop(uint16_t op);
extern void tmsplotpixel(uint8_t x, uint8_t y);
extern void tmspixelcolor(uint8_t x, uint8_t y, uint8_t color);

extern void tmsmulticolor();
extern void tmsbitmap();
extern void tmstextmode(uint16_t font);
extern void tmstile();


#endif