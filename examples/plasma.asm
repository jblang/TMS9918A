; Plasma Effect for TMS9918
; 
; Based on 6809 Plasma Code by Matt Sarnoff (msarnoff.org)
; Ported to Z80 by J.B. Langston
;
; Original source: https://github.com/74hc595/Ultim809/blob/master/code/user/plasma/plasma.asm

ScreenWidth:    equ 32
ScreenHeight:   equ 24
ScreenSize:     equ ScreenWidth*ScreenHeight
NumColors:      equ 8

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
        call    LoadPatternTable
        call    LoadColorTable        
        exx
        ld      ix, 3                           ; divide by 3 counter
        ld      de, 0                           ; clear frame counter
        ld      h, SinTable >> 8
        exx
MainLoop:
        ld      hl, ScreenBuffer
        ld      c, ScreenHeight
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

        ld      hl, ScreenBuffer                        ; copy current data into name table
        ld      de, (TmsNameAddr)
        ld      bc, ScreenSize
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

LoadPatternTable:
        ld      de, (TmsPatternAddr)
        call    TmsWriteAddr
        ld      b, PatternRepeats
PatternRepeatLoop:
        ld      hl, Patterns
        ld      de, PatternLen
PatternLoop:
        ld      a, (hl)
        call    TmsRamOut
        inc     hl
        dec     de
        ld      a, d
        or      e
        jp      nz, PatternLoop
        djnz    PatternRepeatLoop
        ret

LoadColorTable:
        ld      de, (TmsColorAddr)
        call    TmsWriteAddr
        ld      hl, (ColorPalette)
        ld      d, 0

ColorUpLoop:
        ld      c, (hl)
        inc     hl
        ld      a, (hl)
        or      a
        jp      z, ColorDown
        cp      $10
        jp      z, WrapFirstColor
        call    AddColors
        inc     d
        jp      ColorUpLoop

ColorDown:
        dec     hl
ColorDownLoop:
        ld      c, (hl)
        dec     hl
        ld      a, (hl)
        call    AddColors
        dec     d
        jp      nz, ColorDownLoop

WrapFirstColor:
        dec     hl
        ld      c, (hl)
        ld      hl, (ColorPalette)
        ld      a, (hl)

AddColors:
        add     a, a
        add     a, a
        add     a, a
        add     a, a
        or      c
        ld      b, ColorRepeats
AddColorLoop:
        call    TmsRamOut
        djnz    AddColorLoop
        ret
        
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
        ld      b, ScreenWidth
GradX:
        ld      a, b                            ; x
        add     a, c                            ; x + y
        exx
        sub     d                               ; x + y - time
        exx
        ld      (hl), a                         ; save cell in buffer
        inc     hl                              ; cell pointer
        djnz    GradX
        dec     c
        jp      nz, Gradient
        ret

Munching:                                       ; Munching squares
        ld      b, ScreenWidth
MunchX:
        ld      a, b                            ; x
        dec     a                               ; x - 1
        xor     c                               ; (x - 1) xor y
        exx
        add     a, d                            ; ((x - 1) xor y) + time
        exx
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
        ld      b, ScreenWidth
LooseX:
        ld      a, b                            ; x
        exx
        sub     d                               ; x - time
        add     a, c                            ; sin(y + time) + x - time
        ld      l, a
        ld      a, (hl)                         ; sin(sin(y + time) + x - time)
        exx
        ld      (hl), a                         ; save cell in screen buffer
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
        ld      b, ScreenWidth                    ; column counter
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
        exx
        ld      (hl), a                         ; save cell in screen buffer
        inc     hl
        djnz    TightX                          ; next column
        dec     c
        jp      nz, TightWave
        ret

        include "tms.asm"
        include "z180.asm"
        include "utility.asm"

ScreenBuffer:
        defs    ScreenSize

; original Z180 register values
SaveCMR:
        defb    0
SaveCCR:
        defb    0
SaveDCNTL:
        defb    0

OldSP:  defw    0                
        defs    40h
Stack:

; VIC-II to TMS9918 color mappings
; compromises with no direct mapping are marked with #
; vic:  $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f
; tms:  $01,$0f,$06,$07,$0d,$0c,$04,$0b,$0a,#0A,#09,#01,$0e,$03,$05,#0E

ColorPalette:   defw    Pal0d

; palettes pre-mapped from vic to tms
ColorPalettes:
Pal00:  defb    $01,#01,$0e,#0e,$0f,$00
Pal01:  defb    $01,$01,$01,$0c,$0c,$00
Pal02:  defb    $03,$07,$05,$0d,$06,$00
Pal03:  defb    #06,$06,$0d,#01,$04,$00
Pal04:  defb    $04,#01,$0a,$06,$06,$00
Pal05:  defb    $09,$0e,$05,$0c,$0c,$00
Pal06:  defb    $04,#01,$0a,$09,$0b,$00
Pal07:  defb    $03,$07,$0e,$0a,$06,$00
Pal08:  defb    $0f,$07,$05,$0d,$06,$00
Pal09:  defb    $03,$0c,#01,$0d,$09,$00
Pal0a:  defb    $07,$05,#01,$0a,$09,$00
Pal0b:  defb    $09,$0d,$04,$05,$07,$00
Pal0c:  defb    $09,$0a,#06,#01,$05,$00
Pal0d:  defb    $08,$09,$0b,$03,$07,$05,$04,$0d,$10

