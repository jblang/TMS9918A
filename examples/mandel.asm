; Z80 Mandelbrot with output to TMS9918 video chip
;
; Fixed point Mandelbrot routine from https://rosettacode.org/wiki/Mandelbrot_set#Z80_Assembly
;
; Adapted to TMS9918 by J.B. Langston

ramtop:         equ     $ffff
bdos:           equ     $0005

                org     100h
                ld      (oldstack),sp           ; save old stack pointer
                ld      sp, ramtop              ; initailize stack
                jp      mandelbrot

                include "tms.asm"               ; TMS subroutines

; mandelbrot constants
scale:          equ     256                     ; Do NOT change this - the
                                                ; arithmetic routines rely on
                                                ; this scaling factor! :-)

divergent:      equ     scale * 4

iteration_max:  equ     14                      ; How many iterations
x_start:        equ     -2 * scale              ; Minimum x-coordinate
x_end:          equ     scale - 1               ; Maximum x-coordinate
x_step:         equ     3                       ; x-coordinate step-width
y_start:        equ     -9 * (scale / 8)        ; Minimum y-coordinate
y_end:          equ     9 * (scale / 8) - 1     ; Maximum y-coordinate
y_step:         equ     3                       ; y-coordinate step-width

; mandelbrot variables
oldstack:        defw    0
x:               defw    0                       ; x-coordinate
y:               defw    0                       ; y-coordinate
z_0:             defw    0
z_1:             defw    0
scratch_0:       defw    0
z_0_square_high: defw    0
z_0_square_low:  defw    0
z_1_square_high: defw    0
z_1_square_low:  defw    0

; mandelbrot entry point
mandelbrot:
                call    tmsbitmap
                xor     a                     ; clear pixel counters
                ld      (xypos), a
                ld      (xypos+1), a
                ld      (bitindex), a
                ld      hl, y_start             ; y = y_start
                ld      (y), hl

; for (y = <initial_value> ; y <= y_end; y += y_step)
; {
outer_loop:     ld      hl, y_end               ; Is y <= y_end?
                ld      de, (y)
                and     a                       ; Clear carry
                sbc     hl, de                  ; Perform the comparison
                jp      m, mandel_end           ; End of outer loop reached

;    for (x = x_start; x <= x_end; x += x_step)
;    {
                ld      hl, x_start             ; x = x_start
                ld      (x), hl
inner_loop:     ld      hl, x_end               ; Is x <= x_end?
                ld      de, (x)
                and     a
                sbc     hl, de
                jp      m, inner_loop_end       ; End of inner loop reached

;      z_0 = z_1 = 0;
                ld      hl, 0
                ld      (z_0), hl
                ld      (z_1), hl

;      for (iteration = iteration_max; iteration; iteration--)
;      {
                ld      a, iteration_max
                ld      b, a
iteration_loop: push    bc                      ; iteration -> stack
;        z2 = (z_0 * z_0 - z_1 * z_1) / SCALE;
                ld      de, (z_1)               ; Compute DE HL = z_1 * z_1
                ld      b, d
		ld	c, e
                call    mul_16
                ld      (z_0_square_low), hl    ; z_0 ** 2 is needed later again
                ld      (z_0_square_high), de

                ld      de, (z_0)               ; Compute DE HL = z_0 * z_0
                ld      b, d
		ld	c, e
                call    mul_16
                ld      (z_1_square_low), hl    ; z_1 ** 2 will be also needed
                ld      (z_1_square_high), de

                and     a                       ; Compute subtraction
                ld      bc, (z_0_square_low)
                sbc     hl, bc
                ld      (scratch_0), hl         ; Save lower 16 bit of result
                ld      h, d
		ld	l, e
                ld      bc, (z_0_square_high)
                sbc     hl, bc
                ld      bc, (scratch_0)         ; HL BC = z_0 ** 2 - z_1 ** 2

                ld      c, b                    ; Divide by scale = 256
                ld      b, l                    ; Discard the rest
                push    bc                      ; We need BC later

;        z3 = 2 * z0 * z1 / SCALE;
                ld      hl, (z_0)               ; Compute DE HL = 2 * z_0 * z_1
                add     hl, hl
                ld      d, h
		ld	e, l
                ld      bc, (z_1)
                call    mul_16

                ld      b, e                    ; Divide by scale (= 256)
                ld      c, h                    ; BC contains now z_3

;        z1 = z3 + y;
                ld      hl, (y)
                add     hl, bc
                ld      (z_1), hl

;        z_0 = z_2 + x;
                pop     bc                      ; Here BC is needed again :-)
                ld      hl, (x)
                add     hl, bc
                ld      (z_0), hl

;        if (z0 * z0 / SCALE + z1 * z1 / SCALE > 4 * SCALE)
                ld      hl, (z_0_square_low)    ; Use the squares computed
                ld      de, (z_1_square_low)    ; above
                add     hl, de
                ld      b, h                  ; BC contains lower word of sum
		ld	c, l

                ld      hl, (z_0_square_high)
                ld      de, (z_1_square_high)
                adc     hl, de

                ld      h, l                    ; HL now contains (z_0 ** 2 +
                ld      l, b                    ; z_1 ** 2) / scale

                ld      bc, divergent
                and     a
                sbc     hl, bc

;          break;
                jp      c, iteration_dec        ; No break
                pop     bc                      ; Get latest iteration counter
                jr      iteration_end           ; Exit loop

;        iteration++;
iteration_dec:  pop     bc                      ; Get iteration counter
                djnz    iteration_loop          ; We might fall through!
;      }
iteration_end:
;      printf("%c", display[iteration % 7]);
                inc     b                       ; increment iteration count to get color
                call    drawpixel               ; plot it

                ld      de, x_step              ; x += x_step
                ld      hl, (x)
                add     hl, de
                ld      (x), hl

                jp      inner_loop
;    }
;    printf("\n");
inner_loop_end:

                ld      de, y_step              ; y += y_step
                ld      hl, (y)
                add     hl, de
                ld      (y), hl                 ; Store new y-value

                jp      outer_loop
