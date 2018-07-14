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
        ld      sp, ramtop                      ; set up stack
        ld      hl, tmsfont                     ; pointer to font
        call    tmstextmode                     ; initialize text mode
        ld      a, tmsdarkblue                  ; set blue background
        call    tmsbackground
        ld      a, 11                           ; put title at 11, 1
        ld      e, 1
        call    tmstextpos
        ld      hl, msg                         ; output title
        call    tmsstrout
        ld      a, 0                            ; start at character 0
        ld      b, 32                           ; 32 chars per line
        ld      c, 6                            ; start at line 6
        push    af                              ; save current character
nextline:
        ld      a, 4                            ; start at column 4
        ld      e, c                            ; on current line
        call    tmstextpos
        pop     af                              ; get current character
nextchar:
        out     (tmsram), a                     ; output current character
        cp      255                             ; see if we have output everything
        jp      z, done
        inc     a                               ; next character
        cp      b                               ; time for a new line?
        jp      nz, nextchar                    ; if not, output the next character
        push    af                              ; if so, save the next character
        add     a, 32                           ; 32 characters on the next line
        ld      b, a
        inc     c                               ; skip two lines
        inc     c
        jp      nextline                        ; do the next line
done:
        halt

msg:    
        db "ASCII Character Set", 0
