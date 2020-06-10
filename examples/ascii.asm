; ASCII table TMS9918A text mode example program
; by J.B. Langston

LineLen:                equ 32
DoubleHorizontal:       equ 205
DoubleVertical:         equ 186
DoubleTopLeft:          equ 201
DoubleTopRight:         equ 187
DoubleBottomLeft:       equ 200
DoubleBottomRight:      equ 188


        org     100h

        ld      (OldSP),sp                      ; save old Stack poitner
        ld      sp, Stack                       ; set up Stack

        call    z180detect                      ; detect Z180
        ld      e, 0
        jp      nz, NoZ180
        call    z180getclk                      ; get clock multiple
NoZ180:
        call    TmsSetWait                      ; set VDP wait loop based on clock multiple

        call    TmsProbe                        ; find what port TMS9918A listens on
        jp      z, NoTms

        ld      hl, TmsFont                     ; pointer to font
        call    TmsTextMode                     ; initialize text mode

        ld      a, TmsDarkBlue                  ; set colors
        call    TmsBackground
        ld      a, TmsWhite
        call    TmsTextColor

        call    TextBorder

        ld      a, 11                           ; put title at 11, 1
        ld      e, 2
        call    TmsTextPos
        ld      hl, TitleMessage                ; output title
        call    TmsStrOut

        ld      a, 0                            ; start at character 0
        ld      b, LineLen                      ; 32 chars per line
        ld      c, 6                            ; start at line 6
        push    af                              ; save current character
NextLine:
        ld      a, 0+(40-LineLen)/2             ; center text
        ld      e, c                            ; on current line
        call    TmsTextPos
        pop     af                              ; get current character
NextChar:
        call    TmsRamOut
        inc     a                               ; BorderLoop character
        jp      z, Exit
        cp      b                               ; time for a new line?
        jp      nz, NextChar                    ; if not, output the BorderLoop character
        push    af                              ; if so, save the BorderLoop character
        add     a, LineLen                      ; 32 characters on the BorderLoop line
        ld      b, a
        inc     c                               ; skip two lines
        inc     c
        jp      NextLine                        ; do the BorderLoop line

Exit:
        ld      sp, (OldSP)
        rst     0

NoTmsMessage:
        defb    "TMS9918A not found, aborting!$"
NoTms:  ld      de, NoTmsMessage
        call    strout
        jp      Exit

TextBorder:
        ld      a, 0                            ; start at upper left
        ld      e, 0
        call    TmsTextPos
        ld      a, DoubleTopLeft                ; output corner
        call    TmsChrOut
        ld      b, 38                           ; output top border
        ld      a, DoubleHorizontal
        call    TmsRepeat
        ld      a, DoubleTopRight               ; output corner
        call    TmsChrOut
        ld      c, 22                           ; output left/right borders for 22 lines
BorderLoop:
        ld      a, DoubleVertical               ; vertical border
        call    TmsChrOut
        ld      a, ' '                          ; space
        ld      b, 38
        call    TmsRepeat
        ld      a, DoubleVertical               ; vertical border
        call    TmsChrOut
        dec     c
        jr      nz, BorderLoop
        ld      a, DoubleBottomLeft             ; bottom right
        call    TmsChrOut
        ld      a, DoubleHorizontal
        ld      b, 38
        call    TmsRepeat
        ld      a, DoubleBottomRight
        call    TmsChrOut
        ret

TmsFont:
        include "TmsFont.asm"
        include "tms.asm"                       ; TMS graphics routines
        include "z180.asm"                      ; Z180 routines
        include "utility.asm"                   ; BDOS utility routines

TitleMessage:    
        defb    "ASCII Character Set", 0

OldSP:
        defw 0
        defs 64
Stack: