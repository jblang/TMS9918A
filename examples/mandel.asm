; Z80 Mandelbrot with output to TMS9918 video chip
;
; Fixed point Mandelbrot routine from https://rosettacode.org/wiki/Mandelbrot_set#Z80_Assembly
; Table-based multiplication for Z80 from http://www.cpcwiki.eu/index.php/Programming:Integer_Multiplication#Fast_8bit_.2A_8bit_Unsigned_with_only_512_bytes_of_tables
; Z180 mlt instruction and table-based optimization added by Phillip Stevens (https://feilipu.me/)
;
; Adapted to TMS9918 by J.B. Langston

                org     100h
                jp      start

                include "tms.asm"               ; TMS subroutines
                include "z180.asm"              ; Z180 subroutines
                include "utility.asm"           ; BDOS utility routines

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
x:              defw    0                       ; x-coordinate
y:              defw    0                       ; y-coordinate
z_0:            defw    0
z_1:            defw    0
scratch_0:      defw    0
z_0_square_hi:  defw    0
z_0_square_lo:  defw    0
z_1_square_hi:  defw    0
z_1_square_lo:  defw    0

z180scmr:       defb    0                       ; original Z180 register values
z180ccrs:       defb    0
z180dcntls:     defb    0
notmsmsg:       defb    "TMS9918A not found, aborting!$"
oldsp:          defw    0                
                defs    40h
stack:

; entry point
start:          ld      (oldsp),sp              ; save old stack pointer
                ld      sp, stack               ; initailize stack

                call    z180detect              ; detect Z180
                ld      e, 0
                jp      nz, noz180              ; not detected; skip Z180 initialization
                ld      hl, mul_z180            ; use Z180 hardware multiply
                ld      (mul_function), hl
                ld      hl, z180scmr            ; save Z180 registers
                ld      c, Z180_CMR
                call    z180save
                ld      hl, z180ccrs
                ld      c, Z180_CCR
                call    z180save
                ld      hl, z180dcntls
                ld      c, Z180_DCNTL
                call    z180save
                ld      a, 1
                call    z180memwait             ; memory waits required for faster clock
                ld      a, 4                    ; io waits required for faster clock
                call    z180iowait
                call    z180clkfast             ; moar speed!
                call    z180getclk              ; get clock multiple
noz180:         call    tmssetwait              ; set VDP wait loop based on clock multiple

                call    tmsprobe                ; find what port TMS9918A listens on
                jp      nz, notms

                call    tmsbitmap
                xor     a                       ; clear pixel counters
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
                jp      m, exit           ; End of outer loop reached

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
                ld      hl, (z_1)               ; Compute DE HL = z_1 * z_1
                ld      d, h
                ld      e, l
                call    mul_16
                ld      (z_0_square_lo), hl     ; z_0 ** 2 is needed later again
                ld      (z_0_square_hi), de

                ld      hl, (z_0)               ; Compute DE HL = z_0 * z_0
                ld      d, h
                ld      e, l
                call    mul_16
                ld      (z_1_square_lo), hl     ; z_1 ** 2 will be also needed
                ld      (z_1_square_hi), de

                and     a                       ; Compute subtraction
                ld      bc, (z_0_square_lo)
                sbc     hl, bc
                ld      (scratch_0), hl         ; Save lower 16 bit of result
                ld      h, d
                ld      l, e
                ld      bc, (z_0_square_hi)
                sbc     hl, bc
                ld      bc, (scratch_0)         ; HL BC = z_0 ** 2 - z_1 ** 2

                ld      c, b                    ; Divide by scale = 256
                ld      b, l                    ; Discard the rest
                push    bc                      ; We need BC later

;        z3 = 2 * z0 * z1 / SCALE;
                ld      hl, (z_0)               ; Compute DE HL = 2 * z_0 * z_1
                add     hl, hl
                ld      de, (z_1)
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
                ld      hl, (z_0_square_lo)     ; Use the squares computed
                ld      de, (z_1_square_lo)     ; above
                add     hl, de
                ld      b, h                    ; BC contains lower word of sum
                ld      c, l

                ld      hl, (z_0_square_hi)
                ld      de, (z_1_square_hi)
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

                call    keypress
                jp      z,outer_loop
; }

