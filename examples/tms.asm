; TMS9918A graphics subroutines
; Copyright 2018-2020 J.B. Langston
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

; VDP Programmer's Guide: http://map.grauw.nl/resources/video/ti-vdp-programmers-guide.pdf

; ---------------------------------------------------------------------------
; configuration parameters; can be changed at runtime
tmsport:
        defb    0beh                    ; port for TMS vram (reg is 1 higher)
tmswait:
        defb    31                      ; iterations to wait after ram access

; ---------------------------------------------------------------------------
; register constants

tmswritebit:    equ 40h                 ; bit to indicate memory write
tmsregbit:      equ 80h                 ; bit to indicate register write

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

tmsnametbl:     equ 2                   ; name table location (* 400h)
tmscolortbl:    equ 3                   ; color table location (* 40h)
                                        ;       graphics 2 mode: MSB 0 = 0000h, MSB 1 = 2000h
tmspattern:     equ 4                   ; pattern table location (* 800h)
tmsspriteattr:  equ 5                   ; sprite attribute table (* 80h)
tmsspritepttn:  equ 6                   ; sprite pattern table (* 800h)
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
tmsdarkyellow:  equ 0Ah
tmslightyellow: equ 0Bh
tmsdarkgreen:   equ 0Ch
tmsmagenta:     equ 0Dh
tmsgray:        equ 0Eh
tmswhite:       equ 0Fh

; ---------------------------------------------------------------------------
; port I/O routines

; These routines access the ports configured in tmsport.

; These memory locations can be set at runtime to support different hardware
; configurations from the same binary.  tmsprobe automatically detects the
; TMS9918A on common ports.

; The TMS9918A RAM must not be accessed more than once every 8 us or display 
; corruption may occur.  During vblank and with the display disabled, 
; accesses can be 2 us apart, but we will always use 8 us minimum delay.

; tmsramin/tmsramout include a configurable delay loop, which waits for the
; configured iterations between VRAM writes to work properly with faster CPUs

; Minimum time to execute each procedure call:
; Z80: 88 cycles, 8.8 us @ 10 MHz
; Z180: 80 cycles, 8.64 us @ 9.216 MHz, 4.32 us @ 18.432, 2.16 us @ 36.864
;
; Additional delay per djnz iteration:
; Z80: 8 cycles * (iterations - 1)
;       0.8 us @ 10 MHz
; Z180: 7 cycles * (iterations - 1)
;       0.756 us @ 9.216 MHz, 0.378 us @ 18.432, 0.189 us @ 36.864

; Delay loop iterations required for different CPU speeds:
; Z80 @ 10 MHz or less: 1
; Z180 @ 9.216 MHz or less: 1
; Z180 @ 18.432 MHz: 10
; Z180 @ 36.864 MHz: 31
tmswaits:      defb 1, 10, 31           ; wait iterations to add for different CPU speeds

; set up wait time based on clock multiplier in E
tmssetwait:
        ld      hl, tmswaits
        ld      d, 0
        add     hl, de
        ld      a, (hl)
        ld      (tmswait), a
        ret

; try to find TMS9918A on a port from the list
tmsprobe:
        ld      hl, tmsports
        ld      b, tmsnumports
tmsp1:  push    bc
        ld      a, (hl)
        ld      (tmsport), a            ; load a port from the list
        call    tmsregin
        ld      de, 0
        call    tmswriteaddr            ; try to write TI into memory
        ld      a, 'T'
        call    tmsramout
        ld      a, 'I'
        call    tmsramout
        ld      de, 0
        call    tmsreadaddr             ; read it back in and see if it matches
        call    tmsramin
        cp      'T'
        jp      nz, tmsp2
        call    tmsramin
        cp      'I'
        jp      z, tmsp3                ; matched, we found the right port
tmsp2:  inc     hl
        pop     bc
        djnz    tmsp1                   ; didn't match, try next port
        or      1                       ; NZ to indicate we didn't find a TMS9918A anywhere
        ret
