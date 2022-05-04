;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
;
; Notes: 1. Copper lists must be in Chip RAM.
;        2. Bitplane addresses used in the example are arbitrary.
;        3. Destination register addresses in Copper move instructions
;           are offsets from the base address of the custom chips.
;        4. As always, hardware manual examples assume that your
;           application has taken full control of the hardware, and is not
;           conflicting with operating system use of the same hardware.
;        5. Many of the examples just pick memory addresses to be used.
;           Normally you would need to allocate the required type of
;           memory from the system with AllocMem()
;        6. As stated earlier, the code examples are mainly to help
;           clarify the way the hardware works.
;        7. The following INCLUDE files are required by all example code
;           in this chapter.
;
        ;; INCLUDE "exec/types.i"
        ;; INCLUDE "hardware/custom.i"
        ;; INCLUDE "hardware/dmabits.i"
        INCDIR  "../include"
        INCLUDE "hardware/hw_examples.i"

start:
	move.l 	#CUSTOM,a5
        
        move.l  #image,d0
        move.w  d0,pl1+6        ; d0 low word to copperlist MOVE IR2 (see AHRM p.36)
        swap    d0
        move.w  d0,pl1+2        ; d0 high word to copperlist MOVE IR2

        move.l  #image,d0
        move.w  d0,pl2+6        ; d0 low word to copperlist MOVE IR2 (see AHRM p.36)
        swap    d0
        move.w  d0,pl2+2        ; d0 high word to copperlist MOVE IR2
        
	move.w  #$4000,INTENA(a5)       ; lock interrupts; clear bit 14 (bit 15 is set/Clear control)
	move.w  #$0020,DMACON(a5)       ; turn off sprites; clear bit 5 (bit 15 is set/Clear control)
	move.l  #COPPERLIST,COP1LCH(a5)	; activate copperlist

main:
	move.l  VPOSR(a5),d0            ; write VPOSR and VHPOSR to d0
	and.l   #$fff00,d0              ; $fff(vpos mask)00(hpos mask, ignore H pos)
	cmp.l   #$03000,d0              ; wait for rasterline V pos 48; ignore H pos
	bne.s   main
	
        btst    #6,$BFE001              ; lmb pressed?
        bne.s   main

end:
	move    #$c000,INTENA(a5)       ; Master interrupt enable; set bit 14
	move.w  #$8020,DMACON(a5)       ; turn on sprites; set bit 5
	rts

	SECTION tut,DATA_C

image:  blk.b   10800,$ff
        
COPPERLIST:
;
;  Set up pointers to two bitplanes
;
pl1:    DC.W    BPL1PTH,$0002   ;Move $0002 into register $0E0 (BPL1PTH)
        DC.W    BPL1PTL,$1000   ;Move $1000 into register $0E2 (BPL1PTL)
pl2:    DC.W    BPL2PTH,$0002   ;Move $0002 into register $0E4 (BPL2PTH)
        DC.W    BPL2PTL,$5000   ;Move $5000 into register $0E6 (BPL2PTL)
;
;  Load color registers
;
        DC.W    COLOR00,$00F0   ;Move white into register $180 (COLOR00)
        DC.W    COLOR01,$0F00   ;Move red into register   $182 (COLOR01)
        DC.W    COLOR02,$00F0   ;Move green into register $184 (COLOR02)
        DC.W    COLOR03,$000F   ;Move blue into register  $186 (COLOR03)
;
;   Specify 2 Lores bitplanes
;
        DC.W    BPLCON0,$2200   ;2 lores planes, coloron
;
;  Wait for line 150
;
        DC.W    $9601,$FF00     ;Wait for line 150, ignore horiz. position
;
;  Change color registers mid-display
;
        DC.W    COLOR00,$00FF  ;Move black into register $0180 (COLOR00)
        DC.W    COLOR01,$0FF0  ;Move yellow into register $0182 (COLOR01)
        DC.W    COLOR02,$00FF  ;Move cyan into register $0184 (COLOR02)
        DC.W    COLOR03,$0F0F  ;Move magenta into register $0186 (COLOR03)
;
; End Copper list by waiting for the impossible
;
        DC.W    $FFFF,$FFFE    ;Wait for line 255, H = 254 (never happens)
