; Plasma Effect for TMS9918
; 
; Based on 6809 Plasma Code by Matt Sarnoff (msarnoff.org)
; Ported to Z80 by J.B. Langston
;
; Original source: https://github.com/74hc595/Ultim809/blob/master/code/user/plasma/plasma.asm

ramtop:         equ $ffff
im1vect:        equ $38                 ; location of interrupt mode 1 vector
nmivect:        equ $66

sprpattbl:	equ $0
pattbl:		equ $800
spratttbl:	equ $1000
nametbl:	equ $1400
colortbl:	equ $2000

gridwidth:	equ 32
gridheight:	equ 24
gridsize:	equ gridwidth*gridheight
numcolors:	equ 8
cellfn:		equ wave2

        org $100

        jp start

        include "tms.asm"

curgrid:	dw 0			; pointers to grid buffers
nextgrid:	dw 0

grid1:		ds gridsize		; grid buffers
grid2:		ds gridsize

start:
        ld      sp, ramtop
        call    tmsgraph1
	
	ld	de, pattbl		; load pattern table
	ld	b, numcolors		; (one copy for each color)
patloop:
	push	bc
	ld	hl, patterns
	ld	bc, patlen
	call	tmswrite
	pop	bc
	ex	de, hl
	ld	de, patlen
	add	hl, de
	ex	de, hl
	djnz	patloop

	ld	hl, colors		; load color table
	ld	de, colortbl
	ld	bc, colorlen
	call	tmswrite

	ld	hl, grid1		; init variables
	ld	(curgrid), hl
	ld	hl, grid2
	ld	(nextgrid), hl
	ld	ix, 3			; divide by 3 counter

        ld      hl, inthandler		; setup interrupts
        call    nmisetup
        call    tmsintenable

	ld	de, 0			; clear frame counter
mainloop:
	ld	hl, (nextgrid)		; init cell pointer
	ld	c, gridheight		; init row counter
yloop:
	ld	b, gridwidth		; init column counter
xloop:
	call	cellfn			; calculate current cell
	and	$7f
	ld	(hl), a			; save cell in buffer
	inc	hl			; cell pointer
	djnz 	xloop			; next column
	dec	c			; next row
	jp	nz, yloop
	inc	d			; frame counter
	dec	ix
	jp	nz, flipbuffers
	ld	ix, 3
	inc	e			; frame/3 counter
flipbuffers:
	ld	bc, (nextgrid)		; swap buffer pointers
	ld	hl, (curgrid)
	ld	(curgrid), bc
	ld	(nextgrid), hl
	halt				; sync to interrupt
        jr      mainloop		; next frame

gradient:				; diagonal gradient
	ld 	a, b			; x
	add	a, c			; x + y
	sub	a, d			; x + y - time
	ret

munching:				; munching squares
	ld	a, b			; x
	dec	a			; x - 1
	xor	a, c			; (x - 1) xor y
	add	a, d			; ((x - 1) xor y) + time
	ret

wave:					; plasma 1
	push	hl
	ld	h, (sin8 >> 8)
	ld	a, b			; x
	add	a, d			; x + time
	ld	l, a
	ld	a, (hl)			; sin(x + time)
	add	a, c			; sin(x + time) + y
	sub	a, d			; sin(x + time) + y - time
	ld	l, a
	ld	a, (hl)			; sin(sin(x + time) + y - time)
	pop	hl
	ret

wave2:					; plasma 2
	push	hl
	push	bc
	ld	h, (sin8 >> 8)
	ld	a, b			; x
	add	a, e			; x + time/3
	ld	l, a
	ld	a, (hl)			; sin(x + time/3)
	add	a, d			; sin(X + time/3) + time
	ld	l, a
	ld	b, (hl)			; sin(sin(X + time/3) + time)
	ld	a, c			; y
	add	a, d			; y + time
	ld	l, a
	ld	a, (hl)			; sin(y + time)
	add	a, e			; sin(y + time) + time/3
	ld	l, a
	ld	a, (hl)			; sin(sin(y + time) + time/3)
	add	a, b			; sin(sin(y + time) + time/3) + sin(sin(X + time/3) + time)
	pop bc
	pop hl
	ret

; sine table

	align 256
