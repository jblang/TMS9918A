; z88dk wrapper for Z180 utility subroutines
; Copyright 2020 J.B. Langston
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

PUBLIC _Z180Detect
PUBLIC _Z180Read
PUBLIC _Z180Write
PUBLIC _Z180GetClock
PUBLIC _Z180ClockSlow
PUBLIC _Z180ClockNormal
PUBLIC _Z180ClockFast
PUBLIC _Z180SetIOWait
PUBLIC _Z180SetMemWait

include "z180.asm"

_Z180Detect:
    call z180detect
    ld l, a
    ret

_Z180Read:
        ld 	hl, 2
        add	hl, sp
        ld 	c, (hl)
        call z180in
        ld l, a
        ret

_Z180Write:
        ld 	hl, 2
        add	hl, sp
        ld 	c, (hl)
        inc hl
        ld a, (hl)
        jp z180out

_Z180GetClock:
    call z180getclk
    ld l,e
    ret

_Z180ClockSlow:
    jp z180clkslow
_Z180ClockNormal:
    jp z180clknorm
_Z180ClockFast:
    jp z180clkfast

_Z180SetIOWait:
        ld 	hl, 2
        add	hl, sp
        ld 	a, (hl)
        jp z180iowait

_Z180SetMemWait:
        ld 	hl, 2
        add	hl, sp
        ld 	a, (hl)
        jp z180memwait