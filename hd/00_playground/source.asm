CIAAPRA         EQU     $bfe001
VHPOSR          EQU     $dff006             ; Read vert and horiz position of beam

mainloop:
        move #%10010101,d0
        btst #0,d0
        btst #1,d0
        btst #2,d0
        btst #3,d0
        btst #4,d0
        btst #5,d0
        btst #6,d0
        btst #7,d0
        
        btst #6,CIAAPRA
        bne mainloop

exit:   
        rts
        
