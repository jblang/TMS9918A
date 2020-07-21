; Z180 utility routines
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

; Z180 manual: http://www.zilog.com/manage_directlink.php?filepath=docs/z180/um0050&extn=.pdf

; Definitions from https://github.com/wwarthen/RomWBW/blob/master/Source/HBIOS/z180.inc
Z180_CNTLA0     equ     00h             ; ASCI0 CONTROL A
Z180_CNTLA1     equ     01h             ; ASCI1 CONTROL A
Z180_CNTLB0     equ     02h             ; ASCI0 CONTROL B
Z180_CNTLB1     equ     03h             ; ASCI1 CONTROL B
Z180_STAT0      equ     04h             ; ASCI0 STATUS
Z180_STAT1      equ     05h             ; ASCI1 STATUS
Z180_TDR0       equ     06h             ; ASCI0 TRANSMIT
Z180_TDR1       equ     07h             ; ASCI1 TRANSMIT
Z180_RDR0       equ     08h             ; ASCI0 RECEIVE
Z180_RDR1       equ     09h             ; ASCI1 RECEIVE
Z180_CNTR       equ     0Ah             ; CSI/O CONTROL
Z180_TRDR       equ     0Bh             ; CSI/O TRANSMIT/RECEIVE
Z180_TMDR0L     equ     0Ch             ; TIMER 0 DATA LO
Z180_TMDR0H     equ     0Dh             ; TIMER 0 DATA HI
Z180_RLDR0L     equ     0Eh             ; TIMER 0 RELOAD LO
Z180_RLDR0H     equ     0Fh             ; TIMER 0 RELOAD HI
Z180_TCR        equ     10h             ; TIMER CONTROL
Z180_ASEXT0     equ     12h             ; ASCI0 EXTENSION CONTROL (Z8S180)
Z180_ASEXT1     equ     13h             ; ASCI1 EXTENSION CONTROL (Z8S180)
Z180_TMDR1L     equ     14h             ; TIMER 1 DATA LO
Z180_TMDR1H     equ     15h             ; TIMER 1 DATA HI
Z180_RLDR1L     equ     16h             ; TIMER 1 RELOAD LO
Z180_RLDR1H     equ     17h             ; TIMER 1 RELOAD HI
Z180_FRC        equ     18h             ; FREE RUNNING COUNTER
Z180_ASTC0L     equ     1Ah             ; ASCI0 TIME CONSTANT LO (Z8S180)
Z180_ASTC0H     equ     1Bh             ; ASCI0 TIME CONSTANT HI (Z8S180)
Z180_ASTC1L     equ     1Ch             ; ASCI1 TIME CONSTANT LO (Z8S180)
Z180_ASTC1H     equ     1Dh             ; ASCI1 TIME CONSTANT HI (Z8S180)
Z180_CMR        equ     1Eh             ; CLOCK MULTIPLIER (LATEST Z8S180)
Z180_CCR        equ     1Fh             ; CPU CONTROL (Z8S180)
Z180_SAR0L      equ     20h             ; DMA0 SOURCE ADDR LO
Z180_SAR0H      equ     21h             ; DMA0 SOURCE ADDR HI
Z180_SAR0B      equ     22h             ; DMA0 SOURCE ADDR BANK
Z180_DAR0L      equ     23h             ; DMA0 DEST ADDR LO
Z180_DAR0H      equ     24h             ; DMA0 DEST ADDR HI
Z180_DAR0B      equ     25h             ; DMA0 DEST ADDR BANK
Z180_BCR0L      equ     26h             ; DMA0 BYTE COUNT LO
Z180_BCR0H      equ     27h             ; DMA0 BYTE COUNT HI
Z180_MAR1L      equ     28h             ; DMA1 MEMORY ADDR LO
Z180_MAR1H      equ     29h             ; DMA1 MEMORY ADDR HI
Z180_MAR1B      equ     2Ah             ; DMA1 MEMORY ADDR BANK
Z180_IAR1L      equ     2Bh             ; DMA1 I/O ADDR LO
Z180_IAR1H      equ     2Ch             ; DMA1 I/O ADDR HI
Z180_IAR1B      equ     2Dh             ; DMA1 I/O ADDR BANK (Z8S180)
Z180_BCR1L      equ     2Eh             ; DMA1 BYTE COUNT LO
Z180_BCR1H      equ     2Fh             ; DMA1 BYTE COUNT HI
Z180_DSTAT      equ     30h             ; DMA STATUS
Z180_DMODE      equ     31h             ; DMA MODE
Z180_DCNTL      equ     32h             ; DMA/WAIT CONTROL
Z180_IL         equ     33h             ; INTERRUPT VECTOR LOAD
Z180_ITC        equ     34h             ; INT/TRAP CONTROL
Z180_RCR        equ     36h             ; REFRESH CONTROL
Z180_CBR        equ     38h             ; MMU COMMON BASE REGISTER
Z180_BBR        equ     39h             ; MMU BANK BASE REGISTER
Z180_CBAR       equ     3Ah             ; MMU COMMON/BANK AREA REGISTER
Z180_OMCR       equ     3Eh             ; OPERATION MODE CONTROL
Z180_ICR        equ     3Fh             ; I/O CONTROL REGISTER

