ramtop:         equ $ffff
im1vect:        equ $38                 ; location of interrupt mode 1 vector
frameticks:     equ 6                   ; number of interrupts per animation frame
framecount:     equ 8                   ; number of frames in animation

        org $100

        jp start

tmsfont:
        include "tms.asm"

start:
        ld      sp, ramtop
        call    tmsbitmap
        ld      bc, $200
        ld      de, $1800
        ld      hl, WORLD0
        call    tmswrite
        ld      a, frameticks           ; initialize interrupt counter to frame length
        ld      (tickcounter), a
        ld      hl, inthandler          ; install the interrupt handler
        call    im1setup
        call    tmsintenable            ; enable interrupts on TMS
mainloop:
        jr      mainloop                ; busy wait and let interrupts do their thing

; set up interrupt mode 1 vector
;       HL = interrupt handler
im1setup:
        di
	ld      a, $C3                  ; prefix with jump instruction
	ld      (im1vect), a
        ld      (im1vect+1), hl         ; load interrupt vector
	im      1                       ; enable interrupt mode 1
        ei
        ret

; interrupt handler: rotate animation frames
inthandler:
        in      a, (tmsreg)             ; clear interrupt flag
        call    drawframe               ; draw next frame, if it's time
        ei
        reti

tickcounter:
        defb    0                       ; interrupt down counter
currframe:
        defb    0                       ; current frame of animation
xdelta:
        defb    1                       ; direction of x axis motion
ydelta:
        defb    1                       ; directino of y axis motion

; Sprite Attributes
sprite1y:
        db 88
sprite1x:
        db 0
sprite1name:
        db 0
sprite1color: 
        db tmsdarkblue
sprite2y:
        db 88
sprite2x:
        db 0
sprite2name:
        db 4
sprite2color:
        db tmslightgreen


; change direction of motion
;       HL = pointer to direction variable
changedir:
        push    af
        ld      a, (hl)
        neg
        ld      (hl), a
        pop     af
        ret

; draw a single animation frame
;       HL = animation data base address
;       A = current animation frame number
drawframe:
        ld      hl, xdelta              ; move x position
        ld      a, (sprite1x)
        add     a, (hl)
        ld      (sprite1x), a
        ld      (sprite2x), a
        cp      240                     ; bounce off the edge
        call    z, changedir
        cp      0
        call    z, changedir
        ld      hl, ydelta              ; move y position
        ld      a, (sprite1y)
        add     a, (hl)
        ld      (sprite1y), a
        ld      (sprite2y), a
        cp      176                     ; bounce off the edge
        call    z, changedir
        cp      0
        call    z, changedir
        ld      a, (tickcounter)        ; check if we've been called frameticks times
        or      a
        jr      nz, framewait           ; if not, wait to draw next animation frame
        ld      a, (currframe)          ; next animation frame
        add     a, a                    ; multiply current frame x 8
        add     a, a
        add     a, a
        ld      (sprite1name), a        ; set name for first sprite
        add     a, 4                    ; add 4
        ld      (sprite2name), a        ; set name for second sprite
        ld      a, (currframe)          ; next animation frame
        inc     a
        cp      framecount              ; have we displayed all frames yet?
        jr      nz, skipreset           ; if not, display the next frame
        ld      a, 0                    ; if so, start over at the first frame
skipreset:
        ld      (currframe), a          ; save next frame in memory
        ld      a, frameticks           ; reset interrupt down counter
        ld      (tickcounter), a
        ret
framewait:
        ld      bc, 8                   ; send updated sprite attribute table
        ld      de, $3b00
        ld      hl, sprite1y
        call    tmswrite
        ld      hl, tickcounter          ; not time to switch animation frames yet
        dec     (hl)                    ; decrement down counter
        ret


; planet sprites from TI VDP Programmer's guide
WORLD0:
        ; Sprite world0 pattern 1
        db  007,028,056,112,120,092,014,015
        db  015,031,127,099,115,061,031,007
        db  224,248,124,102,242,190,220,252
        db  248,160,192,192,226,244,248,224
        ; Sprite world0 pattern 2
        db  000,003,007,015,007,163,241,240
        db  240,224,128,028,012,002,000,000
        db  000,000,128,152,012,065,035,003
        db  007,095,063,062,028,008,000,000
WORLD1:
        ; Sprite world1 pattern 1
        db  003,031,062,124,126,151,003,003
        db  003,007,031,120,124,063,031,007
        db  224,056,028,024,060,047,183,255
        db  254,232,240,240,248,124,248,224
        ; Sprite world1 pattern 2
        db  000,000,001,003,001,104,252,252
        db  252,248,224,007,003,000,000,000
        db  000,192,224,230,194,208,072,000
        db  001,023,015,014,006,128,000,000
WORLD2:
        ; Sprite world2 pattern 1
        db  007,031,063,127,063,229,192,192
        db  128,001,007,030,063,063,031,007
        db  224,200,132,006,142,203,237,255
        db  255,250,252,060,062,220,248,224
        ; Sprite world2 pattern 2
        db  000,000,000,000,064,026,063,063
        db  127,254,248,097,064,000,000,000
        db  000,048,120,248,112,052,018,000
        db  000,005,003,194,192,032,000,000
WORLD3:
        ; Sprite world3 pattern 1
        db  007,031,063,031,079,249,112,240
        db  224,128,001,007,015,031,031,007
        db  224,240,224,194,226,114,059,063
        db  063,126,255,142,206,244,248,224
        ; Sprite world3 pattern 2
        db  000,000,000,096,048,006,143,015
        db  031,127,254,120,112,032,000,000
        db  000,008,028,060,028,141,196,192
        db  192,129,000,112,048,008,000,000
WORLD4:
        ; Sprite world4 pattern 1
        db  007,031,063,103,115,190,220,252
        db  248,160,192,065,099,055,031,007
        db  224,248,248,240,248,092,014,015
        db  015,031,127,226,242,252,248,224
        ; Sprite world4 pattern 2
        db  000,000,000,024,012,065,035,003
        db  007,095,063,062,028,008,000,000
        db  000,000,004,014,006,163,241,240
        db  240,224,128,028,012,000,000,000
WORLD5:
        ; Sprite world5 pattern 1
        db  007,031,031,025,060,047,183,255
        db  254,232,240,112,120,061,031,007
        db  224,248,252,252,254,151,003,003
        db  003,007,031,120,252,252,248,224
        ; Sprite world5 pattern 2
        db  000,000,032,102,067,208,072,000
        db  001,023,015,015,007,002,000,000
        db  000,000,000,002,000,104,252,252
        db  252,248,224,134,002,000,000,000
WORLD6:
        ; Sprite world6 pattern 1
        db  007,015,007,006,015,203,237,255
        db  255,250,252,060,062,031,031,007
        db  224,248,252,126,062,229,192,192
        db  128,001,007,030,062,124,248,224
        ; Sprite world6 pattern 2
        db  000,016,056,121,112,052,018,000
        db  000,005,003,067,065,032,000,000
        db  000,000,000,128,192,026,063,063
        db  127,254,248,224,192,128,000,000
WORLD7:
        ; Sprite world7 pattern 1
        db  007,019,033,065,099,114,059,063
        db  063,126,255,015,079,055,031,007
        db  224,248,252,158,206,249,112,240
        db  224,128,001,006,142,220,248,224
        ; Sprite world7 pattern 2
        db  000,012,030,062,028,141,196,192
        db  192,129,000,112,048,008,000,000
        db  000,000,000,096,048,006,143,015
        db  031,127,254,248,112,032,000,000
