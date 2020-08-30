; Plasma Effect for TMS9918 by J.B. Langston
; 
; Color Palettes and Sine Routines ported from Plascii Petsma by Cruzer/Camelot
; https://csdb.dk/release/?id=159933
;
; Gradient Patterns from Produkthandler Kom Her by Cruzer/Camelot
; https://csdb.dk/release/?id=760

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
        call    InitSines
        call    LoadPatternTable
        call    LoadColorTable
        exx
        ld      ix, 3                           ; divide by 3 counter
        ld      de, 0                           ; clear frame counter
        ld      h, Sine256 >> 8
        exx
MainLoop:
        ld      hl, ScreenBuffer
        ld      c, ScreenHeight
        call    Munching
        
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
        
; pre-calculated sine table from python script:

; #!/usr/bin/python3
; import math
; amp = 0xfe
; for i in range(0, 0x40):
;     sin = 2 + amp / 2 + amp * 0.499999 * math.sin(i / (0x100 / 2 / math.pi))
;     if i & 7 == 0:
;         print("defb    ", end="")
;     print(hex(int(sin)).replace("0x", "$"), end="\n" if i & 7 == 7 else ",")

SineSrc:
        defb    $81,$84,$87,$8a,$8d,$90,$93,$96
        defb    $99,$9c,$9f,$a2,$a5,$a8,$ab,$ae
        defb    $b1,$b4,$b7,$ba,$bc,$bf,$c2,$c4
        defb    $c7,$ca,$cc,$cf,$d1,$d3,$d6,$d8
        defb    $da,$dc,$df,$e1,$e3,$e5,$e7,$e8
        defb    $ea,$ec,$ed,$ef,$f1,$f2,$f3,$f5
        defb    $f6,$f7,$f8,$f9,$fa,$fb,$fc,$fc
        defb    $fd,$fe,$fe,$ff,$ff,$ff,$ff,$ff

; Mirror and complement sine table above to produce full period

InitSines:
        ld      bc, SineSrc
        ld      de, Sine256
        ld      hl, Sine256+$7f
        exx
        ld      b, $40
        ld      de, Sine256+$80
        ld      hl, Sine256+$ff
SineMirrorLoop:
        exx
        ld      a, (bc)
        ld      (de), a
        ld      (hl), a
        inc     bc
        inc     de
        dec     hl
        exx
        cpl
        ld      (de), a
        ld      (hl), a
        inc     de
        dec     hl
        djnz    SineMirrorLoop

; make 1 copy of sine table at full amplitude,
; 2 copies at 1/2 amplitude, and 2 copies at 1/4 amplitude

        ld      bc, Sine256
        ld      de, Sine256+$100
        ld      hl, Sine128
        exx
        ld      bc, Sine128+$100
        ld      de, Sine64
        ld      hl, Sine64+$100     
SineCopyLoop:
        exx
        ld      a, (bc)
        ld      (de), a
        or      a
        rra
        ld      (hl), a
        inc     bc
        inc     de
        inc     hl
        exx
        ld      (bc), a
        or      a
        rra
        ld      (de), a
        ld      (hl), a
        inc     bc
        inc     de
        inc     hl
        ld      a, l
        or      a
        jp      nz, SineCopyLoop
        ret

        
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
        add     a, a
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

Sine256:        equ ($ + $ff) & $ff00          ; page align
Sine128:        equ Sine256+$200
Sine64:         equ Sine128+$200