z180base:       defw 0
z180regs:       defs 40h, 0

; Detect Z180 and find base address
;       returns Z180 base address in A, or 0ffh if not found
;       Z is set if Z180 found, clear if not found
;       also sets z180base variable
z180detect:
        ld      a, 0                    ; check behavior of DAA
        dec     a
        daa                             ; on a Z80 this sequence results in 99H
        cp      0f9h                    ; on a Z180 it results in F9H
        ld      a, 0ffh
        jp      nz, z180l1              ; not a Z180
        ; found a Z180, look for ICR
        defb    0edh, 38h, 0ffh         ; in0 a, (0ffh)
        and     0c0h
        cp      0c0h
        jp      z, z180l1
        defb    0edh, 38h, 0bfh         ; in0 a, (0bfh)
        and     0c0h
        cp      80h
        jp      z, z180l1
        defb    0edh, 38h, 7fh          ; in0 a, (7fh)
        and     0c0h
        cp      40h
        jp      z, z180l1
        defb    0edh, 38h, 3fh          ; in0 a, (3fh)
        and     0c0h
        jp	z, z180l1
	ld	a, 0ffh			; couldn't find ICR
        or      a
z180l1: ld      (z180base), a
        ret


; save value of register c in (hl)
z180save:
        call    z180in
        ld      (hl), a
        ret

; read from Z180 I/O register C + z180base into A
z180in:
        push    bc
        push    af
        ld      a, (z180base)
        cp      0ffh
        jp      z, z180popret
        add     c
        ld      b, 0
        ld      c, a
        pop     af
        in      a, (c)
        pop     bc
        ret

; restore value from (hl) to z180 register in c
z180restore:
        ld      a, (hl)
        ; fallthrough to z180out

; write a to Z180 I/O register c + z180base
z180out:
        push    bc
        push    af
        ld      a, (z180base)
        cp      0ffh
        jp      z, z180popret
        add     c
        ld      b, 0
        ld      c, a
        pop     af
        out     (c), a
        pop     bc
        ret

z180popret:
        pop     af
        pop     bc
        ret

; get clock multiple in E (0 = divide by two)
z180getclk:
        ld      e, 1                    ; start with clock X1
        ld      c, Z180_CMR             ; check clock multiplier
        call    z180in
        and     80h
        jp      z, z180l1               ; multiplier disabled, leave clock alone
        inc     e                       ; multiplier enabled, increase clock multiple
z180l2: ld      c, Z180_CCR             ; check clock divider
        call    z180in
        and     80h
        ret     nz                      ; divider disabled, leave clock alone
        dec     e                       ; divider enabled, decrease clock
        ret

; enable clock divider (1/2 crystal frequency)
z180clkslow:
        ld      c, Z180_CMR
        ld      d, 7fh
        call    z180clr                 ; clear multiply bit
        ld      c, Z180_CCR
        ld      d, 7fh                  ; clear /divide bit
        ; fallthrough to z180clr

; clear bits in D on register C
z180clr:
        call    z180in
        and     d
        jp      z180out

; normal clock at crystal frequency
z180clknorm:
        ld      c, Z180_CMR
        ld      d, 7fh
        call    z180clr                 ; clear multiply bit
        ld      c, Z180_CCR
        ld      d, 80h
        jp      z180set                 ; set /divide bit

; enable clock multiplier (2X crystal frequency)
z180clkfast:
        ld      c, Z180_CMR
        ld      d, 80h
        call    z180set                 ; set multiply bit
        ld      c, Z180_CCR
        ld      d, 80h                  ; set /divide bit   
        ; fallthrough to z180set

; set bits in D on register C
z180set:
        call    z180in
        or      d
        jp      z180out

; set I/O wait states to A
z180iowait:
        or      a
        ret     z
        dec     a
        rlca
        rlca
        rlca
        rlca
        and     30h
        ld      e, a
        ld      d, 0dfh
        ld      c, Z180_DCNTL
        jp      z180mask

; set memory wait states to A
z180memwait:
        rlca
        rlca
        rlca
        rlca
        rlca
        rlca
        and     0d0h
        ld      e, a
        ld      d, 03fh
        ; fallthrough to z180mask

; get register C, mask off bits with D, set bits in E
z180mask:
        call    z180in
        and     d
        or      e
        jp      z180out