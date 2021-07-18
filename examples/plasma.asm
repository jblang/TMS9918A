; Plasma Effect for TMS9918A and Z80 by J.B. Langston
; 
; Color Palettes and Sine Table ported from Plascii Petsma by Cruzer/Camelot
; https://csdb.dk/release/?id=159933
;
; ===============================================================================================
; Plascii Petsma by Cruzer/Camelot has one of the nicest looking plasma effects I've seen for
; the C64. Since he included the source code, I was able to port it to the Z80 and TMS9918.   

; I have added the following interactive features of my own:
; - change the palette independent of the effect
; - hold a particular effect on screen indefinitely
; - switch immediately to a new effect
; - runtime generation of random effects
; - adjust parameters to customize an effect

; Before getting into a specific implementation, it helps to understand how plasma effects work
; in general. Rather than write another explanation when others have already done it well, I'll
; refer you to  this one, which covers the basic concepts using C code:
; https://lodev.org/cgtutor/plasma.html

NumSinePnts:    equ 8
ScreenWidth:    equ 32
ScreenHeight:   equ 24
ScreenSize:     equ ScreenWidth*ScreenHeight
MSX:            equ 0

        org     $100

        ld      (OldSP), sp
        ld      sp, Stack

        ld      de, About
        call    strout

        call    z180detect                      ; detect Z180
        ld      e, 0
        jp      nz, NoZ180
        call    z180getclk                      ; get clock multiple for tms wait
NoZ180:
        call    TmsSetWait                      ; set VDP wait loop based on clock multiple

        call    TmsProbe                        ; find what port TMS9918A listens on
        jp      z, NoTms
        call    TmsTile

        call    RandomSeed
        call    MakeSineTable
        call    MakeSpeedCode
        call    LoadPatternTable
        call    FirstEffect

if MSX
        di
        ld      hl, ($39)
        ld      (MSXVector), hl
        ld      hl, MSXIntHandler
        ld      ($39), hl
        call    TmsIntEnable
        ei
endif

MainLoop:
        ld      a, (HoldEffect)
        or      a
        jp      nz, NoEffectCycle
        ld      hl, DurationCnt
        dec     (hl)
        call    z, NextEffect
NoEffectCycle:
        ld      a, (StopAnimation)
        or      a
        call    z, CalcPlasmaFrame

if MSX
        ld      a, $ff
        ld      (FrameReady), a
WaitVsync:
        ld      a, (FrameReady)
        or      a
        jp      nz, WaitVsync
else
WaitVsync:
        call    TmsRegIn
        and     $80
        jr      z, WaitVsync

        ld      hl, ScreenBuffer                ; display next frame
        ld      de, (TmsNameAddr)
        ld      bc, ScreenSize
        call    TmsWrite
endif

        call    keypress
        jp      z, MainLoop
        call    ProcessCommand
        jp      MainLoop

Exit:
        ld      sp, (OldSP)
if MSX
        di
        ld      hl, (MSXVector)
        ld      ($39), hl
        ei
        ld      a, ($fcb0)
        rst     $30
        db      $80
        dw      $5f
endif
        rst     0

if MSX
FrameReady:
        defb    0
MSXIntHandler:
        push    af
        push    hl
        push    de
        push    bc
        ld      a, (FrameReady)
        or      a
        jp      z, FrameNotReady
        ld      de, (TmsNameAddr)
        call    TmsWriteAddr
        ld      hl, ScreenBuffer
        ld      bc, (TmsPort)
        ld      de, ScreenSize
        inc     d
MSXIntLoop:
        ld      a, (hl)
        out     (c), a
        inc     hl
        dec     e
        jp      nz, MSXIntLoop
        dec     d
        jp      nz, MSXIntLoop
        xor     a
        ld      (FrameReady), a
FrameNotReady:
        pop     bc
        pop     de
        pop     hl
        pop     af
MSXVector:      equ $+1
        jp      0
endif

NoTmsMessage:
        defb    "TMS9918A not found, aborting!$"
NoTms:  ld      de, NoTmsMessage
        call    strout
        jp      Exit

