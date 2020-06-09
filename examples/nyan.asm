; Nyan Cat for RC2014 and SC126 with TMS9918 and YM2149
; Hand-written assembly by J.B. Langston
; Nyan Cat images from Passan Kiskat by Dromedaar Vision: http://www.dromedaar.com/
; Nyan Cat theme by Karbofos: https://zxart.ee/eng/authors/k/karbofos/tognyanftro/qid:136394/
; PTx Player by S.V.Bulba <vorobey@mail.khstu.ru>

useay:        equ 0                   ; whether to play music on the AY-3 card
vsyncdiv:     equ 3                   ; number of vsyncs per animation frame

        org     100h
        jp      start

        include "tms.asm"               ; TMS graphics routines
        include "z180.asm"              ; Z180 routines
        include "utility.asm"           ; BDOS utility routines
if useay
        include "PT3.asm"               ; PT3 player
        incbin  "nyan/nyan.pt3"         ; music data
endif

; Change included binary for different cat
animation:
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
endanimation:
vsynccount:
        defb    vsyncdiv                ; vsync down counter
currframe:
        defw    0                       ; current frame of animation
oldsp:  defw    0                
        defs    40h
stack:
start:
        ld      (oldsp),sp              ; set up stack
        ld      sp, stack

        call    z180detect              ; detect Z180
        ld      e, 0
        jp      nz, noz180
        call    z180getclk              ; get clock multiple
noz180: call    tmssetwait              ; set VDP wait loop based on clock multiple

        call    tmsprobe                ; find what port TMS9918A listens on
        jp      z, notms

        call    tmsmulticolor           ; initialize tms for multicolor mode
        ld      a, tmsdarkblue          ; set background color
        call    tmsbackground

if useay
        call    START
        call    timer
        ld      (last),a
endif

firstframe:
        ld      hl, animation           ; set up the first frame
nextframe:
        ld      (currframe), hl         ; save next animation frame address
skipdraw:
        call    keypress                ; exit on keypress
        jp      nz, exit

if useay
        call    timer                   ; get 50hz counter
        ld      hl, last                ; compare to last value
        cp      (hl)
        ld      (hl), a                 ; save current value for next time
        call    nz, PLAY                ; if it changed, play one quark of the song
endif

        call    tmsregin                ; check for vsync
        jp      p, skipdraw             ; don't draw until it's set

        ld      hl, vsynccount          ; decrement the vsync counter
        dec     (hl)
        jp      nz, skipdraw            ; don't draw until it's zero

        ld      a, vsyncdiv             ; reset vsync counter
        ld      (hl), a
        
        ld      hl, (currframe)         ; get address of current frame
        ld      de, 0                   ; pattern table address in vram
        ld      bc, 600h                ; length of one frame
        call    tmswrite                ; copy frame to vram, leaves hl pointing to next frame

        ld      de, endanimation        ; check if hl is past the last frame
        or      a
        sbc     hl, de
        add     hl, de
        jp      z, firstframe           ; if so, reset to first frame
        jp      nextframe

exit:
if useay
        call    MUTE
endif
        ld      sp, (oldsp)
        rst     0

notmsmsg:
        defb    "TMS9918A not found, aborting!$"
notms:  ld      de, notmsmsg
        call    strout
        jp      exit

if useay
last:   defb    0
timer:  ld      b, 0f8h                 ; BIOS SYSGET function
        ld      c, 0d0h                 ; TIMER sub-function
        rst     8                       ; Call BIOS
        ld      a, l                    ; MSB to A
        ret                             ; Return to loop
endif