tmsp3:  pop     bc
        ret

tmsports:       defb 0beh, 98h, 10h, 8  ; ports for ColecoVision, MSX, Sord M5, Tatung Einstein
tmsnumports:    equ $ - tmsports

; write to configured register port
; parameters:
;       A = value to write
tmsregout:
        push    bc
        ld      bc, (tmsport)
        inc     c
        out     (c), a
        pop     bc
        ret

; read from configured register port
; returns:
;       A = value read
tmsregin:
        push    bc
        ld      bc, (tmsport)
        inc     c
        in      a, (c)
        pop     bc
        ret

; write to configured VRAM port
; parameters:
;       A = value to write
                                        ; Z80 | Z180 cycles...
tmsramout:                              ; 17  | 16 (call)
        push    bc                      ; 11  | 11
        ld      bc, (tmsport)           ; 20  | 18
        out     (c), a                  ; 12  | 10
tmsro1: djnz    tmsro1                  ; 8   | 7  plus (13 | 9) * (iterations-1)
        pop     bc                      ; 10  | 9
        ret                             ; 10  | 9

; read from configured VRAM port
; returns:
;       A =  value read
tmsramin:
        push    bc
        ld      bc, (tmsport)
tmsri1: djnz    tmsri1
        in      a, (c)
        pop     bc
        ret

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
        call    tmsregout
        ld      a, tmsregbit            ; select requested register
        or      e
        call    tmsregout
        ret

; set the background color
;       A = requested color
tmsbackground:
        and     0Fh                     ; mask off high nybble
        ld      b, a                    ; save for later
        ld      a, (tmsshadow+tmscolor) ; get current colors
        and     0F0h                    ; mask off old background
        or      b                       ; set new background
        ld      e, tmscolor
        jp      tmssetreg               ; set the color

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
tmsc1: 	ld      a, (hl)                 ; get register value from table
        call    tmsregout
	ld      a, 8                    ; calculate current register number
	sub     c
	or      tmsregbit               ; set high bit to indicate a register
        ldi                             ; shadow, then inc pointers and dec counter
        call    tmsregout
        xor     a                       ; continue until count reaches 0
        or      c
	jp      nz, tmsc1
	ret

; ---------------------------------------------------------------------------
; memory access routines

; set the next address of vram to write
;       DE = address
tmswriteaddr:
        ld      a, e                    ; send lsb
        call    tmsregout
        ld      a, d                    ; mask off msb to max of 16KB
        and     3Fh
        or      40h                     ; set second highest bit to indicate write
        call    tmsregout
        ret

; set the next address of vram to read
;       DE = address
tmsreadaddr:
        ld      a, e                    ; send lsb
        call    tmsregout
        ld      a, d                    ; mask off msb to max of 16KB
        and     3Fh
        call    tmsregout
        ret

; copy bytes from ram to vram
;       HL = ram source address
;       DE = vram destination address
;       BC = byte count
tmswrite:
        call    tmswriteaddr            ; set the starting address
tmsw1:  ld      a, (hl)                 ; get the current byte from ram
        call    tmsramout
        inc     hl                      ; next byte
        dec     bc                      ; continue until count is zero
        ld      a, b
        or      c
        jp      nz, tmsw1
        ret

; fill a section of memory with a single value
;       A = value to fill
;       DE = vram destination address
;       BC = byte count
tmsfill:
        push    af
        call    tmswriteaddr            ; set the starting address
        pop     af
tmsf1:  call    tmsramout
        dec     c
        jp      nz, tmsf1
        djnz    tmsf1                   ; continue until count is zero
        ret

; ---------------------------------------------------------------------------
; text routines
; set text color
;       A = requested color
tmstextcolor:
        add     a, a                    ; shift text color into high nybble
        add     a, a
        add     a, a
        add     a, a
        ld      b, a                    ; save for later
        ld      a, (tmsshadow+tmscolor) ; get current colors
        and     0Fh                     ; mask off old text color
        or      b                       ; set new text color
        ld      e, tmscolor
        jp      tmssetreg               ; save it back