exit:           ld      hl, z180scmr            ; restore Z180 registers
                ld      c, Z180_CMR
                call    z180restore
                ld      hl, z180ccrs
                ld      c, Z180_CCR
                call    z180restore
                ld      hl, z180dcntls
                ld      c, Z180_DCNTL
                call    z180restore
                ld      sp,(oldsp)              ; put stack back to how we found it
                rst     0

notms:          ld      de, notmsmsg
                call    strout
                jp      exit


mul_16:         ld      b,d                     ; d = MSB of multiplicand
                ld      c,h                     ; h = MSB of multiplier
                push    bc                      ; save sign info

                bit     7,d
                jr      z,de_positive           ; take absolute value of multiplicand

                ld      a,e
                cpl 
                ld      e,a
                ld      a,d
                cpl
                ld      d,a
                inc     de

de_positive:
                bit     7,h
                jr      z,hl_positive           ; take absolute value of multiplier

                ld      a,l
                cpl
                ld      l,a
                ld      a,h
                cpl
                ld      h,a
                inc     hl

; selectively call appropriate multiplication routine for CPU
hl_positive:
                ld      ix, (mul_function)
                jp      (ix)

mul_function:   defw    mul_z80

mul_z180:
                                                ; prepare unsigned dehl = de x hl
                ld      b,l                     ; xl
                ld      c,d                     ; yh
                ld      d,l                     ; xl
                ld      l,c
                push    hl                      ; xh yh
                ld      l,e                     ; yl

                ; bc = xl yh
                ; de = xl yl
                ; hl = xh yl
                ; stack = xh yh

                ;mlt    de                      ; xl * yl
                defb    0edh, 5ch

                ;mlt    bc                      ; xl * yh
                defb    0edh, 4ch

                ;mlt    hl                      ; xh * yl
                defb    0edh, 6ch
                
                xor     a
                add     hl,bc                   ; sum cross products
                adc     a,a                     ; collect carry

                ld      b,a                     ; carry from cross products
                ld      c,h                     ; LSB of MSW from cross products

                ld      a,d
                add     a,l
                ld      d,a                     ; de = final product LSW

                pop     hl
                ;mlt    hl                      ; xh * yh
                defb    0edh, 6ch

                adc     hl,bc                   ; hl = final product MSW
                ex      de,hl

                pop     bc                      ; recover sign info from multiplicand and multiplier
                ld      a,b
                xor     c
                ret     P                       ; return if positive product

                ld      a,l                     ; negate product and return
                cpl
                ld      l,a
                ld      a,h
                cpl
                ld      h,a
                ld      a,e
                cpl
                ld      e,a
                ld      a,d
                cpl
                ld      d,a
                inc     l
                ret     nz
                inc     h
                ret     nz
                inc     de
                ret

mul_z80:
                ; prepare unsigned dehl = de x hl
                ; multiplication of two 16-bit numbers into a 32-bit product
                ;
                ; enter : de = 16-bit multiplicand = y
                ;         hl = 16-bit multiplicand = x
                ;
                ; exit  : dehl = 32-bit product
                ;         carry reset
                ;
                ; uses  : af, bc, de, hl

                ld      b,l                     ; x0
                ld      c,e                     ; y0
                ld      e,l                     ; x0
                ld      l,d
                push    hl                      ; x1 y1
                push    bc                      ; x0 y0        
                ld      l,c                     ; y0

                ; de = y1 x0
                ; hl = x1 y0
                ; stack = x1 y1
                ; stack = x0 y0

                call    mulu_de                 ; y1*x0
                ex      de,hl
                call    mulu_de                 ; x1*y0

                xor     a                       ; zero A
                add     hl,de                   ; sum cross products p2 p1
                adc     a,a                     ; capture carry p3

                pop     de                      ; x0 y0
                ex      af,af'
                call    mulu_de                 ; y0*x0
                ex      af,af'
                ld      b,a                     ; carry from cross products
                ld      c,h                     ; LSB of MSW from cross products

                ld      a,d
                add     a,l
                ld      h,a
                ld      l,e                     ; LSW in HL p1 p0

                pop     de                      ; x1 y1
                push    bc
                ex      af,af'
                call    mulu_de                 ; x1*y1
                ex      af,af'
                pop     bc
                ex      de,hl
                adc     hl,bc
                ex      de,hl                   ; de = final MSW

                pop     bc                      ; recover sign info from multiplicand and multiplier
                ld      a,b
                xor     c
                ret     p                       ; return if positive product

                ld      a,l                     ; negate product and return
                cpl
                ld      l,a
                ld      a,h
                cpl
                ld      h,a
                ld      a,e
                cpl
                ld      e,a
                ld      a,d
                cpl
                ld      d,a
                inc     l
                ret     nz
                inc     h
                ret     nz
                inc     de
                ret

