; Plasma Effect for TMS9918
; 
; Based on 6809 Plasma Code by Matt Sarnoff (msarnoff.org)
; Ported to Z80 by J.B. Langston
;
; Original source: https://github.com/74hc595/Ultim809/blob/master/code/user/plasma/plasma.asm

GridWidth:  equ 32                              ; grid width
GridHeight:  equ 24                             ; grid height
GridSize:  equ GridWidth*GridHeight             ; grid size
NumColors: equ 8                                ; number of Colors

        org 100h

        ld      (OldSP), sp
        ld      sp, Stack
        call    z180detect                      ; detect Z180
        ld      e, 0
        jp      nz, NoZ180                      ; not detected; skip Z180 initialization
        ld      hl, SaveCMR                     ; save Z180 registers
        ld      c, Z180_CMR
        call    z180save
        ld      hl, SaveCCR
        ld      c, Z180_CCR
        call    z180save
        ld      hl, SaveDCNTL
        ld      c, Z180_DCNTL
        call    z180save
        ld      a, 1
        call    z180memwait                     ; memory waits required for faster clock
        ld      a, 3                            ; io waits required for faster clock
        call    z180iowait
        call    z180clkfast                     ; moar speed!
        call    z180getclk                      ; get clock multiple
NoZ180:
        call    TmsSetWait                      ; set VDP wait loop based on clock multiple

        call    TmsProbe                        ; find what port TMS9918A listens on
        jp      z, NoTms

        call    TmsTile
        
        ld      de, (TmsPatternAddr)            ; load pattern table
        ld      b, NumColors                    ; (one copy for each color)
PatternLoop:
        push    bc
        ld      hl, Patterns
        ld      bc, PatternLen
        call    TmsWrite
        pop     bc
        ex      de, hl
        ld      de, PatternLen
        add     hl, de
        ex      de, hl
        djnz    PatternLoop

        ld      hl, Colors                      ; load color table
        ld      de, (TmsColorAddr)
        ld      bc, ColorLen
        call    TmsWrite

        exx
        ld      ix, 3                           ; divide by 3 counter
        ld      de, 0                           ; clear frame counter
        ld      h, SinTable >> 8
        exx
MainLoop:
        ld      hl, Grid
        ld      c, GridHeight
        call    TightWave
        
        exx
        inc     d                               ; frame counter
        dec     ix
        jp      nz, SkipE
        ld      ix, 3
        inc     e                               ; frame/3 counter
SkipE:
        exx

WaitVsync:
        call    TmsRegIn
        and     80h
        jr      z, WaitVsync

        ld      hl, Grid                        ; copy current data into name table
        ld      de, (TmsNameAddr)
        ld      bc, GridSize
        call    TmsWrite

        call    keypress
        jp      z, MainLoop

Exit:   ld      hl, SaveCMR                     ; restore Z180 registers
        ld      c, Z180_CMR
        call    z180restore
        ld      hl, SaveCCR
        ld      c, Z180_CCR
        call    z180restore
        ld      hl, SaveDCNTL
        ld      c, Z180_DCNTL
        call    z180restore
        ld      sp, (OldSP)                     ; put Stack back to how we found it
        rst     0

NoTmsMessage:
        defb    "TMS9918A not found, aborting!$"
NoTms:  ld      de, NoTmsMessage
        call    strout
        jp      Exit

; sine table
        defs    (($ & 0FF00h) + 100h) - $       ; page align
SinTable:
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
        
Gradient:                                       ; Diagonal Gradient
        ld      b, GridWidth
GradX:
        ld      a, b                            ; x
        add     a, c                            ; x + y
        exx
        sub     d                               ; x + y - time
        exx
        and     7fh
        ld      (hl), a                         ; save cell in buffer
        inc     hl                              ; cell pointer
        djnz    GradX
        dec     c
        jp      nz, Gradient
        ret

Munching:                                       ; Munching squares
        ld      b, GridWidth
MunchX:
        ld      a, b                            ; x
        dec     a                               ; x - 1
        xor     c                               ; (x - 1) xor y
        exx
        add     a, d                            ; ((x - 1) xor y) + time
        exx
        and     7fh
        ld      (hl), a                         ; save cell in buffer
        inc     hl                              ; cell pointer
        djnz    MunchX
        dec     c
        jp      nz, Munching
        ret

LooseWave:                                      ; Plasma
        ld      a, c                            ; y
        exx
        add     a, d                            ; y + time
        ld      l, a
        ld      c, (hl)                         ; sin(y + time)
        exx
        ld      b, GridWidth