About:
        defb    "Plasma for TMS9918", cr, lf
        defb    "Z80 Code by J.B. Langston", cr, lf, cr, lf
        defb    "Color Palettes and Sine Routines ported from "
        defb    "Plascii Petsma by Cruzer/Camelot", cr, lf
        defb    "Gradient Patterns ripped from "
        defb    "Produkthandler Kom Her by Cruzer/Camelot", cr, lf, cr, lf
        defb    "Press 'q' to quit, '?' for help.", cr, lf, "$"

Help:
        defb    cr, lf, "Commands:", cr, lf
        defb    " ?     help", cr, lf
        defb    " q     quit", cr, lf
        defb    " h     hold current effect on/off", cr, lf
        defb    " p     switch palette", cr, lf
        defb    " n     next effect", cr, lf
        defb    " d     default values", cr, lf
        defb    " a     animation on/off", cr, lf
        defb    " r     toggle random/playlist", cr, lf
        defb    " v     view parameters", cr, lf, cr, lf
        defb    "Parameter Selection:", cr, lf
        defb    " x     x increments", cr, lf
        defb    " y     y increments", cr, lf
        defb    " i     initial values", cr, lf
        defb    " c     linear animation speed", cr, lf
        defb    " s     sine animation speeds", cr, lf
        defb    " f     distortion frequencies", cr, lf, cr, lf
        defb    "Parameter Modification:", cr, lf
        defb    " 1-8   increment selected parameter (+ shift to decrement)", cr, lf
        defb    " 0     clear selected parameters", cr, lf, "$"

ShowHelp:
if !MSX
        ld      de, Help
        call    strout
endif
        ret

; command keys grouped by function
Commands:
        defb    "?qhpndavr0"
ModeSelectCommands:
        defb    "xyisfc"
IncDecCommands:
        defb    "12345678"
NumIncCommands: equ $ - IncDecCommands
        defb    "!@#$%^&*"
NumCommands:    equ $ - Commands

; pointers to command functions; must be 1-1 correspondence to commands
CommandPointers:
        defw    ShowHelp
        defw    Exit
        defw    ToggleHold
        defw    NextPalette
        defw    NextEffect
        defw    InitEffect
        defw    ToggleAnimation
        defw    ViewParameters
        defw    ToggleRandomParams
        defw    ClearParameters

; pointers to parameters; must be 1-1 correspondence to mode select commands
ParameterPointers:
        defw    SineAddsX
        defw    SineAddsY
        defw    SineStartsY
        defw    SineSpeeds
        defw    PlasmaFreqs
        defw    CycleSpeed
        defw    CycleSpeed+1

; dispatch command key in a
ProcessCommand:
        ld      hl, Commands
        ld      b, NumCommands
CheckCommandLoop:
        cp      (hl)
        jp      z, FoundCommandKey
        inc     hl
        djnz    CheckCommandLoop
        ret

; determine what category of command it is and handle appropriately
FoundCommandKey:
        ld      de, IncDecCommands
        or      a
        sbc     hl, de
        jp      nc, FoundIncDecCommand
        add     hl, de
        ld      de, ModeSelectCommands
        or      a
        sbc     hl, de
        jp      nc, FoundModeSelectCommand
        add     hl, de
        ld      de, Commands
        or      a
        sbc     hl, de
        ld      de, CommandPointers
        add     hl, hl
        add     hl, de
        ld      a, (hl)
        inc     hl
        ld      h, (hl)
        ld      l, a
        jp      (hl)

; mode select command; set pointers to appropriate mode variables
SelectedParameter:
        defw    CycleSpeed
SelectedParameterLength:
        defb    1

FoundModeSelectCommand:
        ld      de, ParameterPointers
        add     hl, hl
        add     hl, de
        ld      e, (hl)
        inc     hl
        ld      d, (hl)
        ld      (SelectedParameter), de
        inc     hl
        ld      a, (hl)
        inc     hl
        ld      h, (hl)
        ld      l, a
        or      a
        sbc     hl, de
        ld      a, l
        ld      (SelectedParameterLength), a
        ret

; increment/decrement command; adjust selected variable
FoundIncDecCommand:
        ld      a, l
        cp      NumIncCommands
        push    af
        and     7
        ld      l, a
        push    hl
        ld      hl, SelectedParameterLength
        cp      (hl)
        pop     hl
        jp      nc, AbortChangeParameter
        ld      de, (SelectedParameter)
        add     hl, de
        pop     af
        call    c, IncParameter
        call    nc, DecParameter
        ld      de, SineSpeeds
        or      a
        sbc     hl, de
        call    c, CalcPlasmaStarts
        ret
