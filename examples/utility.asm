; BDOS and misc utility routines
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

cr:	equ     0dh
lf:	equ     0ah
eos:	equ     '$'
bdos:   equ     5

; Output A in hexidecimal
hexout:
        push    af
        rra
        rra
        rra
        rra
        call    nybhex
        call    chrout
        pop     af
        call    nybhex
        jp      chrout

; convert lower nybble of A to hex (also in A)
; from http://map.grauw.nl/sources/external/z80bits.html#5.1
nybhex:
        or      0f0h
        daa
        add     a, 0a0h
        adc     a, 40h
        ret

space:
        ld      a, ' '
        jp      chrout

; output a new line
crlf:
        ld      a, cr
        call    chrout
        ld      a, lf
        ; fallthrough

; output character in A
chrout:
        ld      c, 2
        ld      e, a
        jp      bdos

; output $-terminated string pointed to by DE
strout:
        ld      c, 9
        jp      bdos

; check for keypress and clear Z flag if pressed
keypress:
        ld      c, 6
        ld      e, 0ffh
        call    bdos
        or      a
        ret