; set the address to place text at X/Y coordinate
;       A = X
;       E = Y
tmstextpos:
        ld      d, 0
        ld      hl, 0
        add     hl, de                  ; Y x 1
        add     hl, hl                  ; Y x 2
        add     hl, hl                  ; Y x 4
        add     hl, de                  ; Y x 5
        add     hl, hl                  ; Y x 10
        add     hl, hl                  ; Y x 20
        add     hl, hl                  ; Y x 40
        ld      e, a
        add     hl, de                  ; add column for final address
        ex      de, hl                  ; send address to TMS
        call    tmswriteaddr
        ret

; copy a null-terminated string to VRAM
;       HL = ram source address
tmsstrout:
        ld      a, (hl)                 ; get the current byte from ram
        cp      0                       ; return when NULL is encountered
        ret     z
        call    tmsramout
        inc     hl                      ; next byte
        jp      tmsstrout

; repeat a character a certain number of times
;       A = character to output
;       B = count
tmschrrpt:
        call    tmsramout
        djnz    tmschrrpt
        ret

; output a character
;       A = character to output
tmschrout:      equ tmsramout

; ---------------------------------------------------------------------------
; bitmap routines

tmsclearpixel:  equ 0A02Fh              ; cpl, and b
tmssetpixel:    equ 0B0h                ; nop, or b

; set operation for tmsplotpixel to perform
;       HL = pixel operation (tmsclearpixel, tmssetpixel)
tmspixelop:
        ld      (tmspp1), hl
        ret

; set or clear pixel at X, Y position
;       B = Y position
;       C = X position
tmsplotpixel:
        ld      a, b                    ; bail out if Y coord > 191
        cp      192
        ret     nc
        call    tmsxyaddr               ; get address in DE for X/Y coord in BC
        ld      hl, masklookup          ; address of mask in table
        ld      a, c                    ; get lower 3 bits of X coord
        and     7
        ld      b, 0
        ld      c, a
        add     hl, bc
        ld      a, (hl)                 ; save mask in A
        ld      b, a
        call    tmsreadaddr             ; set read within pattern table
        call    tmsramin
tmspp1: or      b                       ; mask bit in previous byte
        nop                             ; place holder for 2 byte mask operation
        call    tmswriteaddr            ; set write address within pattern table
        call    tmsramout
        ret

masklookup:
        defb 80h, 40h, 20h, 10h, 8h, 4h, 2h, 1h

; set the color for a block of pixels in bitmap mode
;       B = Y position
;       C = X position
;       A = foreground/background color to set
tmspixelcolor:
        ld      a, b                    ; bail out if Y coord > 191
        cp      192
        ret     nc
        call    tmsxyaddr               ; get address in DE for X/Y coord in BC
        ld      hl, 2000h               ; add the color table base address
        add     hl, de
        ex      de, hl
        call    tmswriteaddr            ; set write address within color table
        call    tmsramout
        ret

; calculate address byte containing X/Y coordinate
;       B = Y position
;       C = X position
;       returns address in DE
tmsxyaddr:
        ld      a, b                    ; d = (y / 8)
        rrca
        rrca
        rrca
        and     1fh
        ld      d, a

        ld      a, c                    ; e = (x & f8)
        and     0f8h
        ld      e, a

        ld      a, b                    ; e += (y & 7)
        and     7
        or      e
        ld      e, a
        ret

; ---------------------------------------------------------------------------
; initialization routines

; register values for blanked screen with 16KB RAM enabled
tmsblankreg:
        defb    0, 80h, 0, 0, 0, 0, 0, 0

; reset registers and clear all 16KB of video memory
tmsreset:
        ld      hl, tmsblankreg         ; blank the screen with 16KB enabled
        call    tmsconfig
        ld      de, 0                   ; start a address 0000H
        call    tmswriteaddr
        ld      de, 4000h               ; write 16KB