AbortChangeParameter:
        pop     af
        ret
IncParameter:
        inc     (hl)
        ret
DecParameter:
        dec     (hl)
        ret

; feature toggles
HoldEffect:
        defb    0
StopAnimation:
        defb    0
UseRandomParams:
        defb    0

ToggleRandomParams:
        ld      a, (UseRandomParams)
        xor     $ff
        ld      (UseRandomParams), a
        ret

ToggleAnimation:
        ld      a, (StopAnimation)
        xor     $ff
        ld      (StopAnimation), a
        jp      UpdateScreen

ToggleHold:
        ld      a, (HoldEffect)
        xor     $ff
        ld      (HoldEffect), a
        ret

; reset selected parameter values to 0
ClearParameters:
        ld      hl, (SelectedParameter)
        ld      a, (SelectedParameterLength)
        ld      b, a
        xor     a
ClearParameterLoop:
        ld      (hl), a
        inc     hl
        djnz    ClearParameterLoop
        jp      CalcPlasmaStarts

; parameter display names
SineAddsXMsg:
        defb cr, lf, "x increment: $"
SineAddsYMsg:
        defb cr, lf, "y increment: $"
SineStartsMsg:
        defb cr, lf, "init values: $"
SineSpeedsMsg:
        defb cr, lf, "sine speeds: $"
PlasmaFreqMsg:
        defb cr, lf, "plasma freq: $"
CycleSpeedMsg:
        defb cr, lf, "cycle speed: $"

; display current parameter values
ViewParameters:
if MSX
        ret
endif
        ld      hl, PlasmaParams
        ld      de, SineAddsXMsg
        call    ShowSinePnts
        ld      de, SineAddsYMsg
        call    ShowSinePnts
        ld      de, SineStartsMsg
        call    ShowSinePnts
        ld      de, SineSpeedsMsg
        call    ShowTwoParams
        ld      de, PlasmaFreqMsg
        call    ShowTwoParams
        ld      de, CycleSpeedMsg
        call    ShowOneParam
        call    crlf
        ret
ShowOneParam:
        ld      b, 1
        jp      ShowBParams
ShowTwoParams:
        ld      b, 2
        jp      ShowBParams
ShowSinePnts:
        ld      b, NumSinePnts
ShowBParams:
        push    hl
        push    bc
        call    strout
        pop     bc
        pop     hl
ShowParameterLoop:
        ld      a, (hl)
        inc     hl
        push    hl
        push    bc
        call    hexout
        call    space
        pop     bc
        pop     hl
        djnz    ShowParameterLoop
        ret

; MakeSineTable builds the sine table for a complete period from a precalculated quarter period.
; The first 64 values are copied verbatim from the precomputed values. The next 64 values are
; flipped horizontally by copying them in reverse order. The last 128 values are flipped 
; vertically by complementing them. The vertically flipped values are written twice, first in
; forward order, and then in reverse order to flip them horizontally and complete the period.
; The resulting lookup table is 256 bytes long and stored on a 256-byte boundary so that a sine
; value can be looked up by loading a single register with the input value.

MakeSineTable:
        ld      bc, SineSrc             ; source values
        ld      de, SineTable           ; start of 1st quarter
        ld      hl, SineTable+$7f       ; end of 2nd quarter
        exx
        ld      b, $40                  ; counter
        ld      de, SineTable+$80       ; start of 3rd quarter
        ld      hl, SineTable+$ff       ; end of 4th quarter
SineLoop:
        exx
        ld      a, (bc)                 ; load source value
        inc     bc
        ld      (de), a                 ; store 1st quarter
        inc     de
        ld      (hl), a                 ; store 2nd quarter
        dec     hl                      ; in reverse order
        exx
        cpl                             ; flip vertically
        ld      (de), a                 ; store 3rd quarter
        inc     de
        ld      (hl), a                 ; store 4th quarter
        dec     hl                      ; in reverse order
        djnz    SineLoop
        ret

; Sine table contains pre-computed sine values converted to 8-bit integers.  
; Real sine values from -1 to 1 correspond to unsigned integers from 0 to 255.
; The first quarter of the period is pre-computed using python script:

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

