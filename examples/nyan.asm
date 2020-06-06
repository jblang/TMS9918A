; Nyan Cat for RC2014 with TMS9918 and YM2149
; Hand-written assembly by J.B. Langston
; Images and music from Nyan Cat for MSX: https://www.msx.org/news/en/nyan-cat-msx

                org $0100

useay:          equ 1                   ; whether to play music on the AY-3 card
usez180:        equ 0                   ; whether avoid undocumented opcodes for Z180 compatibility
                                        ; note: if nyan exits back to CP/M on a Z180, set this to 1

bdos            equ 5                   ; bdos entry point
frameticks:     equ 3                   ; number of interrupts per animation frame
framecount:     equ 12                  ; number of frames in animation

        jp      start

if useay
music:
                ; change incbin to binary for z88dk
                incbin  "nyan/music.bin"     ; music data
                include "arkos.asm"     ; Arkos player
endif

; Change included binary for different cat
animation:
                ; change incbin to binary for z88dk
                incbin  "nyan/nyan.bin"      ; The Classic
                ;incbin "nyan/nyands.bin"    ; Skrillex
                ;incbin "nyan/nyanfi.bin"    ; Finland
                ;incbin "nyan/nyangb.bin"    ; Gameboy
                ;incbin "nyan/nyanlb.bin"    ; Netherlands, light background
                ;incbin "nyan/nyann1.bin"    ; Netherlands
                ;incbin "nyan/nyann2.bin"    ; Cheese Cat
                ;incbin "nyan/nyanus.bin"    ; USA
                ;incbin "nyan/nyanxx.bin"    ; Nyanicorn

                include "tms.asm"       ; TMS graphics routines

start:
        ld      (oldstack),sp           ; set up stack
	ld      sp, stack

        call    tmsmulticolor           ; initialize tms for multicolor mode
        ld      a, tmsdarkblue          ; set background color
        call    tmsbackground

        ld      a, frameticks           ; initialize interrupt counter to frame length
        ld      (tickcounter), a

if useay
        ld      de, music               ; initialize player if music enabled
        call    PLY_Init
endif

mainloop:
        call    tmsregin
        and     80h
        call    nz, drawframe           ; only update when it's set

        ld      c,6                     ; check for keypress
        ld      e,0ffh
        call    bdos
        or      a                       ; and exit early if pressed
        jp      z,mainloop

if useay
        call    PLY_Stop
endif
        ld      sp, (oldstack)
        rst     0


tickcounter:
        defb    0                       ; interrupt down counter
currframe:
        defb    0                       ; current frame of animation

; draw a single animation frame
;       HL = animation data base address
;       A = current animation frame number
drawframe:
if useay
        call    PLY_Play                ; play one piece of song
endif
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
        ld      de, $0000               ; pattern table address in vram
        ld      bc, $0600               ; length of one frame
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
oldstack:
        defw 0                
        defs 64
stack: