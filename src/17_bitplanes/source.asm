        incdir  "../include"
        include "libs.asm"
        include "registers.asm"
        include "constants.asm"

init:
        move.l  ExecBase,a6
        lea     gfxname,a1      ; a1 is 1st OpenLib() arg
        clr.l   d0              ; d0 is 2nd OpenLib() arg
        jsr     OpenLib(a6)     ; Open graphics.library
        move.l  d0,a1           ; move graphics.library base ptr to a1
        move.l  38(a1),oldcopper        ; original copper ptr
        jsr     CloseLib(a6)

        move.l  #copperl,COP1LCH        ; activate copperlist
        move.w  #$4000,INTENA           ; lock interrupts; clear bit 14 (bit 15 is set/Clear control)

        ;; move.w  #$2c81,DIWSTRT       ; The normal PAL DIWSTRT is ($2C81) ($vvhh) (cf. AHRM 59)
        ;; move.w  #$2cc1,DIWSTOP       ; The normal PAL DIWSTOP is ($2CC1) ($vvhh) (cf. AHRM 59)

        ;; left/right edge of display data fetch (cf. AHRM 60)
        move.w  #$0038,DDFSTRT      ; DDFSTRT normal (0011 1000)
        move.w  #$00d0,DDFSTOP      ; DDFSTOP normal (1101 0000)
        ;; the fetch mechanism for different types of Chip RAM accesses
        ;; slow fetch = normal (word aligned bitmaps) - for ECS modes and up to 8 bitplanes 320x256
        move.w  #$00,FMODE          ; Bitplane 32 bit wide mode (AGA compatibility)

        move.w  #$2200,BPLCON0          ; BPLCON0 low-res, 1 bitplanes, color burst
        ;; move.w  #$0000,BPLCON3          ; 9 = LOCT - palette low nibble colour (AGA compatibility)

        ;; the modulos for the odd and even bit planes
        move.w  #$0000,BPL1MOD          ; BPL1MOD
        move.w  #$0000,BPL2MOD          ; BPL2MOD

        move.w  #$f00,COLOR01
        move.w  #$00f,COLOR02
        
main:        
        move.l  VPOSR,d0                ; write VPOSR and VHPOSR to d0
        and.l   #$fff00,d0              ; $fff(vpos mask)00(hpos mask, ignore H pos)
        cmp.l   #$03000,d0              ; wait for rasterline V pos 48; ignore H pos
        bne.s   main
                
        move.l  #image1,BPL1PTH
        move.l  #image2,BPL2PTH
        
        btst    #6,CIAAPRA              ; lmb pressed?
        bne.s   main

end:    
        move    #$c000,INTENA           ; Master interrupt enable; set bit 14
        move.l  oldcopper,COP1LCH        ; restore copper

        rts

gfxname:        dc.b "graphics.library",0
        even
oldcopper:      ds.l 1
        
        SECTION tut,DATA_C      ; put in chip memory
image1:
        dcb.b   (320/8)*256,$0e
image2:
        dcb.b   (320/8)*256,$01
        
copperl:
        ;; dc.w    $08e,$3081      ; DIWSTRT
        ;; dc.w    $090,$35c1      ; DIWSTOP
        ;; dc.w    $102,$0000      ; BPLCON1 turn off pf1/2 scrolling
        ;; dc.w    $104,$0064      ; BPLCON2 pf1/2 priority over sprites and pf2 over pf1
        
        dc.w    $0180,$000     ; COLOR00

        dc.w    $ffff,$fffe     ; WAIT for impossible position
