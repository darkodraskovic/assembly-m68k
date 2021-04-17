START:
        move.b X,d0             ; copy byte X to lowest 8 bits of d0
        move.b d0,Y             ; copy lowest 8 bits of d0 to Y
        ;; eq. ​move.b X, Y
        clr.l d0                ; eq. move.l #0, d0
        rts
        
	;; CNOP 0,4
X:      dc.b 10
Y:      ds.b 1