sin8:
	db  0,3,6,9,12,15,18,21,24,27,30,34,37,39
	db  42,45,48,51,54,57,60,62,65,68,70,73,75
	db  78,80,83,85,87,90,92,94,96,98,100,102
	db  104,106,107,109,110,112,113,115,116,117
	db  118,120,121,122,122,123,124,125,125,126
	db  126,126,127,127,127,127,127,127,127,126
	db  126,126,125,125,124,123,122,122,121,120
	db  118,117,116,115,113,112,110,109,107,106
	db  104,102,100,98,96,94,92,90,87,85,83,80
	db  78,75,73,70,68,65,62,60,57,54,51,48,45
	db  42,39,37,34,30,27,24,21,18,15,12,9,6,3
	db  -4,-7,-10,-13,-16,-19,-22,-25,-28,-31
	db  -35,-38,-40,-43,-46,-49,-52,-55,-58,-61
	db  -63,-66,-69,-71,-74,-76,-79,-81,-84,-86
	db  -88,-91,-93,-95,-97,-99,-101,-103,-105
	db  -107,-108,-110,-111,-113,-114,-116,-117
	db  -118,-119,-121,-122,-123,-123,-124,-125
	db  -126,-126,-127,-127,-127,-128,-128,-128
	db  -128,-128,-128,-128,-127,-127,-127,-126
	db  -126,-125,-124,-123,-123,-122,-121,-119
	db  -118,-117,-116,-114,-113,-111,-110,-108
	db  -107,-105,-103,-101,-99,-97,-95,-93,-91
	db  -88,-86,-84,-81,-79,-76,-74,-71,-69,-66
	db  -63,-61,-58,-55,-52,-49,-46,-43,-40,-38
	db  -35,-31,-28,-25,-22,-19,-16,-13,-10,-7,-4, -1

; set up interrupt mode 1 vector
;       HL = interrupt handler
im1setup:
        di
	ld      a, $C3                  ; jump instruction
	ld      (im1vect), a
        ld      (im1vect+1), hl         ; load interrupt vector
	im      1                       ; enable interrupt mode 1
        ei
        ret

; set up NMI vector
;       HL = interrupt handler
nmisetup:
	ld      a, $C3                  ; jump instruction
	ld      (nmivect), a
        ld      (nmivect+1), hl         ; load interrupt vector
        ret

; interrupt handler: rotate animation frames
inthandler:
	exx
	ex	af, af'
        in      a, (tmsreg)             ; clear interrupt flag
	ld	hl, (curgrid)		; load name table
	ld	de, nametbl
	ld	bc, gridsize
	call	tmswrite
	ex	af, af'
	exx	
        ;ei				; uncomment if not using NMI
        reti


; color table

colors:	db	0x98,0x98
	db	0xB9,0xB9
	db	0x3B,0x3B
	db	0x73,0x73
	db	0x57,0x57
	db	0x45,0x45
	db	0xD4,0xD4
	db	0x8D,0x8D
colorlen: equ $ - colors

; pattern table

patterns:
; tile (0,0)-(7,7)
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
; tile (8,0)-(15,7)
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00000000
	db	%00010000
	db	%00000000
	db	%00000000
; tile (16,0)-(23,7)
	db	%00000000
	db	%00000001
	db	%10010000
	db	%00001000
	db	%00000010
	db	%10000000
	db	%00010000
	db	%00000010
; tile (24,0)-(31,7)
	db	%00000000
	db	%00101010
	db	%00000000
	db	%01001001
	db	%00010000
	db	%10000100
	db	%00100000
	db	%00010010
; tile (32,0)-(39,7)
	db	%00100001
	db	%01001010
	db	%00100001
	db	%00010100
	db	%01100000
	db	%10101001
	db	%01000100
	db	%00010010
; tile (40,0)-(47,7)
	db	%00100100
	db	%10010010
	db	%01001010
	db	%01010100
	db	%10001010
	db	%00010010
	db	%10101010
	db	%10010000
; tile (48,0)-(55,7)
	db	%10101010
	db	%01001001
	db	%01010101
	db	%10010010
	db	%01010101
	db	%10101010
	db	%01001010
	db	%01010101
; tile (56,0)-(63,7)
	db	%10101010
	db	%01010101
	db	%10101010
	db	%01010101
	db	%10101010
	db	%01010101
	db	%10101010
	db	%01010101
; tile (64,0)-(71,7)
	db	%10101010
	db	%01101101
	db	%10101011
	db	%10101010
	db	%11010010
	db	%10101010
	db	%01101101
	db	%01010101
; tile (72,0)-(79,7)
	db	%11011011
	db	%01101010
	db	%10111011
	db	%01010110
	db	%10101001
	db	%01010111
	db	%11111010
	db	%01010110
; tile (80,0)-(87,7)
	db	%10111101
	db	%11010111
	db	%01111010
	db	%10101111
	db	%11101010
	db	%10111110
	db	%11010101
	db	%11011101
; tile (88,0)-(95,7)
	db	%11111111
	db	%01010101
	db	%11111111
	db	%10101010
	db	%11111111
	db	%11010101
	db	%10111111
	db	%11101011
; tile (96,0)-(103,7)
	db	%11111111
	db	%01101101
	db	%11111111
	db	%11011011
	db	%10111111
	db	%11101101
	db	%01111111
	db	%11101101
; tile (104,0)-(111,7)
	db	%11111111
	db	%11111111
	db	%01101111
	db	%11110110
	db	%11111111
	db	%01111111
	db	%11101101
	db	%11111111
; tile (112,0)-(119,7)
	db	%11111111
	db	%11111111
	db	%11111111
	db	%11111111
	db	%11101111
	db	%11111111
	db	%11111111
	db	%11111111
; tile (120,0)-(127,7)
	db	%11111111
	db	%11111111
	db	%11111111
	db	%11111111
	db	%11111111
	db	%11111111
	db	%11111111
	db	%11111111
patlen: equ $ - patterns