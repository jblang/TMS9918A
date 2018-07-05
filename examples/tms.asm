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


; ---------------------------------------------------------------------------
; configuration parameters

tmsram:         equ $98                 ; TMS9918A VRAM port
tmsreg:         equ $99                 ; TMS9918A register port

tmsclkdiv:      equ 3                   ; Z80 clock divider
                                        ; 1 for <= 10 MHz
                                        ; 2 for <= 5 MHz
                                        ; 3 for <= 3.33 MHz
                                        ; ... and so on

; ---------------------------------------------------------------------------
; register constants

tmswritebit:    equ $40                 ; bit to indicate memory write
tmsregbit:      equ $80                 ; bit to indicate register write

tmsctrl0:       equ 0                   ; control bits
tmsmode3:       equ 1                   ;       mode bit 3
tmsextvid:      equ 0                   ;       external video

tmsctrl1:       equ 1                   ; control bits
tms4k16k:       equ 7                   ;       4/16K RAM
tmsblank:       equ 6                   ;       screen blank
tmsinten:       equ 5                   ;       interrupt enable
tmsmode1:       equ 4                   ;       mode bit 1
tmsmode2:       equ 3                   ;       mode bit 2
tmssprsize:     equ 1                   ;       sprite size
tmssprmag:      equ 0                   ;       sprite magnification

tmsnametbl:     equ 2                   ; name table location (* $400)
tmscolortbl:    equ 3                   ; color table location (* $40)
                                        ; graphics 2 mode: MSB 0 = $0000, MSB 1 = $2000
tmspattern:     equ 4                   ; pattern table location (* $800)
tmsspriteattr:  equ 5                   ; sprite attribute table (* $80)
tmsspritepttn:  equ 6                   ; sprite pattern table (* $800)
tmscolor:       equ 7                   ; screen colors (upper = text, lower = background)

; ---------------------------------------------------------------------------
; color constants

tmstransparent: equ 0
tmsblack:       equ 1
tmsmedgreen:    equ 2
tmslightgreen:  equ 3
tmsdarkblue:    equ 4
tmslightblue:   equ 5
tmsdarkred:     equ 6
tmscyan:        equ 7
tmsmedred:      equ 8
tmslightred:    equ 9
tmsdarkyellow:  equ $A
tmslightyellow: equ $B
tmsdarkgreen:   equ $C
tmsmagenta:     equ $D
tmsgray:        equ $E
tmswhite:       equ $F

; ---------------------------------------------------------------------------
; register configuration routines

; shadow copy of register values
tmsshadow:
        defs    8, 0

; set a single register value
;       A = register value
;       E = register to set
tmssetreg:
        ld      hl, tmsshadow           ; get shadow table address
        ld      d, 0
        add     hl, de                  ; add offset to selected register
        ld      (hl), a                 ; save to shadow slot
        out     (tmsreg), a             ; send to TMS
        ld      a, tmsregbit            ; select requested register
        or      e
        out     (tmsreg), a
        ret

; set the background color
;       A = requested color
tmsbackground:
        and     $0F                     ; mask off high nybble
        ld      b, a                    ; save for later
        ld      a, (tmsshadow+tmscolor) ; get current colors
        and     $F0                     ; mask off old background
        or      b                       ; set new background
        ld      e, tmscolor
        jp      tmssetreg               ; set the color

; set text color
;       A = requested color
tmstextcolor:
        add     a, a                    ; shift text color into high nybble
        add     a, a
        add     a, a
        add     a, a
        ld      b, a                    ; save for later
        ld      a, (tmsshadow+tmscolor) ; get current colors
        and     $0F                     ; mask off old text color
        or      b                       ; set new text color
        ld      e, tmscolor
        jp      tmssetreg               ; save it back

; enable vblank interrupts
tmsintenable:
        ld      a, (tmsshadow+tmsctrl1) ; get current control register value
        set     tmsinten, a             ; set interrupt enable bit
        ld      e, tmsctrl1
        jp      tmssetreg               ; save it back

; disable vblank interrupts
tmsintdisable:
        ld      a, (tmsshadow+tmsctrl1) ; get current control register value
        res     tmsinten, a             ; clear interrupt enable bit
        ld      e, tmsctrl1
        jp      tmssetreg               ; save it back

