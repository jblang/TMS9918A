; Plasma Effect for TMS9918
; 
; Based on 6809 Plasma Code by Matt Sarnoff (msarnoff.org)
; Ported to Z80 by J.B. Langston
;
; Original source: https://github.com/74hc595/Ultim809/blob/master/code/user/plasma/plasma.asm

sptab:  equ 0h
ptab:   equ 800h
satab:  equ 1000h
ntab:   equ 1400h
ctab:   equ 2000h

gridw:  equ 32                                  ; grid width
gridh:  equ 24                                  ; grid height
grids:  equ gridw*gridh                         ; grid size
ncolor: equ 8                                   ; number of colors

        org 100h

        jp start

        include "tms.asm"
        include "z180.asm"
        include "utility.asm"

cgrid:  defw 0                                  ; pointers to grid buffers
ngrid:  defw 0

grid1:  defs    grids                           ; grid buffers
grid2:  defs    grids

cmrs:   defb    0                               ; original Z180 register values
ccrs:   defb    0
dcntls: defb    0

oldsp:  defw    0                
        defs    40h
stack:
start:
        ld      (oldsp), sp
        ld      sp, stack
        call    z180detect                      ; detect Z180
        ld      e, 0
        jp      nz, noz180                      ; not detected; skip Z180 initialization
        ld      hl, cmrs                        ; save Z180 registers
        ld      c, Z180_CMR
        call    z180save
        ld      hl, ccrs
        ld      c, Z180_CCR
        call    z180save
        ld      hl, dcntls
        ld      c, Z180_DCNTL
        call    z180save
        ld      a, 1
        call    z180memwait                     ; memory waits required for faster clock
        ld      a, 3                            ; io waits required for faster clock
        call    z180iowait
        call    z180clkfast                     ; moar speed!
        call    z180getclk                      ; get clock multiple
noz180:
        call    tmssetwait                      ; set VDP wait loop based on clock multiple

        call    tmsprobe                        ; find what port TMS9918A listens on
        jp      z, notms


        call    tmstile
        
        ld      de, ptab                        ; load pattern table
        ld      b, ncolor                       ; (one copy for each color)
patloop:
        push    bc
        ld      hl, patterns
        ld      bc, patlen
        call    tmswrite
        pop     bc
        ex      de, hl
        ld      de, patlen
        add     hl, de
        ex      de, hl
        djnz    patloop

        ld      hl, colors                      ; load color table
        ld      de, ctab
        ld      bc, colorlen
        call    tmswrite

        ld      hl, grid1                       ; init variables
        ld      (cgrid), hl
        ld      hl, grid2
        ld      (ngrid), hl
        ld      ix, 3                           ; divide by 3 counter

        ld      de, 0                           ; clear frame counter
mainloop:
        ld      hl, (ngrid)                     ; init cell pointer
        ld      c, gridh                        ; init row counter
yloop:
        ld      b, gridw                        ; init column counter
xloop:
        ; this can be any of these: wave, wave2, gradient, or munching
        call    wave2                           ; calculate current cell
        and     7fh
        ld      (hl), a                         ; save cell in buffer
        inc     hl                              ; cell pointer
        djnz    xloop                           ; next column
        dec     c                               ; next row
        jp      nz, yloop
        inc     d                               ; frame counter
        dec     ix
        jp      nz, flipbuffers
        ld      ix, 3
        inc     e                               ; frame/3 counter
flipbuffers:
        ld      bc, (ngrid)                     ; swap buffer pointers
        ld      hl, (cgrid)
        ld      (cgrid), bc
        ld      (ngrid), hl

vsync:
        call    tmsregin
        and     80h
        jr      z, vsync

        push    de
        ld      hl, (cgrid)                     ; copy current data into name table
        ld      de, ntab
        ld      bc, grids
        call    tmswrite
        pop     de

        call    keypress
        jp      z, mainloop

exit:   ld      hl, cmrs                        ; restore Z180 registers
        ld      c, Z180_CMR
        call    z180restore
        ld      hl, ccrs
        ld      c, Z180_CCR
        call    z180restore
        ld      hl, dcntls
        ld      c, Z180_DCNTL
        call    z180restore
        ld      sp, (oldsp)                     ; put stack back to how we found it
        rst     0

notmsmsg:
        defb    "TMS9918A not found, aborting!$"
notms:  ld      de, notmsmsg
        call    strout
        jp      exit

gradient:                                       ; diagonal gradient
        ld      a, b                            ; x
        add     a, c                            ; x + y
        sub     d                               ; x + y - time
        ret

munching:                                       ; munching squares
        ld      a, b                            ; x
        dec     a                               ; x - 1
        xor     c                               ; (x - 1) xor y
        add     a, d                            ; ((x - 1) xor y) + time
        ret

wave:                                           ; plasma 1
        push    hl
        ld      h, sin8 >> 8
        ld      a, b                            ; x
        add     a, d                            ; x + time
        ld      l, a
        ld      a, (hl)                         ; sin(x + time)
        add     a, c                            ; sin(x + time) + y
        sub     d                               ; sin(x + time) + y - time
        ld      l, a
        ld      a, (hl)                         ; sin(sin(x + time) + y - time)
        pop     hl
        ret