;------------------------------------------------------------------------------
;
; Fast mulu_16_8x8 using a 512 byte table
;
; x*y = ((x+y)/2)2 - ((x-y)/2)2           <- if x+y is even 
;     = ((x+y-1)/2)2 - ((x-y-1)/2)2 + y   <- if x+y is odd and x>=y
;
; enter : d = 8-bit multiplicand
;         e = 8-bit multiplicand
;
; uses  : af
;
; exit  : de = 16-bit product

mulu_de:
                ld      a,d                     ; put largest in d
                cp      e
                jr      nc,lnc
                ld      d,e
                ld      e,a

lnc:                                            ; with largest in d
                xor     a
                or      e
                jr      z,lzeroe                ; multiply by 0

                ld      b,d                     ; keep larger -> b
                ld      c,e                     ; keep smaller -> c

                ld      a,d
                sub     e
                rra
                ld      d,a                     ; (x-y)/2 -> d

                ld      a,b
                add     a,c
                rra                             ; check for odd/even

                push    hl                      ; preserve hl

                ld      l,a                     ; (x+y)/2 -> l
                ld      h,sqrlo/$100            ; loads sqrlo page
                ld      a,(hl)                  ; LSB ((x+y)/2)2 -> a
                ld      e,l                     ; (x+y)/2 -> e
                ld      l,d                     ; (x-y)/2 -> l (for index)
                jr      nc,leven
                                                ; odd tail
                sub     (hl)                    ; LSB ((x+y)/2)2 - ((x-y)/2)2
                ld      l,e                     ; (x+y)/2 -> l
                ld      e,a                     ; LSB ((x+y)/2)2 - ((x-y)/2)2 -> e
                inc     h                       ; loads sqrhi page
                ld      a,(hl)                  ; MSB ((x+y)/2)2 -> a
                ld      l,d                     ; (x-y)/2 -> l
                sbc     a,(hl)                  ; MSB ((x+y)/2)2 - ((x-y)/2)2 -> a
                ld      d,a                     ; MSB ((x+y)/2)2 - ((x-y)/2)2 -> d

                ld      a,e
                add     a,c                     ; add smaller y
                ld      e,a
                ld      a,d
                adc     a,0
                ld      d,a

                pop     hl
                ret

leven:                                          ; even tail
                sub     (hl)                    ; LSB ((x+y)/2)2 - ((x-y)/2)2
                ld      l,e                     ; (x+y)/2 -> l
                ld      e,a                     ; LSB ((x+y)/2)2 - ((x-y)/2)2 -> e
                inc     h                       ; loads sqrhi page
                ld      a,(hl)                  ; MSB ((x+y)/2)2 -> a
                ld      l,d                     ; (x-y)/2 -> l
                sbc     a,(hl)                  ; MSB ((x+y)/2)2 - ((x-y)/2)2 -> a
                ld      d,a                     ; MSB ((x+y)/2)2 - ((x-y)/2)2 -> d

                pop     hl
                ret

lzeroe:
                ld      d,e
                ret

                defs    (($ & $FF00) + $100) - $   ; page align

