DMACONR		EQU		$dff002 ; DMA Control (and blitter status) read
ADKCONR		EQU		$dff010 ; Audio, Disk, UART Control Read
INTENAR		EQU		$dff01c ; Interrupt enable bits (read)
INTREQR		EQU		$dff01e ; Interrupt request bits (read)

DMACON		EQU		$dff096
ADKCON		EQU		$dff09e
INTENA		EQU		$dff09a
INTREQ		EQU		$dff09c

BPLCON0         EQU             $dff100
BPLCON1         EQU             $dff102
BPL1MOD         EQU             $dff108
BPL2MOD         EQU             $dff10a
DIWSTRT         EQU             $dff08e
DIWSTOP         EQU             $dff090
DDFSTRT         EQU             $dff092
DDFSTOP         EQU             $dff094
VPOSR           EQU             $dff004
COP1LCH         EQU             $dff080

CIAAPRA         EQU             $bfe001

VHPOSR          EQU             $dff006             ; Read vert and horiz position of beam
COLOR00         EQU             $dff180             ; Color table 0
COLOR01         EQU             $dff182             ; Color table 1


;;; rasterpos: #$0 to #$139
;;; visible part: #$2c (44) to #$12c (256 + 44)
SCRTOP          EQU     $2c
SCRBOT          EQU     $12c

BLACK           EQU     $000
WHITE           EQU     $fff
RED             EQU     $f00
GREEN           EQU     $0f0
BLUE            EQU     $00f
YELLOW          EQU     $ff0
MAGENTA         EQU     $f0f
CYAN            EQU     $0ff
