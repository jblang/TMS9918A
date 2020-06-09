; TMS9918A sprite example
; by J.B. Langston

vsyncdiv:       equ 6                           ; number of interrupts per animation frame
framecount:     equ 8                           ; number of frames in animation

        org 100h

        jp start

        include "tms.asm"
        include "z180.asm"
        include "utility.asm"

vsynccount:
        defb    vsyncdiv                        ; vsync down counter
curname:
        defb    0                               ; name of the current sprite pattern
xdelta:
        defb    1                               ; direction horizontal motion
ydelta:
        defb    1                               ; direction vertical motion
oldsp:
        defw    0
        defs    32
stack:

start:
        ld      (oldsp), sp
        ld      sp, stack

        call    z180detect                      ; detect Z180
        ld      e, 0                            ; assume slowest clock speed for Z80
        jp      nz, noz180
        call    z180getclk                      ; get clock multiple
noz180: call    tmssetwait                      ; set VDP wait loop based on clock multiple

        call    tmsprobe                        ; find what port TMS9918A listens on
        jp      z, notms

        call    tmsbitmap

        ld      bc, spritelen                   ; set up sprite patterns
        ld      de, 1800h
        ld      hl, sprite
        call    tmswrite

firstname:        
        xor     a                               ; reset to first sprite name
nextname:
        ld      (curname), a                    ; save current sprite name in memory
samename:
        call    keypress                        ; exit on keypress
        jp      nz, exit

        call    tmsregin                        ; check for vsync flag
        jp      p, samename                     ; only update when it's set

        ld      hl, xdelta                      ; move x position
        ld      a, (sprite1x)
        add     a, (hl)
        ld      (sprite1x), a
        ld      (sprite2x), a
        cp      240                             ; bounce off the edge
        call    z, changedir
        or      a
        call    z, changedir
        ld      hl, ydelta                      ; move y position
        ld      a, (sprite1y)
        add     a, (hl)
        ld      (sprite1y), a
        ld      (sprite2y), a
        cp      176                             ; bounce off the edge
        call    z, changedir
        or      a
        call    z, changedir

        ld      bc, 8                           ; update sprite attribute table
        ld      de, 3b00h
        ld      hl, sprite1y
        call    tmswrite

        ld      hl, vsynccount                  ; count down the vsyncs
        dec     (hl)
        jp      nz, samename                    ; draw the same image until it reaches 0
        ld      a, vsyncdiv                     ; reload vsync counter when
        ld      (hl), a

        ld      a, (curname)                    ; change name pointers for sprites
        ld      (sprite1name), a                ; set name for first sprite
        add     a, 4                            ; add 4
        ld      (sprite2name), a                ; set name for second sprite
        add     a, 4
        cp      framecount*8                    ; have we displayed all frames yet?
        jp      nz, nextname                    ; if not, display the next frame
        jp      firstname                       ; if so, start over with the first

exit:
        ld      sp, (oldsp)
        rst     0

; change direction of motion
;       HL = pointer to direction variable
changedir:
        push    af
        ld      a, (hl)
        neg
        ld      (hl), a
        pop     af
        ret

notmsmsg:
        defb    "TMS9918A not found, aborting!$"
notms:  ld      de, notmsmsg
        call    strout
        jp      exit


; Sprite Attributes
sprite1y:
        defb 88
sprite1x:
        defb 0
sprite1name:
        defb 0
sprite1color: 
        defb tmsdarkblue
sprite2y:
        defb 88
sprite2x:
        defb 0
sprite2name:
        defb 4
sprite2color:
        defb tmslightgreen