; gradient patterns
Patterns:
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
        defb    01000000b
        defb    00000000b
        defb    00000100b
        defb    00000000b

        defb    00000000b
        defb    00000010b
        defb    00010000b
        defb    00000000b
        defb    01000000b
        defb    00000000b
        defb    00000100b
        defb    00100000b

        defb    01000000b
        defb    00000010b
        defb    00010000b
        defb    00000010b
        defb    01000000b
        defb    00000000b
        defb    00000100b
        defb    00100000b

        defb    01000000b
        defb    00000010b
        defb    00010000b
        defb    00000010b
        defb    01000000b
        defb    00001000b
        defb    00000101b
        defb    00100000b

        defb    01000000b
        defb    00000010b
        defb    00010000b
        defb    00001010b
        defb    01000000b
        defb    10001000b
        defb    00000101b
        defb    00100000b

        defb    01000100b
        defb    00000010b
        defb    00010000b
        defb    00001010b
        defb    01000001b
        defb    10001000b
        defb    00000101b
        defb    00100000b

        defb    01000100b
        defb    00000010b
        defb    01010000b
        defb    00001010b
        defb    01000001b
        defb    10101000b
        defb    00000101b
        defb    00100000b

        defb    01000100b
        defb    10001010b
        defb    01010000b
        defb    00001010b
        defb    01000001b
        defb    10101000b
        defb    00000101b
        defb    00100000b

        defb    01000100b
        defb    10001010b
        defb    01010000b
        defb    00001010b
        defb    01010001b
        defb    10101010b
        defb    00000101b
        defb    00100000b

        defb    01010100b
        defb    10001010b
        defb    01010000b
        defb    00001010b
        defb    01010001b
        defb    10101010b
        defb    01000101b
        defb    00100000b

        defb    01010100b
        defb    10001010b
        defb    01010001b
        defb    00001010b
        defb    01010001b
        defb    10101010b
        defb    01000101b
        defb    00101000b

        defb    01010101b
        defb    10001010b
        defb    01010001b
        defb    00101010b
        defb    01010001b
        defb    10101010b
        defb    01000101b
        defb    00101000b

        defb    01010101b
        defb    10001010b
        defb    01010001b
        defb    00101010b
        defb    01010101b
        defb    10101010b
        defb    01000101b
        defb    00101010b

        defb    01010101b
        defb    10001010b
        defb    01010101b
        defb    00101010b
        defb    01010101b
        defb    10101010b
        defb    01000101b
        defb    10101010b

        defb    01010101b
        defb    10001010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b

        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b

        defb    01010101b
        defb    10111010b
        defb    01010101b
        defb    10101010b
        defb    01010101b
        defb    10101010b
        defb    01110101b
        defb    10101010b

        defb    11010101b
        defb    10111010b
        defb    01010101b
        defb    10101010b
        defb    11010101b
        defb    10101010b
        defb    01110101b
        defb    10101010b

        defb    11010111b
        defb    10111010b
        defb    01010101b
        defb    10101010b
        defb    11010101b
        defb    10101110b
        defb    01110101b
        defb    10101010b

        defb    11010111b
        defb    10111010b
        defb    01010101b
        defb    10101110b
        defb    11010101b
        defb    10101110b
        defb    01110101b
        defb    10101011b

        defb    11011111b
        defb    10111010b
        defb    01010101b
        defb    10101110b
        defb    11110101b
        defb    10101110b
        defb    01110101b
        defb    10101011b

        defb    11011111b
        defb    10111010b
        defb    01010101b
        defb    10101110b
        defb    11110101b
        defb    10101111b
        defb    01110101b
        defb    10111011b

        defb    11011111b
        defb    11111010b
        defb    01010101b
        defb    10111110b
        defb    11110101b
        defb    10101111b
        defb    01110101b
        defb    10111011b

        defb    11011111b
        defb    11111010b
        defb    01010111b
        defb    10111110b
        defb    11110101b
        defb    10101111b
        defb    11110101b
        defb    10111011b

        defb    11011111b
        defb    11111010b
        defb    01110111b
        defb    10111110b
        defb    11110101b
        defb    10101111b
        defb    11111101b
        defb    10111011b

        defb    11011111b
        defb    11111010b
        defb    01110111b
        defb    10111111b
        defb    11110101b
        defb    11101111b
        defb    11111101b
        defb    10111011b

        defb    11011111b
        defb    11111010b
        defb    01110111b
        defb    10111111b
        defb    11111101b
        defb    11101111b
        defb    11111101b
        defb    10111111b

        defb    11011111b
        defb    11111011b
        defb    11110111b
        defb    10111111b
        defb    11111101b
        defb    11101111b
        defb    11111101b
        defb    10111111b

        defb    11011111b
        defb    11111011b
        defb    11111111b
        defb    10111111b
        defb    11111101b
        defb    11101111b
        defb    11111101b
        defb    11111111b

        defb    11111111b
        defb    11111011b
        defb    11111111b
        defb    10111111b
        defb    11111111b
        defb    11101111b
        defb    11111101b
        defb    11111111b

        defb    11111111b
        defb    11111011b
        defb    11111111b
        defb    11111111b
        defb    11111111b
        defb    11101111b
        defb    11111111b
        defb    11111111b
PatternLen:     equ $ - Patterns
NumPatterns:    equ PatternLen / 8
PatternRepeats: equ 256 / NumPatterns
ColorRepeats:   equ NumPatterns / 8