wave2:                                          ; plasma 2
        push    hl
        push    bc
        ld      h, sin8 >> 8
        ld      a, b                            ; x
        add     a, e                            ; x + time/3
        ld      l, a
        ld      a, (hl)                         ; sin(x + time/3)
        add     a, d                            ; sin(X + time/3) + time
        ld      l, a
        ld      b, (hl)                         ; sin(sin(X + time/3) + time)
        ld      a, c                            ; y
        add     a, d                            ; y + time
        ld      l, a
        ld      a, (hl)                         ; sin(y + time)
        add     a, e                            ; sin(y + time) + time/3
        ld      l, a
        ld      a, (hl)                         ; sin(sin(y + time) + time/3)
        add     a, b                            ; sin(sin(y + time) + time/3) + sin(sin(X + time/3) + time)
        pop     bc
        pop     hl
        ret

; color table

colors: defb    098h,098h
        defb    0B9h,0B9h
        defb    03Bh,03Bh
        defb    073h,073h
        defb    057h,057h
        defb    045h,045h
        defb    0D4h,0D4h
        defb    08Dh,08Dh
colorlen: equ $ - colors

; pattern table

patterns:
; tile (0,0)-(7,7)
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
; tile (8,0)-(15,7)
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00010000b
        defb    00000000b
        defb    00000000b
; tile (16,0)-(23,7)
        defb    00000000b
        defb    00000001b
        defb    10010000b
        defb    00001000b
        defb    00000010b
        defb    10000000b
        defb    00010000b
        defb    00000010b
; tile (24,0)-(31,7)
        defb    00000000b
        defb    00101010b
        defb    00000000b
        defb    01001001b
        defb    00010000b
        defb    10000100b
        defb    00100000b
        defb    00010010b
; tile (32,0)-(39,7)
        defb    00100001b
        defb    01001010b
        defb    00100001b
        defb    00010100b
        defb    01100000b
        defb    10101001b
        defb    01000100b
        defb    00010010b
; tile (40,0)-(47,7)
        defb    00100100b
        defb    10010010b
        defb    01001010b
        defb    01010100b
        defb    10001010b
        defb    00010010b
        defb    10101010b
        defb    10010000b
; tile (48,0)-(55,7)
        defb    10101010b
        defb    01001001b
        defb    01010101b
        defb    10010010b
        defb    01010101b
        defb    10101010b
        defb    01001010b
        defb    01010101b
; tile (56,0)-(63,7)
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
; tile (64,0)-(71,7)
        defb    10101010b
        defb    01101101b
        defb    10101011b
        defb    10101010b
        defb    11010010b
        defb    10101010b
        defb    01101101b
        defb    01010101b
; tile (72,0)-(79,7)
        defb    11011011b
        defb    01101010b
        defb    10111011b
        defb    01010110b
        defb    10101001b
        defb    01010111b
        defb    11111010b
        defb    01010110b
; tile (80,0)-(87,7)
        defb    10111101b
        defb    11010111b
        defb    01111010b
        defb    10101111b
        defb    11101010b
        defb    10111110b
        defb    11010101b
        defb    11011101b
; tile (88,0)-(95,7)
        defb    11111111b
        defb    01010101b
        defb    11111111b
        defb    10101010b
        defb    11111111b
        defb    11010101b
        defb    10111111b
        defb    11101011b
; tile (96,0)-(103,7)
        defb    11111111b
        defb    01101101b
        defb    11111111b
        defb    11011011b
        defb    10111111b
        defb    11101101b
        defb    01111111b
        defb    11101101b
; tile (104,0)-(111,7)
        defb    11111111b
        defb    11111111b
        defb    01101111b
        defb    11110110b
        defb    11111111b
        defb    01111111b
        defb    11101101b
        defb    11111111b
; tile (112,0)-(119,7)
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11101111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
; tile (120,0)-(127,7)
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
patlen: equ $ - patterns

; sine table
        defs    (($ & 0FF00h) + 100h) - $       ; page align
sin8:
        defb    0,3,6,9,12,15,18,21,24,27,30,34,37,39
        defb    42,45,48,51,54,57,60,62,65,68,70,73,75
        defb    78,80,83,85,87,90,92,94,96,98,100,102
        defb    104,106,107,109,110,112,113,115,116,117
        defb    118,120,121,122,122,123,124,125,125,126
        defb    126,126,127,127,127,127,127,127,127,126
        defb    126,126,125,125,124,123,122,122,121,120
        defb    118,117,116,115,113,112,110,109,107,106
        defb    104,102,100,98,96,94,92,90,87,85,83,80
        defb    78,75,73,70,68,65,62,60,57,54,51,48,45
        defb    42,39,37,34,30,27,24,21,18,15,12,9,6,3
        defb    -4,-7,-10,-13,-16,-19,-22,-25,-28,-31
        defb    -35,-38,-40,-43,-46,-49,-52,-55,-58,-61
        defb    -63,-66,-69,-71,-74,-76,-79,-81,-84,-86
        defb    -88,-91,-93,-95,-97,-99,-101,-103,-105
        defb    -107,-108,-110,-111,-113,-114,-116,-117
        defb    -118,-119,-121,-122,-123,-123,-124,-125
        defb    -126,-126,-127,-127,-127,-128,-128,-128
        defb    -128,-128,-128,-128,-127,-127,-127,-126
        defb    -126,-125,-124,-123,-123,-122,-121,-119
        defb    -118,-117,-116,-114,-113,-111,-110,-108
        defb    -107,-105,-103,-101,-99,-97,-95,-93,-91
        defb    -88,-86,-84,-81,-79,-76,-74,-71,-69,-66
        defb    -63,-61,-58,-55,-52,-49,-46,-43,-40,-38
        defb    -35,-31,-28,-25,-22,-19,-16,-13,-10,-7,-4,-1