; LoadPatternTable loads 8 copies of the 32 tiles into the TMS9918 pattern table.
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

; The TMS9918 tile mode defines 256 tile patterns, each of which is associated with a specific
; foreground and background color. For palettes of 8 colors each, we can use 32 tiles per color,
; so we only use every other tile the set of 64 tiles used in Produkthandler Kom Her on the C64. 
; https://csdb.dk/release/?id=760

Patterns:
        defb    $00,$00,$00,$00,$00,$00,$00,$00
        defb    $00,$00,$10,$00,$40,$00,$04,$00
        defb    $00,$02,$10,$00,$40,$00,$04,$20
        defb    $40,$02,$10,$02,$40,$00,$04,$20
        defb    $40,$02,$10,$02,$40,$08,$05,$20
        defb    $40,$02,$10,$0a,$40,$88,$05,$20
        defb    $44,$02,$10,$0a,$41,$88,$05,$20
        defb    $44,$02,$50,$0a,$41,$a8,$05,$20
        defb    $44,$8a,$50,$0a,$41,$a8,$05,$20
        defb    $44,$8a,$50,$0a,$51,$aa,$05,$20
        defb    $54,$8a,$50,$0a,$51,$aa,$45,$20
        defb    $54,$8a,$51,$0a,$51,$aa,$45,$28
        defb    $55,$8a,$51,$2a,$51,$aa,$45,$28
        defb    $55,$8a,$51,$2a,$55,$aa,$45,$2a
        defb    $55,$8a,$55,$2a,$55,$aa,$45,$aa
        defb    $55,$8a,$55,$aa,$55,$aa,$55,$aa
        defb    $55,$aa,$55,$aa,$55,$aa,$55,$aa
        defb    $55,$ba,$55,$aa,$55,$aa,$75,$aa
        defb    $d5,$ba,$55,$aa,$d5,$aa,$75,$aa
        defb    $d7,$ba,$55,$aa,$d5,$ae,$75,$aa
        defb    $d7,$ba,$55,$ae,$d5,$ae,$75,$ab
        defb    $df,$ba,$55,$ae,$f5,$ae,$75,$ab
        defb    $df,$ba,$55,$ae,$f5,$af,$75,$bb
        defb    $df,$fa,$55,$be,$f5,$af,$75,$bb
        defb    $df,$fa,$57,$be,$f5,$af,$f5,$bb
        defb    $df,$fa,$77,$be,$f5,$af,$fd,$bb
        defb    $df,$fa,$77,$bf,$f5,$ef,$fd,$bb
        defb    $df,$fa,$77,$bf,$fd,$ef,$fd,$bf
        defb    $df,$fb,$f7,$bf,$fd,$ef,$fd,$bf
        defb    $df,$fb,$ff,$bf,$fd,$ef,$fd,$ff
        defb    $ff,$fb,$ff,$bf,$ff,$ef,$fd,$ff
        defb    $ff,$fb,$ff,$ff,$ff,$ef,$ff,$ff
PatternLen:     equ $ - Patterns
NumPatterns:    equ PatternLen / 8
PatternRepeats: equ 256 / NumPatterns
ColorRepeats:   equ NumPatterns / 8
PaletteLen:     equ 32 / ColorRepeats

; RandomSeed sets the seed from four bytes in screen buffer data offset by refresh register.
RandomSeed:
        ld      hl, ScreenBuffer
        ld      a, r
        ld      d, 0
        ld      e, a
        add     hl, de
        ld      b, 4
        ld      de, Seed1
RandomSeedLoop:
        ld      a, (hl)
        xor     l
        ld      (de), a
        inc     hl
        inc     de
        djnz    RandomSeedLoop
        ret

; RandomNumber generates a random number using combined LFSR/LCG PRNG with 16-bit seeds
; https://wikiti.brandonw.net/index.php?title=Z80_Routines:Math:Random
RandomNumber:
        ld      hl, (Seed1)
        ld      b, h
        ld      c, l
        add     hl, hl
        add     hl, hl
        inc     l
        add     hl, bc
        ld      (Seed1), hl
        ld      hl, (Seed2)
        add     hl, hl
        sbc     a, a
        and     %00101101
        xor     l
        ld      l, a
        ld      (Seed2), hl
        add     hl, bc
        ret

Seed1:
        defw    0
