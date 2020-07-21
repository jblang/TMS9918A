; z88dk wrapper for TMS9918A graphics subroutines
; Copyright 2018 J.B. Langston
;
; Permission is hereby granted, free of charge, to any person obtaining a 
; copy of this software and associated documentation files (the "Software"), 
; to deal in the Software without restriction, including without limitation 
; the rights to use, copy, modify, merge, publish, distribute, sublicense, 
; and/or sell copies of the Software, and to permit persons to whom the 
; Software is furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
; DEALINGS IN THE SOFTWARE.

SECTION code

PUBLIC _TmsIntEnable
PUBLIC _TmsIntDisable

PUBLIC _TmsWrite
PUBLIC _TmsFill

PUBLIC _TmsBackground
PUBLIC _TmsTextColor
PUBLIC _TmsTextPos
PUBLIC _TmsStrOut
PUBLIC _TmsRepeat
PUBLIC _TmsChrOut

PUBLIC _TmsPixelOp
PUBLIC _TmsPlotPixel
PUBLIC _TmsPixelColor

PUBLIC _TmsMulticolor
PUBLIC _TmsBitmap
PUBLIC _TmsTextMode
PUBLIC _TmsTile
PUBLIC _TmsProbe
PUBLIC _TmsSetWait

include "tms.asm"

_TmsIntEnable:
	jp	TmsIntEnable

_TmsIntDisable:
	jp	TmsIntDisable

_TmsWrite:
        ld 	hl, 2
        add	hl, sp
        ld 	c, (hl)		; len
        inc	hl
        ld 	b, (hl)
        inc	hl
        ld 	e, (hl)		; dest
        inc	hl
        ld 	d, (hl)
        inc	hl
        ld 	a, (hl)		; source
        inc	hl
        ld 	h, (hl)
	ld	l, a
	jp	TmsWrite

_TmsFill:
        ld 	hl, 2
        add	hl, sp
        ld 	c, (hl)		; len
        inc	hl
        ld 	b, (hl)
        inc	hl
        ld 	e, (hl)		; dest
        inc	hl
        ld 	d, (hl)
        inc	hl
        ld 	a, (hl)		; value
	ld	l, a
	jp	TmsFill

_TmsBackground:
        ld 	hl, 2
        add	hl, sp
        ld 	a, (hl)		; color
	jp	TmsBackground

_TmsTextColor:
        ld 	hl, 2
        add	hl, sp
        ld 	a, (hl)		; color
	jp	TmsTextColor

_TmsTextPos:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; x
	inc	hl
	ld	e, (hl)		; y
	jp	TmsTextPos

_TmsStrOut:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; str
	inc	hl
	ld	h, (hl)
	ld	l, a
	jp	TmsStrOut

_TmsRepeat:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; chr
	inc 	hl
	inc 	hl
	ld	b, (hl)		; count
	jp	TmsRepeat

_TmsChrOut:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; chr
	jp	TmsChrOut

_TmsPixelOp:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; operation
	inc	hl
	ld	h, (hl)
	ld	l, a
	jp	TmsPixelOp

_TmsPlotPixel:
	ld	hl, 2
	add	hl, sp
	ld	b, (hl)			; y
	inc 	hl
	inc 	hl
	ld	c, (hl)			; x
	jp 	TmsPlotPixel
	
_TmsPixelColor:
	ld	hl, 2
	add	hl, sp
	ld	b, (hl)			; y
	inc 	hl
	inc 	hl
	ld	c, (hl)			; x
	inc	hl
	inc	hl
	ld	a, (hl)			; color
	jp	TmsPixelColor

_TmsMulticolor:
	jp	TmsMulticolor

_TmsBitmap:
	jp	TmsBitmap

_TmsTextMode:
        ld 	hl, 2
        add	hl, sp
        ld 	e, (hl)			; font
        inc	hl
        ld 	d, (hl)
        ex 	de, hl
	jp	TmsTextMode

_TmsTile:
	jp 	TmsTile

_TmsProbe:
	call	TmsProbe
	ld	hl, 1
	ret	nz
	ld	hl, 0
	ret

_TmsSetWait:
	ld 	hl, 2
	add	hl, sp
	ld 	e, (hl)			; wait
	jp	TmsSetWait