; }

mandel_end:
        ld	sp,(oldstack)	                ; put stack back to how we found it
        ;ld	c,$0			        ; this is the CP/M proper exit call
        ;jp	bdos
        halt

;
;   Compute DEHL = BC * DE (signed): This routine is not too clever but it
; works. It is based on a standard 16-by-16 multiplication routine for unsigned
; integers. At the beginning the sign of the result is determined based on the
; signs of the operands which are negated if necessary. Then the unsigned
; multiplication takes place, followed by negating the result if necessary.
;
mul_16:         xor     a                       ; Clear carry and A (-> +)
                bit     7, b                    ; Is BC negative?
                jr      z, bc_positive          ; No
                sub     c                       ; A is still zero, complement
                ld      c, a
                ld      a, 0
                sbc     a, b
                ld      b, a
                scf                             ; Set carry (-> -)
bc_positive:    bit     7, D                    ; Is DE negative?
                jr      z, de_positive          ; No
                push    af                      ; Remember carry for later!
                xor     a
                sub     e
                ld      e, a
                ld      a, 0
                sbc     a, d
                ld      d, a
                pop     af                      ; Restore carry for complement
                ccf                             ; Complement Carry (-> +/-?)
de_positive:    push    af                      ; Remember state of carry
                and     a                       ; Start multiplication
                sbc     hl, hl
                ld      a, 16                   ; 16 rounds
mul_16_loop:    add     hl, hl
                rl      e
                rl      d
                jr      nc, mul_16_exit
                add     hl, bc
                jr      nc, mul_16_exit
                inc     de
mul_16_exit:    dec     a
                jr      nz, mul_16_loop
                pop     af                      ; Restore carry from beginning
                ret     nc                      ; No sign inversion necessary
                xor     a                       ; Complement DE HL
                sub     l
                ld      l, a
                ld      a, 0
                sbc     a, h
                ld      h, a
                ld      a, 0
                sbc     a, e
                ld      e, a
                ld      a, 0
                sbc     a, d
                ld      d, a
                ret

; working area for 8 pixels at a time
primary:        defb 0                          ; primary color
secondary:      defb 0                          ; secondary color
pattern:        defb 0                          ; color bit pattern
bitindex:       defb 0                          ; current bit within byte
xypos:          defw 0                          ; current x, y position on the screen

; plot a pixel to TMS9918 screen
;       B = color of pixel
drawpixel:       
                ld      a, (bitindex)           ; check whether this is the first bit of a byte
                or      a
                ld      a, b                    ; load the current color in a
                jr      nz, comparecolor        ; for subsequent bits, proceed to comparison
                ld      (primary), a            ; for first bit, set both colors to current color
                ld      (secondary), a
comparecolor:        
                ld      hl, primary             ; compare the current color to primary color
                cp      (hl)
                scf              
                jr      z, setbit               ; if it's the same, set the pattern bit
                cp      1                       ; if it's different, is the current color black?
                jr      z, swapblack            ; if so, make it the primary color
                ld      (secondary), a          ; otherwise, set secondary color to current color
                or      a                       ; and clear the pattern bit
                jr      setbit
swapblack:
                ld      (primary), a            ; set the primary color to black
                xor     a                       ; clear all previous pattern bits
                ld      (pattern), a
                scf                             ; and set the current pattern bit
setbit:          
                ld      hl, pattern             ; pull the current pattern bit into the byte
                rl      (hl)

                ld      a, (bitindex)           
                inc     a                       ; increment the bit index
                and     7                       ; mask it to a maximum of 7
                ld      (bitindex), a           ; save it back in memory
                ret     nz                      ; if this wasn't the last bit, we're done

                ld      bc, (xypos)             ; calculate address for current x, y position
                ld      a, b                    ; d = (y / 8)
                rrca
                rrca
                rrca
                and     1fh
                ld      d, a
                ld      a, c                    ; e = (x & f8) + (y & 7)
                and     0f8h
                ld      e, a
                ld      a, b
                and     7
                or      e
                ld      e, a

                call    tmswriteaddr            ; set write address within pattern table
                ld      a, (pattern)            ; send the pattern to the TMS
                out     (tmsram), a

                ld      bc, 2000h               ; add the color table base address
                ex      de, hl
                add     hl, bc
                ex      de, hl
                call    tmswriteaddr            ; set write address within color table
                ld      a, (primary)            ; load primary color into upper 4 bits
                add     a, a
                add     a, a
                add     a, a
                add     a, a
                ld      hl, secondary           ; load secondary color into lower 4 bits
                or      (hl)
                out     (tmsram), a             ; send to TMS

                ld      hl, (xypos)             ; increase next x/y position by 8 pixels
                ld      de, 8
                add     hl, de
                ld      (xypos), hl
                ret