Seed2:
        defw    0

; RandomSeries generates series of random numbers
; b = number of random numbers to generate
; c = mask for random numbers
; d = offset for random numbers
RandomSeries:
        push    bc
        push    hl
        call    RandomNumber
        ld      a, l
        or      a
        pop     hl
        pop     bc
        call    m, RandomNeg
        call    p, RandomPos
        ld      (hl), a
        inc     hl
        djnz    RandomSeries
        ret
RandomPos:
        and     c
        add     a, d
        ret
RandomNeg:
        and     c
        add     a, d
        cpl
        inc     a
        ret

; RandomParameters generates a complete set of random parameters
RandomParameters:
        ld      d, 0
        ld      c, 7                    ; -8 to 7
        ld      b, NumSinePnts
        ld      hl, SineAddsX
        call    RandomSeries
        ld      c, 3                    ; -4 to 3
        ld      b, NumSinePnts
        ld      hl, SineAddsY
        call    RandomSeries
        ld      c, $7f                  ; -128 to 127
        ld      b, NumSinePnts
        ld      hl, SineStartsY
        call    RandomSeries
        ld      c, 3                    ; -4 to 3
        ld      b, 2
        ld      hl, SineSpeeds
        call    RandomSeries
        ld      c, 3                    ; 1 to 8
        ld      d, 5
        ld      b, 2
        ld      hl, PlasmaFreqs
        call    RandomSeries
        ld      c, 7                    ; -16 to -1
        ld      d, -8
        ld      b, 1
        ld      hl, CycleSpeed
        call    RandomSeries
        call    RandomNumber            ; randomly select palette
        ld      a, l
        and     $f                      ; assumes 16 palettes of 8 colors each
        ld      h, 0
        ld      l, a
        add     hl, hl
        add     hl, hl
        add     hl, hl
        ld      de, ColorPalettes
        add     hl, de
        ld      (ColorPalette), hl
        call    CalcPlasmaStarts
        jp      LoadColorTable
        
; select and initialize plasma effects
DurationCnt:
        defb    0
PlasmaParamPnt:
        defw    0

NextEffect:
        ld      a, (UseRandomParams)
        or      a
        jp      nz, RandomParameters
        ld      hl, (PlasmaParamPnt)
        ld      de, PlasmaParamLen
        add     hl, de
        ld      (PlasmaParamPnt), hl
        ld      de, LastPlasmaParam
        or      a
        sbc     hl, de
        jp      c, InitEffect
        ; fallthrough

FirstEffect:
        ld      hl, PlasmaParamList
        ld      (PlasmaParamPnt), hl
        ; fallthrough

InitEffect:
        ld      hl, (PlasmaParamPnt)            ; copy parameters
        ld      de, PlasmaParams
        ld      bc, PlasmaParamLen
        ldir
        
        xor     a                               ; reset counters
        ld      (PlasmaCnts), a
        ld      (PlasmaCnts+1), a
        ld      (CycleCnt), a
        ld      (DurationCnt), a
        
        call    CalcPlasmaStarts
        call    LoadColorTable
        ret

; PlasmaParams holds parameters for the current effect
PlasmaParams:
SineAddsX:
        defs    NumSinePnts
SineAddsY:
        defs    NumSinePnts
SineStartsY:
        defs    NumSinePnts
SineSpeeds:
        defs    2
PlasmaFreqs:
        defs    2
CycleSpeed:
        defs    1
ColorPalette:
        defw    0
PlasmaParamLen: equ $ - PlasmaParams

