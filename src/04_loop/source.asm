START:
        moveq #10,d0
        
POST_LOOP:
        subq #1,d0
        bne POST_LOOP

        moveq #10,d0
PRE_LOOP:
        beq END
        subq #1,d0
        bra PRE_LOOP

END:    
        clr.l d0
        rts
