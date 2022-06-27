;APS00000001000000010000000100000001000000010000000100000001000000010000000100000001
;        incdir  "/include/"    
;        include "registers.asm"
;        include "constants.asm"

mainloop:

waitrast1:
	cmp.b	#$ac,$dff006	; is scanline on mid scr pos
	bne 	waitrast1
	move.w	#$fff,$dff180	; $fff ($rgb) to palette col 0	

waitrast2:
	; scr start=$2c; scr end=$12c; ($2c+12$c)/2=$ac
	cmp.b	#$ac,$dff006	; is scanline on mid scr pos
	beq 	waitrast2
	move.w	#$ff0,$dff180	; $ff0 to palette col 0	

	btst	#6,$bfe001	; wait for mouse
	bne 	mainloop
	
	rts
	      