; PlasmaParamList contains pre-defined plasma parameters
PlasmaParamList:
        defb    $fa,$05,$03,$fa,$07,$04,$fe,$fe
        defb    $fe,$01,$fe,$02,$03,$ff,$02,$02
        defb    $5e,$e8,$eb,$32,$69,$4f,$0a,$41
        defb    $fe,$fc
        defb    $06,$07
        defb    $ff
        defw    Pal01

        defb    $04,$05,$fc,$02,$fc,$03,$02,$01
        defb    $00,$01,$03,$fd,$02,$fd,$fe,$00
        defb    $51,$a1,$55,$c1,$0d,$5a,$dd,$26
        defb    $fe,$fd
        defb    $08,$08
        defb    $f8
        defw    Pal06

        defb    $f9,$06,$fe,$fa,$fa,$00,$07,$fb
        defb    $02,$01,$02,$03,$03,$00,$fd,$00
        defb    $34,$85,$a6,$11,$89,$2b,$fa,$9c
        defb    $fc,$fb
        defb    $09,$08
        defb    $fa
        defw    Pal09

        defb    $00,$01,$03,$00,$01,$ff,$04,$fc
        defb    $01,$ff,$03,$fe,$fe,$03,$02,$02
        defb    $f3,$02,$0b,$89,$8c,$d3,$23,$aa
        defb    $fe,$01
        defb    $07,$07
        defb    $08
        defw    Pal0a

        defb    $04,$04,$04,$fc,$fd,$04,$ff,$fc
        defb    $01,$02,$02,$01,$ff,$00,$ff,$01
        defb    $3a,$21,$53,$93,$39,$b7,$26,$99
        defb    $fd,$fe
        defb    $05,$06
        defb    $03
        defw    Pal04

        defb    $fd,$fd,$fd,$02,$04,$00,$fd,$02
        defb    $03,$02,$fd,$02,$03,$fe,$ff,$ff
        defb    $bc,$99,$5d,$2f,$e6,$16,$af,$0e
        defb    $fd,$ff
        defb    $07,$07
        defb    $f5
        defw    Pal07

        defb    $fc,$00,$00,$ff,$04,$04,$00,$01
        defb    $fd,$03,$00,$02,$00,$03,$02,$03
        defb    $30,$c7,$07,$60,$36,$2b,$e8,$ec
        defb    $ff,$fe
        defb    $09,$03
        defb    $f8
        defw    Pal05

        defb    $fd,$fc,$fe,$00,$00,$04,$fe,$01
        defb    $03,$03,$fe,$02,$00,$03,$fe,$00
        defb    $21,$d7,$34,$1b,$5d,$eb,$8e,$7d
        defb    $fd,$ff
        defb    $0a,$03
        defb    $fd
        defw    Pal03

        defb    $fe,$00,$ff,$01,$04,$02,$fe,$fd
        defb    $02,$01,$fe,$01,$03,$ff,$03,$ff
        defb    $0b,$0f,$ea,$8c,$e0,$f8,$05,$0e
        defb    $fc,$fd
        defb    $07,$06
        defb    $f8
        defw    Pal0c

        defb    $33,$04,$34,$fc,$dd,$24,$cf,$7c
        defb    $c1,$73,$02,$31,$fe,$a0,$ee,$01
        defb    $3a,$21,$53,$93,$39,$b7,$26,$99
        defb    $00,$00
        defb    $04,$01
        defb    $fd
        defw    Pal00

        defb    $ff,$00,$01,$ff,$02,$fe,$00,$02
        defb    $ff,$02,$01,$02,$fe,$01,$00,$00
        defb    $1d,$bb,$c5,$a3,$ab,$6c,$ed,$a6
        defb    $fd,$fe
        defb    $03,$03
        defb    $f8
        defw    Pal08

        defb    $02,$03,$fd,$fd,$01,$fc,$fd,$00
        defb    $01,$03,$fd,$fe,$fe,$03,$00,$00
        defb    $69,$ac,$3b,$c1,$fe,$21,$37,$84
        defb    $fc,$fd
        defb    $06,$05
        defb    $fa
        defw    Pal0b
LastPlasmaParam:

; NextPalette changes to the next color palette
NextPalette:
        ld      hl, (ColorPalette)
        ld      de, PaletteLen
        add     hl, de
        ld      (ColorPalette), hl
        ld      de, LastPalette
        or      a
        sbc     hl, de
        jp      c, LoadColorTable
        ld      hl, ColorPalettes
        ld      (ColorPalette), hl
        ; fallthrough

; LoadColorTable sets up color table using current palette
;
; The color table in Graphics I mode consists of 32 bytes. Each byte defines two colors 
; for 8 consecutive patterns in the pattern table.  The upper nybble defines the color
; of the 1 bits and the lower nybble defines the color of the 0 bits. 
;
; For simplicity, palettes are stored with one color per byte, and the LoadColorTable 
; routine combines each adjacent color into a single byte for the color table. Since 
; we are using 8 colors and 32 tiles per color combination, we need to load each color
; combination into the color table 4 times.
LoadColorTable:
        ld      de, (TmsColorAddr)
        call    TmsWriteAddr
        ld      hl, (ColorPalette)
        ld      c, (hl)
        ld      d, c
        ld      e, PaletteLen-1
