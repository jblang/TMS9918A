; Nyan Cat for RC2014 and SC126 with TMS9918 and YM2149
; Hand-written assembly by J.B. Langston
; Nyan Cat images from Passan Kiskat by Dromedaar Vision: http://www.dromedaar.com/
; Nyan Cat theme by Karbofos: https://zxart.ee/eng/authors/k/karbofos/tognyanftro/qid:136394/
; PTx Player by S.V.Bulba <vorobey@mail.khstu.ru>

UseAY:          equ 1                   ; whether to play music on the AY-3 card
VsyncDiv:       equ 3                   ; number of vsyncs per Animation frame

        org     100h

        ld      (OldSP),sp              ; set up stack
        ld      sp, Stack

        call    z180detect              ; detect Z180
        ld      e, 0
        jp      nz, NoZ180
        call    z180getclk              ; get clock multiple
NoZ180: call    TmsSetWait              ; set VDP wait loop based on clock multiple

        call    TmsProbe                ; find what port TMS9918A listens on
        jp      z, NoTms                ; abort if not found

        call    TmsMulticolor           ; initialize screen and set background color
        ld      a, TmsDarkBlue
        call    TmsBackground

if UseAY
        call    START
        call    Timer
        ld      (LastTimer),a
endif

FirstFrame:
        ld      hl, Animation           ; get address of first frame
NextFrame:
        ld      (CurrFrame), hl         ; save address of next animation frame
SkipDraw:
        call    keypress                ; exit on keypress
        jp      nz, Exit

if UseAY
        call    Timer                   ; see if 50hz timer has changed
        ld      hl, LastTimer
        cp      (hl)
        ld      (hl), a                 ; save current value for next time
        call    nz, PLAY                ; if changed, play one quark of the song
endif

        call    TmsRegIn                ; only draw when vsyncs counter reaches 0
        jp      p, SkipDraw
        ld      hl, VsyncCount
        dec     (hl)
        jp      nz, SkipDraw
        ld      a, VsyncDiv             ; reset vsync counter from divisor
        ld      (hl), a
        
        ld      hl, (CurrFrame)         ; copy current frame to pattern table
        ld      de, (TmsPatternAddr)
        ld      bc, TmsMulticolorPatternLen
        call    TmsWrite                ; leaves hl pointing to next frame

        ld      de, EndAnimation        ; check if hl is past the last frame
        or      a
        sbc     hl, de
        add     hl, de
        jp      z, FirstFrame           ; if so, reset to first frame
        jp      NextFrame

Exit:
if UseAY
        call    MUTE
endif
        ld      sp, (OldSP)
        rst     0

NoTmsMessage:
        defb    "TMS9918A not found, aborting!$"
NoTms:  ld      de, NoTmsMessage
        call    strout
        jp      Exit

if UseAY
LastTimer:   defb    0
Timer:  ld      b, 0f8h                 ; BIOS SYSGET function
        ld      c, 0d0h                 ; TIMER sub-function
        rst     8                       ; Call BIOS
        ld      a, l                    ; MSB to A
        ret                             ; Return to loop
endif

        include "tms.asm"               ; TMS graphics routines
        include "z180.asm"              ; Z180 routines
        include "utility.asm"           ; BDOS utility routines
if UseAY
        include "PT3.asm"               ; PT3 player
        incbin  "nyan/nyan.pt3"         ; music data
endif

; Change included binary for different cat
Animation:
        ; change incbin to binary for z88dk
        incbin  "nyan/nyan.bin"         ; The Classic
        ;incbin "nyan/nyands.bin"       ; Skrillex
        ;incbin "nyan/nyanfi.bin"       ; Finland
        ;incbin "nyan/nyangb.bin"       ; Gameboy
        ;incbin "nyan/nyanlb.bin"       ; Netherlands, light background
        ;incbin "nyan/nyann1.bin"       ; Netherlands
        ;incbin "nyan/nyann2.bin"       ; Cheese Cat
        ;incbin "nyan/nyanus.bin"       ; USA
        ;incbin "nyan/nyanxx.bin"       ; Nyanicorn
EndAnimation:
VsyncCount:
        defb    VsyncDiv                ; vsync down counter
CurrFrame:
        defw    0                       ; pointer to current animation frame
OldSP:  defw    0                
        defs    40h
Stack: