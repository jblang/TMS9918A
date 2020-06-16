; TMS9918A SpritePatterns example
; by J.B. Langston

VsyncDiv:       equ 6                           ; number of interrupts per animation frame
SpriteCount:    equ 8                           ; number of frames in animation

        org     100h

        ld      (OldSP), sp
        ld      sp, Stack

        call    z180detect                      ; detect Z180
        ld      e, 0                            ; assume slowest clock speed for Z80
        jp      nz, NoZ180
        call    z180getclk                      ; get clock multiple
NoZ180: call    TmsSetWait                      ; set VDP wait loop based on clock multiple

        call    TmsProbe                        ; find what port TMS9918A listens on
        jp      z, NoTms                        ; abort if not found

        call    TmsBitmap                       ; initialize screen

        ld      a, TmsSprite32
        call    TmsSpriteConfig

        ld      bc, SpritePatternLen            ; set up sprite patterns
        ld      de, (TmsSpritePatternAddr)
        ld      hl, SpritePatterns
        call    TmsWrite

FirstSprite:        
        xor     a                               ; reset to first sprite frame
NextSprite:
        ld      (CurrSprite), a                 ; save current sprite frame in memory
SameSprite:
        call    keypress                        ; exit on keypress
        jp      nz, Exit

        call    TmsRegIn                        ; only update during vsync
        jp      p, SameSprite

        ld      hl, XDelta                      ; move x position
        ld      a, (Sprite1X)
        add     a, (hl)
        ld      (Sprite1X), a
        ld      (Sprite2X), a
        cp      240                             ; bounce off the edge
        call    z, ChangeDirection
        or      a
        call    z, ChangeDirection
        ld      hl, YDelta                      ; move y position
        ld      a, (Sprite1Y)
        add     a, (hl)
        ld      (Sprite1Y), a
        ld      (Sprite2Y), a
        cp      176                             ; bounce off the edge
        call    z, ChangeDirection
        or      a
        call    z, ChangeDirection

        ld      bc, 8                           ; update sprite attribute table
        ld      de, (TmsSpriteAttrAddr)
        ld      hl, Sprite1Y
        call    TmsWrite

        ld      hl, VsyncCount                  ; count down the vsyncs
        dec     (hl)
        jp      nz, SameSprite                  ; draw the same image until it reaches 0
        ld      a, VsyncDiv                     ; reload vsync counter with divisor
        ld      (hl), a

        ld      a, (CurrSprite)                 ; change sprite pointers
        ld      (Sprite1Name), a
        add     a, 4
        ld      (Sprite2Name), a
        add     a, 4
        cp      SpriteCount*8                   ; reset to first sprite after last one
        jp      nz, NextSprite
        jp      FirstSprite

Exit:
        ld      sp, (OldSP)
        rst     0

; change direction of motion
;       HL = pointer to direction variable
ChangeDirection:
        push    af
        ld      a, (hl)
        neg
        ld      (hl), a
        pop     af
        ret

NoTmsMessage:
        defb    "TMS9918A not found, aborting!$"
NoTms:  ld      de, NoTmsMessage
        call    strout
        jp      Exit

        include "tms.asm"
        include "z180.asm"
        include "utility.asm"

VsyncCount:
        defb    VsyncDiv                        ; vsync down counter
CurrSprite:
        defb    0                               ; current sprite frame
XDelta:
        defb    1                               ; direction horizontal motion
YDelta:
        defb    1                               ; direction vertical motion
OldSP:
        defw    0
        defs    32
Stack:


; Sprite Attributes
Sprite1Y:
        defb 88
Sprite1X:
        defb 0
Sprite1Name:
        defb 0
Sprite1Color: 
        defb TmsDarkBlue
Sprite2Y:
        defb 88
Sprite2X:
        defb 0
Sprite2Name:
        defb 4
Sprite2Color:
        defb TmsLightGreen

; planet sprites from TI VDP Programmer's guide
SpritePatterns:
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
SpritePatternLen: equ $-SpritePatterns