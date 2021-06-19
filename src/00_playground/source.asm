        incdir  "../include"
        include "libs.asm"
        include "registers.asm"
        include "constants.asm"

mainloop:
        
        btst    #6,CIAAPRA
        bne     mainloop

exit:   
        rts
        