tmsr1:  xor     a
        call    tmsramout
        dec     de                      ; continue until counter is 0
        ld      a, d
        or      e
        jp      nz, tmsr1
        ret

; register values for multicolor mode
tmsmcreg:
	defb      %00000000             ; external video disabled
        defb      %11001000             ; 16KB, display enabled, multicolor mode
        defb      2                     ; name table at 8000h
        defb      0                     ; color table not used
        defb      0                     ; pattern table at 0000h
        defb      76h                   ; sprite attribute table at 3B00h
        defb      3                     ; sprite pattern table at 1800h
        defb      0                     ; black background

; initialize tms for multicolor mode 
tmsmulticolor:
        call    tmsreset                ; blank the screen and clear vram
        ld      de, 800h                ; set name table start address
        call    tmswriteaddr
        ld      d, 6                    ; nametable has 6 different sections
        ld      e, 0                    ; first section starts at 0
tmsmc1: ld      c, 4                    ; each section has 4 identical lines
tmsmc2:  ld     b, 32                   ; each line is 32 bytes long
        ld      a, e                    ; load starting value for line
tmsmc3: call    tmsramout               ; write byte to name table
        inc     a                       ; increment value for next byte
        djnz    tmsmc3                  ; next byte in line
        dec     c                       ; decrement line counter
        jp      nz, tmsmc2              ; next line in section
        ld      a, e                    ; get previous section's starting value
        add     a, 32                   ; increase by 32 for the next section
        ld      e, a                    ; save it for later
        dec     d                       ; decrement section counter
        jp      nz, tmsmc1              ; next section
        ld      hl, tmsmcreg            ; switch to multicolor mode
        call    tmsconfig
        ret

; register values for bitmapped graphics
tmsbitmapreg:
        defb      %00000010             ; bitmap mode, no external video
        defb      %11000010             ; 16KB ram; enable display
        defb      0eh                   ; name table at 3800h
        defb      0ffh                  ; color table at 2000h
        defb      3                     ; pattern table at 0
        defb      76h                   ; sprite attribute table at 3B00h
        defb      3                     ; sprite pattern table at 1800h
        defb      1                     ; black background

; initialize TMS for bitmapped graphics
tmsbitmap:
        call    tmsreset
        ld      de, 3800h               ; initialize nametable with 3 sets
        call    tmswriteaddr            ; of 256 bytes ranging from 00-FF
        ld      b, 3
        xor     a
tmsbm1: call    tmsramout
        inc     a
        jp      nz, tmsbm1
        djnz    tmsbm1
        ld      hl, tmsbitmapreg        ; configure registers for bitmapped graphics
        call    tmsconfig
        ret

tmstilereg:
        defb      %00000000             ; graphics 1 mode, no external video
        defb      %11000000             ; 16K, enable display, disable interrupt
        defb      5                     ; name table at 1400h
        defb      80h                   ; color table at 2000h
        defb      1                     ; pattern table at 800h
        defb      20h                   ; sprite attribute table at 1000h
        defb      0                     ; sprite pattern table at 0
        defb      1                     ; black background

; initialize TMS for tiled graphics
tmstile:
        call    tmsreset
        ld      hl, tmstilereg
        call    tmsconfig
        ret

tmstextreg:
        defb      %00000000             ; text mode, no external video
        defb      %11010000             ; 16K, Enable Display, Disable Interrupt
        defb      0                     ; name table at 0000
        defb      0                     ; color table not used
        defb      1                     ; pattern table at 0800h
        defb      0                     ; sprite attribute table not used
        defb      0                     ; sprite pattern table not used
        defb      0F1h                  ; white text on black background

; initialize TMS for text mode
;       HL = address of font to load
tmstextmode:
        push    hl                      ; save address of font
        call    tmsreset
        pop     hl                      ; load font into pattern table
        ld      de, 800h
        ld      bc, 800h
        call    tmswrite
        ld      hl, tmstextreg
        call    tmsconfig
        ret