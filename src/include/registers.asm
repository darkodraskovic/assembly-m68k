DMACONR		EQU		$dff002 ; DMA Control (and blitter status) read
JOY0DAT         EQU             $dff00a ; 
ADKCONR		EQU		$dff010 ; Audio, Disk, UART Control Read
INTENAR		EQU		$dff01c ; Interrupt enable bits (read)
INTREQR		EQU		$dff01e ; Interrupt request bits (read)
                                       
DMACON		EQU		$dff096 ; DMA control write
ADKCON		EQU		$dff09e
INTENA		EQU		$dff09a
INTREQ		EQU		$dff09c
                                       
BPLCON0         EQU             $dff100 ; Bitplane control register (misc. ctrl bits)
BPLCON1         EQU             $dff102 ; Bitplane ctrl reg (scroll val PF1, PF2)
BPLCON2         EQU             $dff104 ; Bitplane ctrl reg (scroll val PF1, PF2)
BPLCON3         EQU             $dff106 ; Bitplane ctrl reg (scroll val PF1, PF2)
BPL1MOD         EQU             $dff108 ; Bitplane module (odd planes)
BPL2MOD         EQU             $dff10a ; Bitplane module (even planes)
DIWSTRT         EQU             $dff08e ; Display window start (UL VH pos)
DIWSTOP         EQU             $dff090 ; Display window stop (LR VH pos)
DDFSTRT         EQU             $dff092 ; Display bitplane data fetch start (H pos)
DDFSTOP         EQU             $dff094 ; Display bitplane data fetch end (H pos)
                                       
BPL1PTH         EQU             $dff0e0 ; Bitplane pointer 1 (high 5 bits was 3 bits)
BPL1PTL         EQU             $dff0e2 ; Bitplane pointer 1 (low 15 bits)
BPL2PTH         EQU             $dff0e4 ; Bitplane pointer 1 (high 5 bits was 3 bits)
BPL2PTL         EQU             $dff0e6 ; Bitplane pointer 1 (low 15 bits)
                                       
VPOSR           EQU             $dff004
VHPOSR          EQU             $dff006 ; Read vert and horiz position of beam
COP1LCH         EQU             $dff080 ; Coprocessor 1st location (high 5 bits)
COP1LCL         EQU             $dff082
COP2LCH         EQU             $dff084
COP2LCL         EQU             $dff086
COPJMP1         EQU             $dff088 ; Coprocessor restart at first location
COPJMP2         EQU             $dff08a ; Coprocessor restart at second location
        
CIAAPRA         EQU             $bfe001

COLOR00         EQU             $dff180 ; Color table 0
COLOR01         EQU             $dff182 ; Color table 1
COLOR02         EQU             $dff184 ; Color table 1

FMODE           EQU             $dff1fc ; Fetch mode register
