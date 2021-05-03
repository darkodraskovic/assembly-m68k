        include "../include/constants.asm"

OFFSET         EQU              48

init:
        move.l 4.w,a6           ; exec base ptr
        clr.l d0                ; ret val of oldopenlibrary
        move.l #gfxname,a1      ; put oldopenlibrary param in a1
        jsr -408(a6)            ; oldopenlibrary() to open graphics.library
        move.l d0,a1              ; move ret val to a1 to use it as a ptr
        move.l 38(a1),oldcopper   ; original copper ptr
        jsr -414(a6)            ; closeliberary(); gfx lib base addr is still in d0

        move.w #SCRTOP+OFFSET,d7       ; start y pos
        move #1,d6              ; y add

        move.w INTENAR,d0
        ;; Set control bit. Determines if bits written with a 1 get set or cleared.
        or.w #$8000,d0
        move.w d0,oldintenar
        move #$7fff,INTENA      ; disable interrupts

        move.l #copper,COP1LCH

mainloop:

waitframe:
        btst #2,VPOSR           ; should be btst #2,VPOSR for amiga 1200
        bne waitframe
        cmp.b #SCRTOP,VHPOSR
        bne waitframe
waitframe2:
        cmp.b #SCRTOP,VHPOSR
        beq waitframe2

        add d6,d7               ; increment y position

        cmp.w #SCRBOT-OFFSET,d7        ; bottom check
        blo ok1
        neg d6                  ; change direction
ok1:
        cmp.w #SCRTOP+OFFSET,d7        ; top check
        bhi ok2
        neg d6                  ; change direction
ok2:
        move.b d7,waitras1
        move.b d7,waitras2
        
        btst #6,CIAAPRA
        bne mainloop
        
exit:
        move.l oldcopper,COP1LCH  ; restore copper
        move.w	oldintenar,INTENA ; restore interrupts

        rts


; DATA
        CNOP 0,4
oldcopper:      ds.l 1
oldintenar:	dc.w 0
gfxname:        dc.b "graphics.library",0
linevpos:       dc.w 0

        SECTION tut,DATA_C      ; put in chip memory
copper:
        ;; copperlist is executed on VBLANK interrupt
        ;; MOVE takes 8 cycles
        dc.w $1fc,0             ; slow fetch mode, AGA compatibility
        dc.w $106,$0000         ; 9 = LOCT - palette low nibble colour, AGA compatibility

        ;; Enables color burst output signal (set 9th bit of BPLCON0)
        dc.w $100,$0200         ; MOVE $0200 (2nd val) to $dff100 (1st val, i.e. BPLCON0)

        dc.w $180,CYAN          ; set background color (COLOR00)
        ;; $xx07 (7) - $xxdf (223) : screen H begin - end pixel
        dc.w $2d07,$fffe        ; second visible line
        dc.w $180,RED
        dc.w $2e07,$fffe        ; third visible line
        dc.w $180,BLUE

waitras1:
        dc.w $8007,$fffe
        dc.w $180,MAGENTA
waitras2:
        dc.w $80df,$fffe
        dc.w $180,BLUE

        dc.w $ffdf,$fffe
        ;; last visible line
        dc.w $2c07,$fffe        ; $2c07 is $12c07 (wrapped around $ffff)
        dc.w $180,RED
        ;; first invisible line
        dc.w $2d07,$fffe
        dc.w $180,CYAN

        dc.w $ffff,$fffe        ; WAIT for pos $fffe (impossible pos)
