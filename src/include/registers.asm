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

VPOSR           EQU             $dff004
COP1LCH         EQU             $dff080 ; Copper first loc reg (high 3 bits, high 5 bits of ECS)

CIAAPRA         EQU             $bfe001

VHPOSR          EQU             $dff006             ; Read vert and horiz position of beam
COLOR00         EQU             $dff180             ; Color table 0
COLOR01         EQU             $dff182             ; Color table 1


