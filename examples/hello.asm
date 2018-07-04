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

; @file hello.asm: hello world example program

        org 100h

ramtop: equ $ffff

        jp start

tmsfont:
        include "tmsfont.asm"
        include "tms.asm"

start:
        ld      sp, ramtop
        ld      hl, tmsfont
        call    tmstextmode
        ld      de, $0000
        ld      hl, msg
        call    tmsstrout
        halt

msg:    
        db "hello, world", 0
