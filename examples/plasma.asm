; Plasma Effect for TMS9918A and Z80 by J.B. Langston
; 
; Color Palettes and Sine Routines ported from Plascii Petsma by Cruzer/Camelot
; https://csdb.dk/release/?id=159933
;
; Gradient Patterns ripped from Produkthandler Kom Her by Cruzer/Camelot
; https://csdb.dk/release/?id=760

NumSinePnts:    equ 8
ScreenWidth:    equ 32
ScreenHeight:   equ 24
ScreenSize:     equ ScreenWidth*ScreenHeight

        org     $100

        ld      (OldSP), sp
        ld      sp, Stack
        call    z180detect                      ; detect Z180
        ld      e, 0
        jp      nz, NoZ180
        ld      hl, SaveCMR                     ; save Z180 registers
        ld      c, Z180_CMR
        call    z180save
        ld      hl, SaveCCR
        ld      c, Z180_CCR
        call    z180save
        ld      hl, SaveDCNTL
        ld      c, Z180_DCNTL
        call    z180save
        call    z180getclk                      ; get clock multiple for tms wait
NoZ180:
        call    TmsSetWait                      ; set VDP wait loop based on clock multiple

        call    TmsProbe                        ; find what port TMS9918A listens on
        jp      z, NoTms
        call    TmsTile

        ld      de, About
        call    strout
        
        call    RandomSeed
        call    MakeSineTable
        call    MakeSpeedCode
        call    LoadPatternTable
        call    FirstEffect

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

WaitVsync:
        call    TmsRegIn
        and     $80
        jr      z, WaitVsync

        ld      hl, ScreenBuffer                ; display next frame
        ld      de, (TmsNameAddr)
        ld      bc, ScreenSize
        call    TmsWrite

        call    keypress
        jp      z, MainLoop
        call    ProcessCommand
        jp      MainLoop

Exit:   ld      hl, SaveCMR                     ; restore registers
        ld      c, Z180_CMR
        call    z180restore
        ld      hl, SaveCCR
        ld      c, Z180_CCR
        call    z180restore
        ld      hl, SaveDCNTL
        ld      c, Z180_DCNTL
        call    z180restore
        ld      sp, (OldSP)
        rst     0

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
        push    af
        ld      de, Help
        call    strout
        pop     af
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

; mirror and complement sine values above to produce full period
MakeSineTable:
        ld      bc, SineSrc
        ld      de, SineTable
        ld      hl, SineTable+$7f
        exx
        ld      b, $40
        ld      de, SineTable+$80
        ld      hl, SineTable+$ff
SineLoop:
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
        djnz    SineLoop
        ret

; load as many copies of the patterns as will fit in the pattern table
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

; set random seed from four bytes in screen buffer data offset by refresh register
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

; https://wikiti.brandonw.net/index.php?title=Z80_Routines:Math:Random
; combined LFSR/LCG PRNG, 16-bit seeds
Seed1:
        defw    0
Seed2:
        defw    0

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

; generate series of random numbers
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

; generate complete set of random parameters
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
        call    LoadColorTable
        jp      CalcPlasmaStarts
        
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

; change color palette
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

; set up color table using current palette
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

; calculate starting values for each tile
SinePntsX:
        defs    NumSinePnts
SinePntsY:
        defs    NumSinePnts

CalcPlasmaStarts:
        ld      hl, SineStartsY
        ld      de, SinePntsY
        ld      bc, NumSinePnts
        ldir
        ld      hl, PlasmaStarts
        ld      c, ScreenHeight
YLoop:
        exx
        ld      bc, SinePntsY
        ld      hl, SineAddsY
        ld      de, SinePntsX
        exx
        ld      d, NumSinePnts
SinePntsYLoop:
        exx
        ld      a, (bc)
        add     a, (hl)
        ld      (bc), a
        ld      (de), a
        inc     bc
        inc     de
        inc     hl
        exx
        dec     d
        jp      nz, SinePntsYLoop
        ld      b, ScreenWidth
XLoop:
        exx
        ld      de, SinePntsX
        ld      hl, SineAddsX
        ld      b, NumSinePnts
SinePntsXLoop:
        ld      a, (de)
        add     a, (hl)
        ld      (de), a
        inc     de
        inc     hl
        djnz    SinePntsXLoop

        ld      h, SineTable >> 8
        ld      de, SinePntsX
        ld      b, NumSinePnts
        xor     a
SineAddLoop:
        ex      af, af'
        ld      a, (de)
        ld      l, a
        ex      af, af'
        add     a, (hl)
        inc     de
        djnz    SineAddLoop
        exx
        ld      (hl), a
        inc     hl
        djnz    XLoop
        dec     c
        jp      nz, YLoop
UpdateScreen:
        ld      hl, PlasmaStarts
        ld      de, ScreenBuffer
        ld      bc, ScreenSize
        ldir
        ret

; calculate new plasma frame from starting point and current counts
PlasmaCnts:
        defw    0
CycleCnt:
        defb    0

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

; original Z180 register values
SaveCMR:
        defb    0
SaveCCR:
        defb    0
SaveDCNTL:
        defb    0
OldSP:
        defw    0                

; Parameters for current effect
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

; pre-defined plasma parameters
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
PaletteLen:     equ 32 / ColorRepeats

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

        include "tms.asm"
        include "z180.asm"
        include "utility.asm"

SineTable:      equ ($ + $ff) & $ff00          ; page align
Stack:          equ SineTable + $200
PlasmaStarts:   equ Stack
ScreenBuffer:   equ PlasmaStarts + ScreenSize
SpeedCode:      equ ScreenBuffer + ScreenSize