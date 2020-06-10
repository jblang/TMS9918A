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

        ld      hl, grid1                       ; init variables
        ld      (CurrGrid), hl
        ld      hl, grid2
        ld      (NextGrid), hl
        ld      ix, 3                           ; divide by 3 counter

        ld      de, 0                           ; clear frame counter
MainLoop:
        ld      hl, (NextGrid)                  ; init cell pointer
        ld      c, GridHeight                   ; init row counter
XLoop:
        ld      b, GridWidth                    ; init column counter
YLoop:
        ; this can be any of these: LooseWave, TightWave, Gradient, or Munching
        call    TightWave                       ; calculate current cell
        and     7fh
        ld      (hl), a                         ; save cell in buffer
        inc     hl                              ; cell pointer
        djnz    YLoop                           ; next column
        dec     c                               ; next row
        jp      nz, XLoop
        inc     d                               ; frame counter
        dec     ix
        jp      nz, FlipBuffers
        ld      ix, 3
        inc     e                               ; frame/3 counter
FlipBuffers:
        ld      bc, (NextGrid)                  ; swap buffer pointers
        ld      hl, (CurrGrid)
        ld      (CurrGrid), bc
        ld      (NextGrid), hl

WaitVsync:
        call    TmsRegIn
        and     80h
        jr      z, WaitVsync

        push    de
        ld      hl, (CurrGrid)                  ; copy current data into name table
        ld      de, (TmsNameAddr)
        ld      bc, GridSize
        call    TmsWrite
        pop     de

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

Gradient:                                       ; Diagonal Gradient
        ld      a, b                            ; x
        add     a, c                            ; x + y
        sub     d                               ; x + y - time
        ret

Munching:                                       ; Munching squares
        ld      a, b                            ; x
        dec     a                               ; x - 1
        xor     c                               ; (x - 1) xor y
        add     a, d                            ; ((x - 1) xor y) + time
        ret

LooseWave:                                      ; Plasma
        push    hl
        ld      h, SinTable >> 8
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

TightWave:                                      ; Plasma
        push    hl
        push    bc
        ld      h, SinTable >> 8
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

        include "tms.asm"
        include "z180.asm"
        include "utility.asm"

CurrGrid:
        defw 0                                  ; pointers to grid buffers
NextGrid:
        defw 0

grid1:  defs    GridSize                        ; grid buffers
grid2:  defs    GridSize

SaveCMR:
        defb    0                               ; original Z180 register values
SaveCCR:
        defb    0
SaveDCNTL:
        defb    0

OldSP:  defw    0                
        defs    40h
Stack:

; Rainbow colors
Colors: defb    098h,098h
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
PatternLen: equ $ - Patterns

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