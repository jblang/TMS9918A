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

PUBLIC _tmsintenable
PUBLIC _tmsintdisable

PUBLIC _tmswrite
PUBLIC _tmsfill

PUBLIC _tmsbackground
PUBLIC _tmstextcolor
PUBLIC _tmstextpos
PUBLIC _tmsstrout
PUBLIC _tmschrrpt
PUBLIC _tmschrout

PUBLIC _tmspixelop
PUBLIC _tmsplotpixel
PUBLIC _tmspixelcolor

PUBLIC _tmsmulticolor
PUBLIC _tmsbitmap
PUBLIC _tmstextmode
PUBLIC _tmstile

include "tms.asm"

_tmsintenable:
	jp	tmsintenable

_tmsintdisable:
	jp	tmsintdisable

_tmswrite:
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
	jp	tmswrite

_tmsfill:
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
	jp	tmsfill

_tmsbackground:
        ld 	hl, 2
        add	hl, sp
        ld 	a, (hl)		; color
	jp	tmsbackground

_tmstextcolor:
        ld 	hl, 2
        add	hl, sp
        ld 	a, (hl)		; color
	jp	tmstextcolor

_tmstextpos:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; x
	inc	hl
	ld	e, (hl)		; y
	jp	tmstextpos

_tmsstrout:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; str
	inc	hl
	ld	h, (hl)
	ld	l, a
	jp	tmsstrout

_tmschrrpt:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; chr
	inc 	hl
	inc 	hl
	ld	b, (hl)		; count
	jp	tmschrrpt

_tmschrout:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; chr
	jp	tmschrout

_tmspixelop:
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)		; operation
	inc	hl
	ld	h, (hl)
	ld	l, a
	jp	tmspixelop

_tmsplotpixel:
	ld	hl, 2
	add	hl, sp
	ld	b, (hl)			; y
	inc 	hl
	inc 	hl
	ld	c, (hl)			; x
	jp 	tmsplotpixel
	
_tmspixelcolor:
	ld	hl, 2
	add	hl, sp
	ld	b, (hl)			; y
	inc 	hl
	inc 	hl
	ld	c, (hl)			; x
	inc	hl
	inc	hl
	ld	a, (hl)			; color
	jp	tmspixelcolor

_tmsmulticolor:
	jp	tmsmulticolor

_tmsbitmap:
	jp	tmsbitmap

_tmstextmode:
        ld 	hl, 2
        add	hl, sp
        ld 	e, (hl)			; font
        inc	hl
        ld 	d, (hl)
        ex 	de, hl
	jp	tmstextmode

_tmstile:
	jp 	tmstile