; Nyan Cat for RC2014 and SC126 with TMS9918 and YM2149
; Hand-written assembly by J.B. Langston
; Nyan Cat images from Passan Kiskat by Dromedaar Vision: http://www.dromedaar.com/
; Nyan Cat theme by Karbofos: https://zxart.ee/eng/authors/k/karbofos/tognyanftro/qid:136394/
; PTx Player by S.V.Bulba <vorobey@mail.khstu.ru>

useay:          equ 1                   ; whether to play music on the AY-3 card
frameticks:     equ 3                   ; number of interrupts per animation frame
framecount:     equ 12                  ; number of frames in animation

        org     100h
        jp      start

        include "tms.asm"               ; TMS graphics routines
        include "z180.asm"              ; Z180 routines
        include "utility.asm"           ; BDOS utility routines
        include "PT3.asm"               ; PT3 player
        incbin  "nyan/nyan.pt3"         ; music data

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

tickcounter:
        defb    0                       ; interrupt down counter
currframe:
        defb    0                       ; current frame of animation
notmsmsg:
        defb    "TMS9918A not found, aborting!$"
dcntls: defb    0
oldsp:  defw    0                
        defs    40h
stack:
start:
        ld      (oldsp),sp              ; set up stack
        ld      sp, stack

        call    z180detect              ; detect Z180
        ld      e, 0
        jp      nz, noz180
        ld      hl, dcntls
        ld      c, Z180_DCNTL
        call    z180save
        ld      a, 4
        call    z180iowait
        call    z180getclk              ; get clock multiple
noz180: call    tmssetwait              ; set VDP wait loop based on clock multiple

        call    tmsprobe                ; find what port TMS9918A listens on
        jp      nz, notms

        call    tmsmulticolor           ; initialize tms for multicolor mode
        ld      a, tmsdarkblue          ; set background color
        call    tmsbackground

        ld      a, frameticks           ; initialize interrupt counter to frame length
        ld      (tickcounter), a

if useay
        call    START
        call    timer
        ld      (last),a
endif

mainloop:
if useay
        call    timer
        ld      hl, last
        cp      (hl)
        ld      (hl), a
        call    nz, PLAY                 ; play one piece of song
endif

        call    tmsregin
        and     80h                     ; check for vblank status bit
        call    nz, drawframe           ; only update when it's set

        call    keypress
        jp      z, mainloop

if useay
        call    MUTE
endif

exit:
        ld      hl, dcntls
        ld      c, Z180_DCNTL
        call    z180restore
        ld      sp, (oldsp)
        rst     0

notms:  ld      de, notmsmsg
        call    strout
        jp      exit

last:   defb    0

timer:  ld      b, 0f8h                 ; BIOS SYSGET function
        ld      c, 0d0h                 ; TIMER sub-function
        rst     8                       ; Call BIOS
        ld      a, l                    ; MSB to A
        ret                             ; Return to loop

; draw a single animation frame
;       HL = animation data base address
;       A = current animation frame number
drawframe:
        ld      a, (tickcounter)        ; check if we've been called frameticks times
        or      a
        jr      nz, framewait           ; if not, wait to draw next animation frame
        ld      hl, animation           ; draw the current frame
        ld      a, (currframe)          ; calculate offset for current frame
        ld      d, a                    ; x 1
        add     a, d                    ; x 2
        add     a, d                    ; x 3
        add     a, a                    ; x 6
        ld      d, a                    ; offset = frame x 600h
        ld      e, 0
        add     hl, de                  ; add offset to base address
        ld      de, 0                   ; pattern table address in vram
        ld      bc, 600h                ; length of one frame
        call    tmswrite                ; copy frame to pattern table
        ld      a, (currframe)          ; next animation frame
        inc     a
        cp      framecount              ; have we displayed all frames yet?
        jr      nz, skipreset           ; if not, display the next frame
        ld      a, 0                    ; if so, start over at the first frame
skipreset:
        ld      (currframe), a          ; save next frame in memory
        ld      a, frameticks           ; reset interrupt down counter
        ld      (tickcounter), a
        ret
framewait:
        ld      hl, tickcounter          ; not time to switch animation frames yet
        dec     (hl)                    ; decrement down counter
        ret