AddColorLoop:
        inc     hl
        ld      a, (hl)
        call    AddColors
        ld      c, (hl)
        dec     e
        jp      nz, AddColorLoop
        ld      a, d
        ; fallthrough
AddColors:
        add     a, a
        add     a, a
        add     a, a
        add     a, a
        or      c
        ld      b, ColorRepeats
ColorRepeatLoop:
        call    TmsRamOut
        djnz    ColorRepeatLoop
        ret

; VIC-II to TMS9918 color mappings
; compromises with no direct mapping are marked with #
; vic:  $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f
; tms:  $01,$0f,$06,$07,$0d,$0c,$04,$0b,$0a,#0A,#09,#01,$0e,$03,$05,#0E

; palettes pre-mapped from vic to tms
ColorPalettes:
Pal00:  defb    $01,#01,$0e,#0e,$0f,#0e,$0e,#01
Pal01:  defb    $01,$01,$01,$02,$02,$02,$01,$01
Pal02:  defb    $03,$07,$05,$0d,$06,$0d,$05,$07
Pal03:  defb    #06,$08,$0d,#01,$04,#01,$0d,$08
Pal04:  defb    $04,#01,$0a,$08,$08,$08,$0a,#01
Pal05:  defb    $08,$01,$04,$02,$02,$02,$04,$01
Pal06:  defb    $04,#01,$06,$09,$0b,$09,$06,#01
Pal07:  defb    $03,$07,$01,$0a,$06,$0a,$01,$07
Pal08:  defb    $0f,$07,$05,$0d,$06,$0d,$05,$07
Pal09:  defb    $03,$0c,#01,$0d,$09,$0d,#01,$0c
Pal0a:  defb    $07,$05,#01,$06,$09,$06,#01,$05
Pal0b:  defb    $09,$0d,$04,$05,$07,$05,$04,$0d
Pal0c:  defb    $0b,$0a,#06,#01,$05,#01,#06,$0a
Pal0d:  defb    $08,$09,$0b,$03,$07,$05,$04,$0d
Pal0e:  defb    $01,$0c,$02,$03,$0f,$09,$08,$06
Pal0f:  defb    $01,$04,$05,$07,$0f,$0b,$0a,$0d
LastPalette:

; CalcPlasmaStarts calculates the initial value for each tile by summing together 8 sine waves of
; varying frequencies which combine to create the contours of a still image. Each sine wave is
; defined by a StartAngle, RowFreq and ColFreq which are applied to each X, Y coordinate as:
; StillFrame(x,y) = sum[n=1..8]: sin(StartAngle[n] + ColFreq[n] * x + RowFreq[n] * y)

; The calculation of the input angle for each X and Y coordinate is accomplished by successive
; additions of the RowFreq and ColFreq values for to the respective RowAngle and ColAngle
; accumulators.
CalcPlasmaStarts:
        ld      hl, SineStartsY         ; for each of 8 sine waves,
        ld      de, SinePntsY           ; initialize SinePntsY to SineStartsY
        ld      bc, NumSinePnts
        ldir
        ld      hl, PlasmaStarts
        ld      c, ScreenHeight         ; for each row...
YLoop:
        exx
        ld      bc, SinePntsY
        ld      hl, SineAddsY
        ld      de, SinePntsX
        exx
        ld      d, NumSinePnts
SinePntsYLoop:
        exx                             ; for each sine wave...
        ld      a, (bc)
        add     a, (hl)                 ; add SineAddsY to SinePntsY
        ld      (bc), a
        ld      (de), a                 ; initialize SinePntsX to SinePntsY
        inc     bc
        inc     de
        inc     hl
        exx
        dec     d
        jp      nz, SinePntsYLoop       ; ... next sine wave
        ld      b, ScreenWidth          ; for each column...
XLoop:
        exx
        ld      de, SinePntsX
        ld      hl, SineAddsX
        ld      b, NumSinePnts          ; for each sine wave...
