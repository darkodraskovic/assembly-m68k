        include "../include/constants.asm"
        
        CNOP 0,4
gfxname:
        dc.b 'graphics.library',0
        
        CNOP 0,4        
gfxbase:
        dc.l 0

        move.l #gfxname,a1      ; arg for OpenLibrary
        moveq.l #0,d0           ; arg for OpenLibrary
        move.l $4,a6            ; addr $4 holds exec.library base ptr
        jsr (-552,a6)           ; exec OpenLibrary
        move.l d0,gfxbase       ; move graphics.library base ptr to gfxbase

        move.l d0,a6            ; move graphics.library base ptr to a6
        move.l #0,a1            ; null view
        jsr -222(a6)            ; exec LoadView -> use copperlist to create display

        Section ChipRAM,Data_c

        CNOP 0,4                ; pas with nop to next 32 bit boundary
ScreenMem:
        ds.b 320*200*4          ; 320x200x4 bitplanes

        CNOP 0,4
CopperList:
        dc.l $fffffffe          ; COPPER_HALT = end of list or new list
        ds.b 1023               ; 1024 bytes of chipram for copperlist
