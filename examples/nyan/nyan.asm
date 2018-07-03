; Nyan Cat for RC2014 with TMS9918 and YM2149
; Hand-written assembly by J.B. Langston
; Images and music from Nyan Cat for MSX: https://www.msx.org/news/en/nyan-cat-msx
; Assembles with sjasm

                org $0100

tmsram:         equ $98                 ; TMS9918A VRAM port
tmsreg:         equ $99                 ; TMS9918A register port
im1vect:        equ $39                 ; location of interrupt mode 1 vector
frameticks:     equ 3                   ; number of interrupts per animation frame
framecount:     equ 12                  ; number of frames in animation

        jp      start

music:
                incbin  "music.bin"     ; music data
                include "arkos.asm"

animation:
                incbin  "nyan.bin"      ; animation data

start:
	ld      sp, $FFFF
        ld      hl, multicolor          ; configure registers multi-color mode
        call    tmsconfig
        call    tmsclear                ; clear VRAM
        call    tmsmcname               ; set up name table for multi-color mode
        ld      de, music               ; initialize player
        call    PLY_Init
        ld      a, frameticks           ; initialize interrupt counter to frame length
        ld      (intcounter), a
        ld      hl, inthandler          ; install the interrupt handler
        call    im1setup
mainloop:
        jr      mainloop                ; busy wait and let interrupts do their thing

; set up interrupt mode 1 vector
;       HL = interrupt handler
im1setup:
        di
	ld      a, $C3                  ; prefix with jump instruction
	ld      (im1vect-1), a
        ld      (im1vect), hl           ; load interrupt vector
	im      1                       ; enable interrupt mode 1
        ei
        ret

intcounter:
        defb    0                       ; interrupt down counter
currframe:
        defb    0                       ; current frame of animation

; interrupt handler: rotate animation frames
inthandler:
        in      a, (tmsreg)             ; clear interrupt flag
        call    PLY_Play
        ld      a, (intcounter)         ; check if we've been called frameticks times
        or      a
        jr      nz, framewait           ; if not, wait to draw next animation frame
        ld      hl, animation           ; draw the current frame
        ld      a, (currframe)
        call    drawframe
        ld      a, (currframe)          ; next animation frame
        inc     a
        cp      framecount              ; have we displayed all frames yet?
        jr      nz, skipreset           ; if not, display the next frame
        ld      a, 0                    ; if so, start over at the first frame
skipreset:
        ld      (currframe), a          ; save next frame in memory
        ld      a, frameticks           ; reset interrupt down counter
        ld      (intcounter), a
        ei
        reti
framewait:
        ld      hl, intcounter          ; not time to switch animation frames yet
        dec     (hl)                    ; decrement down counter
        ei
        reti

; draw a single animation frame
;       HL = animation data base address
;       A = current animation frame number
drawframe:
        ld      d, a                    ; x 1
        add     a, d                    ; x 2
        add     a, d                    ; x 3
        add     a, a                    ; x 6
        ld      d, a                    ; offset = frame x 600h
        ld      e, 0
        add     hl, de                  ; add offset to base address
        ld      de, $0000               ; pattern table address in vram
        ld      bc, $0600               ; length of one frame
        call    tmswrite                ; copy frame to pattern table
        ret

; delay at least 8us to allow TMS to process data
tmswait:
        defb 0,0,0,0,0,0,0
        defb 0,0,0,0,0,0,0              ; 14 nops
        ret

; register values for multicolor mode
multicolor:
	defb $00, $E8, $02, $00, $00, $36, $07, $04

; set the next address of video memory to write
;       DE = address
tmswriteaddr:
        ld      a, e                    ; send lsb
        out     (tmsreg), a
        call    tmswait
        ld      a, d                    ; mask off msb to max of 16KB
        and     $3F
        or      $40                     ; set second highest bit to indicate write
        out     (tmsreg), a             ; send msb
        call    tmswait
        ret

; write bytes from ram to vram
;       HL = ram source address
;       DE = vram destination address
;       BC = byte count
tmswrite:
        call    tmswriteaddr            ; set the starting address
wloop:
        ld      a, (hl)                 ; get the current byte
        out     (tmsram), a             ; send to TMS
        call    tmswait
        inc     hl                      ; next byte
        dec     bc                      ; decrement counter
        ld      a, b                    ; loop until zero
        or      c
        jr      nz, wloop
        ret

; fill video memory
;       DE = start address
;       BC = byte count
;       L = fill value
tmsfill:
        call    tmswriteaddr            ; set the starting address
floop:
        ld      a, l                    ; send the fill value to VRAM
        out     (tmsram), a
        call    tmswait
        dec     bc                      ; decrement the counter
        ld      a, b                    ; loop until 0
        or      c
        jr      nz, floop
        ret

; clear all 16KB of video memory
tmsclear:
        ld      de, 0                   ; start a addres 0000H
        ld      bc, $4000               ; write 4000 bytes
        ld      l, 0                    ; all zeroes
        call    tmsfill
        ret

; initialize tms with specified register table
;       HL = register table
tmsconfig:
	ld      b, 8                    ; TMS9918A has 8 registers
rloop:
  	ld      a, (hl)                 ; get register value
	out     (tmsreg), a             ; send it to the TMS9918A
        call    tmswait
	ld      a, 8                    ; get current register number
	sub     b
	or      $80                     ; set high bit to indicate a register
	out     (tmsreg), a             ; send it to the TMS
        call    tmswait
	inc     hl                      ; next register
	djnz    rloop
	ret

; initialize name table for multicolor mode 
tmsmcname:
        ld      de, $0800               ; name table start address
        call    tmswriteaddr
        ld      d, 6                    ; nametable has 6 different sections
        ld      e, 0                    ; first section starts at 0
oloop:
        ld      c, 4                    ; each section has 4 identical lines
mloop:
        ld      b, 32                   ; each line is 32 pixels wide
        ld      a, e                    ; load the section's starting value
iloop:
        out     (tmsram), a             ; output current pixel's name entry
        call    tmswait
        inc     a                       ; increment name entry
        djnz    iloop                   ; next pixel
        dec     c                       ; decrement line counter
        jr      nz, mloop               ; next line
        ld      a, e                    ; next section's starting value is
        add     a, 32                   ; 32 higher than the previous section
        ld      e, a
        dec     d                       ; decrement section counter
        jr      nz, oloop               ; next section
        ret