; configure tms from specified register table
;       HL = register table
tmsconfig:
        ld      de, tmsshadow           ; start of shadow area
	ld      c, 8                    ; 8 registers
.regloop:
  	ld      a, (hl)                 ; get register value from table
	out     (tmsreg), a             ; send it to the TMS
	ld      a, 8                    ; calculate current register number
	sub     c
	or      tmsregbit               ; set high bit to indicate a register
        ldi                             ; shadow, then inc pointers and dec counter
	out     (tmsreg), a             ; send it to the TMS
        xor     a                       ; continue until count reaches 0
        or      c
	jr      nz, .regloop
	ret

; ---------------------------------------------------------------------------
; memory access routines

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
;       BC = byte count (0 for null terminated)
tmswrite:
        call    tmswriteaddr            ; set the starting address
.copyloop:
        ld      a, (hl)                 ; get the current byte from ram
        out     (tmsram), a             ; send it to vram
        defs    11/tmsclkdiv, 0         ; nops to waste time
        inc     hl                      ; next byte
        dec     bc                      ; continue until count is zero
        ld      a, b
        or      c
        jr      nz, .copyloop
        ret

; copy a null-terminated string to VRAM
;       HL = ram source address
;       DE = vram destination address
tmsstrout:
        call    tmswriteaddr
.strloop:
        ld      a, (hl)                 ; get the current byte from ram
        cp      0                       ; return when NULL is encountered
        ret     z
        out     (tmsram), a             ; send it to vram
        defs    14/tmsclkdiv, 0         ; nops to waste time
        inc     hl                      ; next byte
        jr      .strloop

; ---------------------------------------------------------------------------
; initialization routines

; register values for blanked screen with 16KB RAM enabled
tmsblankreg:
        defb    $00, $80, $00, $00, $00, $00, $00, $00

; reset registers and clear all 16KB of video memory
tmsreset:
        ld      hl, tmsblankreg         ; blank the screen with 16KB enabled
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

; register values for multicolor mode
tmsmcreg:
	db      %00000000               ; external video disabled
        db      %11001000               ; 16KB, display enabled, multicolor mode
        db      $02                     ; name table at $8000
        db      $00                     ; color table not used
        db      $00                     ; pattern table at $0000
        db      $76                     ; sprite attribute table at $3B00
        db      $03                     ; sprite pattern table at $1800
        db      $00                     ; black background

; initialize tms for multicolor mode 
tmsmulticolor:
        call    tmsreset                ; blank the screen and clear vram
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

; register values for bitmapped graphics
tmsbitmapreg:
        db      %00000010               ; bitmap mode, no external video
        db      %11000000               ; 16KB ram; enable display
        db      $0e                     ; name table at 3800H
        db      $ff                     ; color table at 2000H
        db      $03                     ; pattern table at 0000H
        db      $76                     ; sprite attribute table at 3B00H
        db      $03                     ; sprite pattern table at 1800H
        db      $01                     ; black background

; initialize TMS for bitmapped graphics
tmsbitmap:
        call    tmsreset
        ld      de, $3800               ; initialize nametable with 3 sets
        call    tmswriteaddr            ; of 256 bytes ranging from 00-FF
        ld      b, 3
        ld      a, 0
.nameloop:
        out     (tmsram), a
        nop
        inc     a
        jr      nz, .nameloop
        djnz    .nameloop
        ld      hl, tmsbitmapreg        ; configure registers for bitmapped graphics
        call    tmsconfig
        ret

tmstextreg:
        db      %00000000               ; text mode, no external video
        db      %11010000               ; 16K, Enable Display, Disable Interrupt
        db      $00                     ; name table at $0000
        db      $00                     ; color table not used
        db      $01                     ; pattern table at $0800
        db      $00                     ; sprite attribute table not used
        db      $00                     ; sprite pattern table not used
        db      $F1                     ; white text on black background

; initialize TMS for text mode
;       HL = address of font to load
tmstextmode:
        push    hl                      ; save address of font
        call    tmsreset
        pop     hl                      ; load font into pattern table
        ld      de, $0800
        ld      bc, $0800
        call    tmswrite
        ld hl,  tmstextreg
        call    tmsconfig
        ret