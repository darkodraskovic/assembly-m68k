        incdir "../include"
        include "registers.asm"
        include "constants.asm"

init:
        move.l  #image,d0
        move.w  d0,pl1+6        ; d0 low word to copperlist MOVE IR2 (see AHRM p.36)
        swap    d0
        move.w  d0,pl1+2        ; d0 high word to copperlist MOVE IR2

        move.w  #$4000,INTENA           ; lock interrupts; clear bit 14 (bit 15 is set/Clear control)
        move.w  #$0020,DMACON           ; turn off sprites; clear bit 5 (bit 15 is set/Clear control)
        move.l  #copperl,COP2LCH        ; activate copperlist

main:
        move.l  VPOSR,d0                ; write VPOSR and VHPOSR to d0
        and.l   #$fff00,d0              ; $fff(vpos mask)00(hpos mask, ignore H pos)
        cmp.l   #$03000,d0              ; wait for rasterline V pos 48; ignore H pos
        bne.s   main
        btst    #6,CIAAPRA              ; lmb pressed?
        bne.s   main

end:
        move    #$c000,INTENA           ; Master interrupt enable; set bit 14
        move.w  #$8020,DMACON           ; turn on sprites; set bit 5
        rts

        SECTION tut,DATA_C      ; put in chip memory
image:  blk.b   10800,0

copperl:
        dc.w    $08e,$3081      ; DIWSTRT
        dc.w    $090,$35c1      ; DIWSTOP
        dc.w    $104,$0064      ; BPLCON2 pf1/2 priority over sprites and pf2 over pf1
        dc.w    $092,$0038      ; DDFSTRT normal (00111 0000000)
        dc.w    $094,$00d0      ; DDFSTOP normal (11000 0000000)
        dc.w    $102,$0000      ; BPLCON1 turn off pf1/2 scrolling
        dc.w    $108,$0000      ; BPL1MOD
        dc.w    $10a,$0000      ; BPL2MOD
        dc.w    $100,$0200      ; BPLCON0 low-res, 0 bitplanes, color burst
pl1:    dc.w    $0e0,$0000      ; BPL1PTH
        dc.w    $0e2,$0000      ; BPL1PTL

        dc.w    $0180,$000f     ; COLOR00

        dc.w    $7001,$fffe     ; WAIT
        dc.w    $0180,$00f0     ; COLOR00

        dc.w    $e001,$fffe     ; WAIT
        dc.w    $0180,$0f00     ; COLOR00

        dc.w    $ffff,$fffe     ; WAIT for impossible position
