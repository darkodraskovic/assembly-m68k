START:
        move.l #$1FFFFF,NUMBER1 ; initialise number
        move.l #1,d0
        add.l NUMBER1,d0        ; increment d0 copy of NUMBER1
        not.l d0                ; complement result
        move.l d0,RESULT

        ;; simpler version
        ;; move.l   #$1FFFFF,RESULT || ​add.l   #1,RESULT
        ;; ​addi.l   #1,RESULT
        ;; ​not.l    RESULT
        
        
        clr.l d0
        rts

NUMBER1:        ds.l 1
RESULT:         ds.l 1
        
