        include "../include/registers.asm"
        include "../include/constants.asm"
        
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
        btst    #6,CIAAPRA              ; lmb pressed?
        bne.s   main

end:
        move.w  #$8020,DMACON           ; turn on sprites
        move    #$c000,INTENA           ; turn on interrupts
        rts

initcopper:
        lea     cins,a0         ; copperlist
        lea     colors(pc),a1   ; color list
        move    #99,d0          ; counter
        move    #$6001,d1       ; rasterline start
coppercopy:
        move    d1,(a0)+        ; wait position
        move    #$fffe,(a0)+    ; WAIT (copper instruction)
        move    #$0180,(a0)+    ; MOVE (copper instruction)
        cmp     #$fff,(a1)      ; does (a1) points to WHITE in colors
        bne.s   addcolor
        lea     colors(pc),a1
addcolor:
        move    (a1)+,(a0)+     ; color for MOVE instruction
        add     #$0100,d1       ; progress 1 rasterline
        dbf     d0,coppercopy   ; decrement d0 and if not -1 GOTO coppercopy
        rts
        
image:  blk.b   10800,0

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
        dc.w    $0e2,$0000      ; BPL2PTL

cins:   blk.w   400,0           ; placeholder
        
        dc.w    $0180,$0000
        dc.w    $ffff,$fffe     ; wait for impossible position