sqrlo:          ; low(x*x) should located on the page border
                defb    $00,$01,$04,$09,$10,$19,$24,$31,$40,$51,$64,$79,$90,$a9,$c4,$e1
                defb    $00,$21,$44,$69,$90,$b9,$e4,$11,$40,$71,$a4,$d9,$10,$49,$84,$c1
                defb    $00,$41,$84,$c9,$10,$59,$a4,$f1,$40,$91,$e4,$39,$90,$e9,$44,$a1
                defb    $00,$61,$c4,$29,$90,$f9,$64,$d1,$40,$b1,$24,$99,$10,$89,$04,$81
                defb    $00,$81,$04,$89,$10,$99,$24,$b1,$40,$d1,$64,$f9,$90,$29,$c4,$61
                defb    $00,$a1,$44,$e9,$90,$39,$e4,$91,$40,$f1,$a4,$59,$10,$c9,$84,$41
                defb    $00,$c1,$84,$49,$10,$d9,$a4,$71,$40,$11,$e4,$b9,$90,$69,$44,$21
                defb    $00,$e1,$c4,$a9,$90,$79,$64,$51,$40,$31,$24,$19,$10,$09,$04,$01
                defb    $00,$01,$04,$09,$10,$19,$24,$31,$40,$51,$64,$79,$90,$a9,$c4,$e1
                defb    $00,$21,$44,$69,$90,$b9,$e4,$11,$40,$71,$a4,$d9,$10,$49,$84,$c1
                defb    $00,$41,$84,$c9,$10,$59,$a4,$f1,$40,$91,$e4,$39,$90,$e9,$44,$a1
                defb    $00,$61,$c4,$29,$90,$f9,$64,$d1,$40,$b1,$24,$99,$10,$89,$04,$81
                defb    $00,$81,$04,$89,$10,$99,$24,$b1,$40,$d1,$64,$f9,$90,$29,$c4,$61
                defb    $00,$a1,$44,$e9,$90,$39,$e4,$91,$40,$f1,$a4,$59,$10,$c9,$84,$41
                defb    $00,$c1,$84,$49,$10,$d9,$a4,$71,$40,$11,$e4,$b9,$90,$69,$44,$21
                defb    $00,$e1,$c4,$a9,$90,$79,$64,$51,$40,$31,$24,$19,$10,$09,$04,$01
sqrhi:          ; high(x*x) located on next page (automatically)
                defb    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                defb    $01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$03,$03,$03
                defb    $04,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$07,$07,$07,$08,$08
                defb    $09,$09,$09,$0a,$0a,$0a,$0b,$0b,$0c,$0c,$0d,$0d,$0e,$0e,$0f,$0f
                defb    $10,$10,$11,$11,$12,$12,$13,$13,$14,$14,$15,$15,$16,$17,$17,$18
                defb    $19,$19,$1a,$1a,$1b,$1c,$1c,$1d,$1e,$1e,$1f,$20,$21,$21,$22,$23
                defb    $24,$24,$25,$26,$27,$27,$28,$29,$2a,$2b,$2b,$2c,$2d,$2e,$2f,$30
                defb    $31,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f
                defb    $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4a,$4b,$4c,$4d,$4e,$4f
                defb    $51,$52,$53,$54,$55,$56,$57,$59,$5a,$5b,$5c,$5d,$5f,$60,$61,$62
                defb    $64,$65,$66,$67,$69,$6a,$6b,$6c,$6e,$6f,$70,$72,$73,$74,$76,$77
                defb    $79,$7a,$7b,$7d,$7e,$7f,$81,$82,$84,$85,$87,$88,$8a,$8b,$8d,$8e
                defb    $90,$91,$93,$94,$96,$97,$99,$9a,$9c,$9d,$9f,$a0,$a2,$a4,$a5,$a7
                defb    $a9,$aa,$ac,$ad,$af,$b1,$b2,$b4,$b6,$b7,$b9,$bb,$bd,$be,$c0,$c2
                defb    $c4,$c5,$c7,$c9,$cb,$cc,$ce,$d0,$d2,$d4,$d5,$d7,$d9,$db,$dd,$df
                defb    $e1,$e2,$e4,$e6,$e8,$ea,$ec,$ee,$f0,$f2,$f4,$f6,$f8,$fa,$fc,$fe

; working area for 8 pixels at a time
primary:        defb    0                       ; primary color
secondary:      defb    0                       ; secondary color
pattern:        defb    0                       ; color bit pattern
bitindex:       defb    0                       ; current bit within byte
xypos:          defw    0                       ; current x, y position on the screen

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
                call    tmsramout

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
                call    tmsramout

                ld      hl, (xypos)             ; increase next x/y position by 8 pixels
                ld      de, 8
                add     hl, de
                ld      (xypos), hl
                ret