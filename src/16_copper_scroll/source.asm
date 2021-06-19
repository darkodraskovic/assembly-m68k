        incdir  "../include"    
        include "registers.asm"
        include "constants.asm"
        
init:
        move.w  #$4000,INTENA           ; lock interrupts
        move.w  #$0020,DMACON           ; turn off sprites
        move.l  #copperl,COP2LCH        ; activate copperlist
        
        move.l  #image,d0
        move.w  d0,pl1+6
        swap    d0
        move.w  d0,pl1+2
        bsr.s   initcopper
        
main:
        move.l  VPOSR,d0
        and.l   #$fff00,d0
        cmp.l   #$3000,d0               ; wait for rasterline
        bne.s   main
        bsr.s   scrollcopper
        btst    #6,CIAAPRA              ; lmb pressed?
        bne.s   main

end:
        move.w  #$8020,DMACON           ; turn on sprites
        move    #$c000,INTENA           ; turn on interrupts
        rts

initcopper:
        lea     cins,a0         ; copperlist
        move    #99,d0          ; counter
        move    #$6001,d1       ; rasterline start
coppercopy:
        move    d1,(a0)+
        move    #$fffe,(a0)+
        move    #$0180,(a0)+
        move    #$0000,(a0)+
        add     #$0100,d1
        dbf     d0,coppercopy
        rts

scrollcopper:
        lea     cins+6,a0
        move.l  colorsptr,a1
        cmp     #$fff,(a1)
        bne.s   nocol
        move.l  #colors,colorsptr
        move.l  colorsptr,a1
nocol:  move    #99,d0
scroll:
        move    (a1)+,(a0)
        add.l   #8,a0
        cmp     #$fff,(a1)
        bne.s   continue
        lea     colors,a1
continue:
        dbf     d0,scroll
        add.l   #2,colorsptr
        rts
        
image:  blk.b   10800,0

colorsptr:      dc.l colors
colors:
        dc.w RED, GREEN, BLUE, MAGENTA, CYAN, YELLOW, BLACK, GREY
        dc.w RED, GREEN, BLUE, MAGENTA, CYAN, YELLOW, BLACK, WHITE
        
        SECTION tut,DATA_C      ; put in chip memory        
copperl:
        dc.w    $08e,$3081      ; DIWSTRT
        dc.w    $090,$35c1      ; DIWSTOP
        dc.w    $104,$0064      ; BPLCON2 select bp6 and set pf1 priority over sprites
        dc.w    $092,$0038      ; DDFSTRT normal (00111 0000000)
        dc.w    $094,$00d0      ; DDFSTOP normal (11000 0000000)
        dc.w    $102,$0000      ; BPLCON1
        dc.w    $108,$0000      ; BPL1MOD
        dc.w    $10a,$0000      ; BPL2MOD
        dc.w    $100,$1200      ; BPLCON0 1 bit planes use, 2 color burst output signal
pl1:    dc.w    $0e0,$0005      ; BPL1PTH
        dc.w    $0e2,$0000      ; BPL1PTL

        dc.w    $0180,$0000
        
cins:   blk.w   400,0           ; placeholder
        
        dc.w    $0180,$0000
        dc.w    $ffff,$fffe     ; wait for impossible position