LooseX:
        ld      a, b                            ; x
        exx
        sub     d                               ; x - time
        add     a, c                            ; sin(y + time) + x - time
        ld      l, a
        ld      a, (hl)                         ; sin(sin(y + time) + x - time)
        exx
        and     7fh
        ld      (hl), a                         ; save cell in grid buffer
        inc     hl
        djnz    LooseX
        dec     c
        jp      nz, LooseWave
        ret

TightWave:                                      ; Plasma
        ld      a, c                            ; y
        exx
        add     a, d                            ; y + time
        ld      l, a
        ld      a, (hl)                         ; sin(y + time)
        add     a, e                            ; sin(y + time) + time/3
        ld      l, a
        ld      c, (hl)                         ; sin(sin(y + time) + time/3)
        exx
        ld      b, GridWidth                    ; column counter
TightX:
        ld      a, b                            ; x
        exx
        add     a, e                            ; x + time/3
        ld      l, a
        ld      a, (hl)                         ; sin(x + time/3)
        add     a, d                            ; sin(x + time/3) + time
        ld      l, a
        ld      a, (hl)                         ; sin(sin(x + time/3) + time)
        add     a, c                            ; sin(sin(x + time/3) + time) + sin(sin(y + time) + time/3)
        and     7fh
        exx
        ld      (hl), a                         ; save cell in grid buffer
        inc     hl
        djnz    TightX                          ; next column
        dec     c
        jp      nz, TightWave
        ret

        include "tms.asm"
        include "z180.asm"
        include "utility.asm"

Grid:   defs    GridSize                        ; grid buffers

SaveCMR:
        defb    0                               ; original Z180 register values
SaveCCR:
        defb    0
SaveDCNTL:
        defb    0

OldSP:  defw    0                
        defs    40h
Stack:

colorPalettes:
Pal00:  defb $01,#01,$0e,#0e,$0f
Pal01:  defb $01,$01,$01,$0c,$0c
Pal02:  defb $03,$07,$05,$0d,$06
Pal03:  defb #06,$06,$0d,#01,$04
Pal04:  defb $04,#01,$0a,$06,$06
Pal05:  defb $09,$0e,$05,$0c,$0c
Pal06:  defb $04,#01,$0a,$09,$0b
Pal07:  defb $03,$07,$0e,$0a,$06
Pal08:  defb $0f,$07,$05,$0d,$06
Pal09:  defb $03,$0c,#01,$0d,$09
Pal0a:  defb $07,$05,#01,$0a,$09
Pal0b:  defb $09,$0d,$04,$05,$07
Pal0c:  defb $09,$0a,#06,#01,$05

; black/black/grey/grey/white
        defb    011h,011h
        defb    0e1h,0e1h
        defb    0eeh,0eeh
        defb    0feh,0feh
        defb    0efh,0efh
        defb    0eeh,0eeh
        defb    01eh,01eh
        defb    011h,011h

; black/black/black/dark green/dark green
        defb    011h,011h
        defb    011h,011h
        defb    0c1h,0c1h
        defb    0cch,0cch
        defb    0cch,0cch
        defb    01ch,01ch
        defb    011h,011h
        defb    011h,011h

; light green/cyan/light blue/purple/dark red
        defb    073h,073h
        defb    057h,057h
        defb    0d5h,0d5h
        defb    06dh,06dh
        defb    0d6h,0d6h
        defb    05dh,05dh
        defb    075h,075h
        defb    037h,037h

Colors:
; white/cyan/light blue/purple/dark red
        defb    07fh,07fh
        defb    057h,057h
        defb    0d5h,0d5h
        defb    06dh,06dh
        defb    0d6h,0d6h
        defb    05dh,05dh
        defb    075h,075h
        defb    0f7h,0f7h

; dark red/dark red/purple/black/dark blue
        defb    066h,066h
        defb    0d6h,0d6h
        defb    01dh,01dh
        defb    041h,041h
        defb    014h,014h
        defb    0d1h,0d1h
        defb    06dh,06dh
        defb    066h,066h

; dark blue/black/dark yellow/dark red/dark read
        defb    014h,014h
        defb    0a1h,0a1h
        defb    06ah,06ah
        defb    066h,066h
        defb    066h,066h
        defb    0a6h,0a6h
        defb    01ah,01ah
        defb    041h,041h

