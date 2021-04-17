START:
        lea TEXT,a0                     ; put address of string in a0
        move.b (a0),d0                  ; copy count (== 5) to d0
        addq.l #1,a0                    ; address to the first character (== 'A')
        ;; OR move.b (a0)+,d0 - copy count and incr pointer
        lea COPY,a1

LOOP:
        move.b (a0),(a1)        ; copy character
        addq.l #1,a0            ; incr to next src byte
        addq.l #1,a1            ; incr to next dst byte
        ;; OR move.b (a0)+,(a1)+ - copy char and incr pointers
        subq.b #1,d0            ; decr character counter
        bne LOOP                ; loop until d0 is zero
        
        move.b #0,(a1)          ; add terminal NULL

        clr.l d0
        rts

TEXT:   dc.b 5,"APPLE"
COPY:   ds.b 6
