        include "../include/registers.asm"
        include "../include/constants.asm"

MOUSEL          = 06
WAIT            = 500000

init:
        move JOY0DAT,d5         ; save mouse pos
        
main:
        jsr mouse_left
        cmp.l #TRUE,d0
        beq end
        
        jsr mouse_move
        cmp.l #TRUE,d0
        bne main_end

        jsr led
        
main_end:
        jmp main

mouse_left:
        move.l #FALSE,d0
        btst #MOUSEL,CIAAPRA    ; lmb pressed?
        bne mouse_left_end
        move.l #TRUE,d0
mouse_left_end:
        rts

mouse_move:
        move.l #FALSE,d0
        move JOY0DAT,d6         ; get new mouse pos
        cmp d6,d5               ; cmp old mouse pos to new mouse pos
        beq mouse_move_end
        move d6,d5              ; save new mouse pos to d6
        move.l #TRUE,d0
mouse_move_end:
        rts

led:
        bchg #01,CIAAPRA        ; invert led bit
        move.l #WAIT,d0
led_wait:
        sub.l #01,d0
        bne led_wait
        rts
        
end:
        move.b #00,CIAAPRA
        rts