; orange/grey/light blue/dark green/dark green
        defb    0e9h,0e9h
        defb    05eh,05eh
        defb    0c5h,0c5h
        defb    0cch,0cch
        defb    0cch,0cch
        defb    05ch,05ch
        defb    0e5h,0e5h
        defb    09eh,09eh

; dark blue/black/dark yellow/orange/light yellow
        defb    014h,014h
        defb    0a1h,0a1h
        defb    09ah,09ah
        defb    0b9h,0b9h
        defb    09bh,09bh
        defb    0a9h,0a9h
        defb    01ah,01ah
        defb    041h,041h

; light green/cyan/grey/dark yellow/dark red
        defb    073h,073h
        defb    0e7h,0e7h
        defb    0aeh,0aeh
        defb    06ah,06ah
        defb    0a6h,0a6h
        defb    0eah,0eah
        defb    07eh,07eh
        defb    037h,037h

; light green/dark green/black/purple/orange
        defb    0c3h,0c3h
        defb    01ch,01ch
        defb    0d1h,0d1h
        defb    09dh,09dh
        defb    0d9h,0d9h
        defb    01dh,01dh
        defb    0c1h,0c1h
        defb    03ch,03ch

; cyan/light blue/black/yellow/orange
        defb    057h,057h
        defb    015h,015h
        defb    0a1h,0a1h
        defb    09ah,09ah
        defb    0a9h,0a9h
        defb    01ah,01ah
        defb    051h,051h
        defb    075h,075h

; orange/purple/dark blue/light blue/cyan
        defb    0d9h,0d9h
        defb    04dh,04dh
        defb    054h,054h
        defb    075h,075h
        defb    057h,057h
        defb    045h,045h
        defb    0d4h,0d4h
        defb    09dh,09dh

; orange/dark yellow/dark red/black/light blue
        defb    0a9h,0a9h
        defb    06ah,06ah
        defb    016h,016h
        defb    051h,051h
        defb    015h,015h
        defb    061h,061h
        defb    0a6h,0a6h
        defb    09ah,09ah


; Rainbow colors
        defb    098h,098h
        defb    0B9h,0B9h
        defb    03Bh,03Bh
        defb    073h,073h
        defb    057h,057h
        defb    045h,045h
        defb    0D4h,0D4h
        defb    08Dh,08Dh
ColorLen: equ $ - Colors

; Dithering patterns
Patterns:
; tile (0,0)-(7,7)
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b

        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00010000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b

        defb    01000000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00000100b
        defb    00000000b
        defb    00000000b
        defb    00000000b

        defb    10001000b
        defb    00000000b
        defb    00000000b
        defb    00000000b
        defb    00100010b
        defb    00000000b
        defb    00000000b
        defb    00000000b

        defb    10001000b
        defb    00000000b
        defb    00010000b
        defb    00000000b
        defb    00000000b
        defb    00100010b
        defb    00000000b
        defb    00000000b

        defb    10001000b
        defb    00000000b
        defb    00100010b
        defb    00000000b
        defb    01000100b
        defb    00000000b
        defb    00010001b
        defb    00000000b

        defb    10101010b
        defb    00000000b
        defb    01010101b
        defb    00000000b
        defb    10101010b
        defb    00000000b
        defb    01010101b
        defb    00000000b

        defb    10101010b
        defb    01000100b
        defb    10101010b
        defb    00010001b
        defb    10101010b
        defb    01000100b
        defb    10101010b
        defb    00010001b

        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b

        defb    01010101b
        defb    10111011b
        defb    01010101b
        defb    11101110b
        defb    01010101b
        defb    10111011b
        defb    01010101b
        defb    11101110b

        defb    01010101b
        defb    11111111b
        defb    10101010b
        defb    11111111b
        defb    01010101b
        defb    11111111b
        defb    10101010b
        defb    11111111b

        defb    01110111b
        defb    11111111b
        defb    11011101b
        defb    11111111b
        defb    10111011b
        defb    11111111b
        defb    11101110b
        defb    11111111b

        defb    01110111b
        defb    11111111b
        defb    11101111b
        defb    11111111b
        defb    11011101b
        defb    11111111b
        defb    11111111b
        defb    11111111b

        defb    01110111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11011101b
        defb    11111111b
        defb    11111111b
        defb    11111111b

        defb    01111111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11111101b
        defb    11111111b
        defb    11111111b
        defb    11111111b

        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11110111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11111111b
PatternLen: equ $ - Patterns