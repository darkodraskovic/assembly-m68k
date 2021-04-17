CIAAPRA         EQU     $bfe001
VHPOSR          EQU     $dff006             ; Read vert and horiz position of beam
COLOR00         EQU     $dff180             ; Color table 0
COLOR01         EQU     $dff182             ; Color table 1
INTENAR         EQU     $dff01c             ; Interrupt enable bits read
INTENA          EQU     $dff09a             ; Interrupt enable bits (clear or set bits)
;; BPLCON0         EQU     $dff100             ; Bit Plane Control Register 0
COP1LCH         EQU     $dff080 ; Coprocessor 1st location

;;; rasterpos: #$0 to #$139
;;; visible part: #$2c (44) to #$12c (256 + 44)
SCRTOP          EQU     $2c
SCRBOT          EQU     $12c

init:
        move.l 4.w,a6           ; exec base ptr
        clr.l d0                ; ret val of oldopenlibrary
        move.l #gfxname,a1      ; put oldopenlibrary param in a1
        jsr -408(a6)            ; oldopenlibrary() to open graphics.library
        move.l d0,a1              ; move ret val to a1 to use it as a ptr
        move.l 38(a1),oldcopper   ; original copper ptr
        jsr -414(a6)            ; closeliberary(); gfx lib base addr is still in d0
        
        move.w #SCRTOP,d7       ; start y pos
        move #1,d6              ; y add

        move.w INTENAR,d0
        ;; Set control bit. Determines if bits written with a 1 get set or cleared.
        or.w #$8000,d0
        move.w d0,oldintenar
        move #$7fff,INTENA      ; disable interrupts

        move.l #copper,COP1LCH
mainloop:

waitframe:
        btst #0,VHPOSR-1
        bne waitframe
        cmp.b #SCRTOP,VHPOSR
        bne waitframe
        
        add d6,d7               ; increment y position

        cmp.w #SCRBOT,d7        ; bottom check
        blo ok1
        neg d6                  ; change direction

ok1:
        cmp.w #SCRTOP,d7        ; top check
        bhi ok2
        neg d6                  ; change direction

ok2:

waitraster1:
        cmp.b VHPOSR,d7         ; rasterline pos == d7
        bne waitraster1
        move.w #$fff,COLOR00

waitraster2:
        cmp.b VHPOSR,d7
        beq waitraster2
        move.w #0000,COLOR00

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
        
        SECTION tut,DATA_C      ; put in chip memory
copper:
        dc.w $1fc,0             ; slow fetch mode, AGA compatibility
        ;; Enables color burst output signal (set 9th bit of BPLCON0)
        dc.w $100,$0200         ; MOVE $0200 (2nd val) to $dff100 (1st val, i.e. BPLCON0)
        dc.w $ffff,$fffe        ; WAIT for pos $fffe (impossible pos)