; planet sprites from TI VDP Programmer's guide
sprite:
        ; Sprite world0 pattern 1
        defb    007h,01Ch,038h,070h,078h,05Ch,00Eh,00Fh
        defb    00Fh,01Fh,07Fh,063h,073h,03Dh,01Fh,007h
        defb    0E0h,0F8h,07Ch,066h,0F2h,0BEh,0DCh,0FCh
        defb    0F8h,0A0h,0C0h,0C0h,0E2h,0F4h,0F8h,0E0h
        ; Sprite world0 pattern 2
        defb    000h,003h,007h,00Fh,007h,0A3h,0F1h,0F0h
        defb    0F0h,0E0h,080h,01Ch,00Ch,002h,000h,000h
        defb    000h,000h,080h,098h,00Ch,041h,023h,003h
        defb    007h,05Fh,03Fh,03Eh,01Ch,008h,000h,000h
        ; Spri  te world1 pattern 1
        defb    003h,01Fh,03Eh,07Ch,07Eh,097h,003h,003h
        defb    003h,007h,01Fh,078h,07Ch,03Fh,01Fh,007h
        defb    0E0h,038h,01Ch,018h,03Ch,02Fh,0B7h,0FFh
        defb    0FEh,0E8h,0F0h,0F0h,0F8h,07Ch,0F8h,0E0h
        ; Sprite world1 pattern 2
        defb    000h,000h,001h,003h,001h,068h,0FCh,0FCh
        defb    0FCh,0F8h,0E0h,007h,003h,000h,000h,000h
        defb    000h,0C0h,0E0h,0E6h,0C2h,0D0h,048h,000h
        defb    001h,017h,00Fh,00Eh,006h,080h,000h,000h
        ; Sprite world2 pattern 1
        defb    007h,01Fh,03Fh,07Fh,03Fh,0E5h,0C0h,0C0h
        defb    080h,001h,007h,01Eh,03Fh,03Fh,01Fh,007h
        defb    0E0h,0C8h,084h,006h,08Eh,0CBh,0EDh,0FFh
        defb    0FFh,0FAh,0FCh,03Ch,03Eh,0DCh,0F8h,0E0h
        ; Sprite world2 pattern 2
        defb    000h,000h,000h,000h,040h,01Ah,03Fh,03Fh
        defb    07Fh,0FEh,0F8h,061h,040h,000h,000h,000h
        defb    000h,030h,078h,0F8h,070h,034h,012h,000h
        defb    000h,005h,003h,0C2h,0C0h,020h,000h,000h
        ; Sprite world3 pattern 1
        defb    007h,01Fh,03Fh,01Fh,04Fh,0F9h,070h,0F0h
        defb    0E0h,080h,001h,007h,00Fh,01Fh,01Fh,007h
        defb    0E0h,0F0h,0E0h,0C2h,0E2h,072h,03Bh,03Fh
        defb    03Fh,07Eh,0FFh,08Eh,0CEh,0F4h,0F8h,0E0h
        ; Sprite world3 pattern 2
        defb    000h,000h,000h,060h,030h,006h,08Fh,00Fh
        defb    01Fh,07Fh,0FEh,078h,070h,020h,000h,000h
        defb    000h,008h,01Ch,03Ch,01Ch,08Dh,0C4h,0C0h
        defb    0C0h,081h,000h,070h,030h,008h,000h,000h
        ; Sprite world4 pattern 1
        defb    007h,01Fh,03Fh,067h,073h,0BEh,0DCh,0FCh
        defb    0F8h,0A0h,0C0h,041h,063h,037h,01Fh,007h
        defb    0E0h,0F8h,0F8h,0F0h,0F8h,05Ch,00Eh,00Fh
        defb    00Fh,01Fh,07Fh,0E2h,0F2h,0FCh,0F8h,0E0h
        ; Sprite world4 pattern 2
        defb    000h,000h,000h,018h,00Ch,041h,023h,003h
        defb    007h,05Fh,03Fh,03Eh,01Ch,008h,000h,000h
        defb    000h,000h,004h,00Eh,006h,0A3h,0F1h,0F0h
        defb    0F0h,0E0h,080h,01Ch,00Ch,000h,000h,000h
        ; Sprite world5 pattern 1
        defb    007h,01Fh,01Fh,019h,03Ch,02Fh,0B7h,0FFh
        defb    0FEh,0E8h,0F0h,070h,078h,03Dh,01Fh,007h
        defb    0E0h,0F8h,0FCh,0FCh,0FEh,097h,003h,003h
        defb    003h,007h,01Fh,078h,0FCh,0FCh,0F8h,0E0h
        ; Sprite world5 pattern 2
        defb    000h,000h,020h,066h,043h,0D0h,048h,000h
        defb    001h,017h,00Fh,00Fh,007h,002h,000h,000h
        defb    000h,000h,000h,002h,000h,068h,0FCh,0FCh
        defb    0FCh,0F8h,0E0h,086h,002h,000h,000h,000h
        ; Sprite world6 pattern 1
        defb    007h,00Fh,007h,006h,00Fh,0CBh,0EDh,0FFh
        defb    0FFh,0FAh,0FCh,03Ch,03Eh,01Fh,01Fh,007h
        defb    0E0h,0F8h,0FCh,07Eh,03Eh,0E5h,0C0h,0C0h
        defb    080h,001h,007h,01Eh,03Eh,07Ch,0F8h,0E0h
        ; Sprite world6 pattern 2
        defb    000h,010h,038h,079h,070h,034h,012h,000h
        defb    000h,005h,003h,043h,041h,020h,000h,000h
        defb    000h,000h,000h,080h,0C0h,01Ah,03Fh,03Fh
        defb    07Fh,0FEh,0F8h,0E0h,0C0h,080h,000h,000h
        ; Sprite world7 pattern 1
        defb    007h,013h,021h,041h,063h,072h,03Bh,03Fh
        defb    03Fh,07Eh,0FFh,00Fh,04Fh,037h,01Fh,007h
        defb    0E0h,0F8h,0FCh,09Eh,0CEh,0F9h,070h,0F0h
        defb    0E0h,080h,001h,006h,08Eh,0DCh,0F8h,0E0h
        ; Sprite world7 pattern 2
        defb    000h,00Ch,01Eh,03Eh,01Ch,08Dh,0C4h,0C0h
        defb    0C0h,081h,000h,070h,030h,008h,000h,000h
        defb    000h,000h,000h,060h,030h,006h,08Fh,00Fh
        defb    01Fh,07Fh,0FEh,0F8h,070h,020h,000h,000h
spritelen: equ $-sprite