SinePntsXLoop:
        ld      a, (de)
        add     a, (hl)                 ; add SineAddsX to SinePntsX
        ld      (de), a
        inc     de
        inc     hl
        djnz    SinePntsXLoop           ; ... next sine wave

        ld      h, SineTable >> 8
        ld      de, SinePntsX
        xor     a                       ; initialize to zero
        ld      b, NumSinePnts          ; for each sine wave...
SineAddLoop:
        ex      af, af'
        ld      a, (de)                 ; look up SinePntsX in SineTable
        ld      l, a
        ex      af, af'
        add     a, (hl)                 ; accumulate values from SineTable
        inc     de
        djnz    SineAddLoop             ; ...next sine wave
        exx
        ld      (hl), a                 ; save accumulated value in PlasmaStarts
        inc     hl
        djnz    XLoop                   ; ... next column
        dec     c
        jp      nz, YLoop               ; ... next row
UpdateScreen:
        ld      hl, PlasmaStarts        ; transfer PlasmaStarts to screen buffer
        ld      de, ScreenBuffer
        ld      bc, ScreenSize
        ldir
        ret

SinePntsX:
        defs    NumSinePnts
SinePntsY:
        defs    NumSinePnts

; CalcPlasmaFrame applies distortion and color cycling effects to the original image StillFrame.  
;
; For each frame, tiles are shifted based on LinearSpeed and two SineSpeeds.  In addition, each 
; row is warped by sine waves defined by two RowWarp parameters. For each row y of frame f, the
; total offset applied to each tile of StillFrame is calcualted according to this formula:
; D(f,y) = LinearSpeed * f + (sum [n=0..1]: sin(SineSpeed[n] * f + RowWarp[n] * y)) / 2
CalcPlasmaFrame:
        ld      bc, PlasmaCnts
        ld      de, (SineSpeeds)        
        ld      a, (bc)                 
        ld      h, a                    
        add     a, e                    
        ld      (bc), a
        inc     bc
        ld      a, (bc)
        ld      l, a
        add     a, d
        ld      (bc), a                   
        ld      d, SineTable >> 8
        ld      e, h                    
        ld      h, d                    
        ld      bc, (PlasmaFreqs)       
        exx
        ld      de, CycleCnt
        ld      a, (de)
        ld      c, a
        ld      hl, CycleSpeed
        add     a, (hl)
        ld      (de), a                 
        ld      hl, PlasmaStarts
        ld      de, ScreenBuffer
        jp      SpeedCode

; calculate new plasma frame from starting point and current counts
PlasmaCnts:
        defw    0
CycleCnt:
        defb    0

; setup for speedcode:
;       de  = pointer to first sine table entry
;       hl  = pointer to second sine table entry
;       c   = amount to increment first sine pointer between lines
;       b   = amount to increment second sine pointer between lines
;       c'  = current cycle count
;       b'  = offset to add to starting value for current row
;       hl' = pointer to starting plasma values
;       de' = pointer to screen back buffer
;       a   = temporary calculations

RowSrc:
        exx
        ld      a, e
        add     a, c
        ld      e, a
        ld      a, l
        add     a, b
        ld      l, a
        ld      a, (de)
        add     a, (hl)
        rra
        exx
        adc     a, c
        ld      b, a
RowSrcLen:     equ $ - RowSrc

ColSrc:
        ld      a, (hl)
        add     a, b
        ld      (de), a
        inc     hl
        inc     de
ColSrcLen:      equ $ - ColSrc

; build unrolled loops for speed
MakeSpeedCode:
        ld      de, SpeedCode
        ld      a, ScreenHeight
RowLoop:
        ld      hl, RowSrc
        ld      bc, RowSrcLen
        ldir
        ex      af, af'
        ld      a, ScreenWidth
ColLoop:
        ld      hl, ColSrc
        ld      bc, ColSrcLen
        ldir
        dec     a
        jp      nz, ColLoop
        ex      af, af'
        dec     a
        jp      nz, RowLoop
        ld      a, (RetSrc)
        ld      (de), a
RetSrc:
        ret

OldSP:
        defw    0                

        include "tms.asm"
        include "z180.asm"
        include "utility.asm"

SineTable:      equ ($ + $ff) & $ff00          ; page align
Stack:          equ SineTable + $200
PlasmaStarts:   equ Stack
ScreenBuffer:   equ PlasmaStarts + ScreenSize
SpeedCode:      equ ScreenBuffer + ScreenSize