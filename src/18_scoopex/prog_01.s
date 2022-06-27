;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
        incdir  "/include/"    
        include "registers.asm"
        include "constants.asm"

waitmouse:
	btst	#6,CIAAPRA
	bne 	waitmouse
	rts
	      
