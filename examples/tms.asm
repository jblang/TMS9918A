 ; TMS9918A graphics subroutines
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

tmsram:         equ $98                 ; TMS9918A VRAM port
tmsreg:         equ $99                 ; TMS9918A register port

; configure tms with specified register table
;       HL = register table
tmsconfig:
	ld      b, 8                    ; 8 registers
.regloop:
  	ld      a, (hl)                 ; get register value from table
	out     (tmsreg), a             ; send it to the TMS
	ld      a, 8                    ; calculate current register number
	sub     b
	or      $80                     ; set high bit to indicate a register
	out     (tmsreg), a             ; send it to the TMS
	inc     hl                      ; next register
	djnz    .regloop
	ret

; register values for blanked screen with 16KB RAM enabled
tmsblankreg:
        defb $00, $80, $00, $00, $00, $00, $00, $00

; blank the screen and clear all 16KB of video memory
tmsclear:
        ld      hl, tmsblankreg         ; blank the screen
        call    tmsconfig
        ld      de, 0                   ; start a address 0000H
        call    tmswriteaddr
        ld      de, $4000               ; write 16KB
        ld      bc, tmsram              ; writing 0s to vram
.clearloop:
        out     (c), b                  ; send to vram
        dec     de                      ; continue until counter is 0
        ld      a, d
        or      e
        jr      nz, .clearloop
        ret

; waste time to let the TMS9918A catch up
tmswait:                               ; call: 17 cycles
        db      0,0,0,0,0,0             ; nops: 6 x 4 = 24 cycles
        ret                             ; ret: 10 cycles
                                        ; 51 cycles total (5.1 us @ 10 MHz)

; set the next address of vram to write
;       DE = address
tmswriteaddr:
        ld      a, e                    ; send lsb
        out     (tmsreg), a
        ld      a, d                    ; mask off msb to max of 16KB
        and     $3F
        or      $40                     ; set second highest bit to indicate write
        out     (tmsreg), a             ; send msb
        ret

; copy bytes from ram to vram
;       HL = ram source address
;       DE = vram destination address
;       BC = byte count
tmswrite:
        call    tmswriteaddr            ; set the starting address
.copyloop:
        ld      a, (hl)                 ; get the current byte from ram
        out     (tmsram), a             ; send it to vram
        call    tmswait                 ; waste time
        inc     hl                      ; next byte
        dec     bc                      ; continue until count is zero
        ld      a, b
        or      c
        jr      nz, .copyloop
        ret

; register values for multicolor mode
tmsmcreg:
	defb $00, $E8, $02, $00, $00, $36, $07, $04

; initialize tms for multicolor mode 
tmsmulticolor:
        call    tmsclear                ; blank the screen and clear vram
        ld      de, $0800               ; set name table start address
        call    tmswriteaddr
        ld      d, 6                    ; nametable has 6 different sections
        ld      e, 0                    ; first section starts at 0
.sectionloop:
        ld      c, 4                    ; each section has 4 identical lines
.lineloop:
        ld      b, 32                   ; each line is 32 bytes long
        ld      a, e                    ; load the section's starting value
.byteloop:
        out     (tmsram), a             ; output current name byte
        nop                             ; extra time to finish vram write
        inc     a                       ; increment name byte
        djnz    .byteloop               ; next byte
        dec     c                       ; decrement line counter
        jr      nz, .lineloop           ; next line
        ld      a, e                    ; next section's starting value is 32
        add     a, 32                   ; ...more than the previous section
        ld      e, a
        dec     d                       ; decrement section counter
        jr      nz, .sectionloop        ; next section
        ld      hl, tmsmcreg            ; switch to multicolor mode
        call    tmsconfig
        ret