        include "../include/libs.asm"

        movem.l a0/d0,-(sp)     ; save command line

        move.l  ExecBase,a6
        lea     dosname,a1
        clr.l   d0
        jsr     OpenLib(a6)     ; open DosLib
        move.l  d0,a6

        jsr     Output(a6)      ; Output handle to d0
        move.l  d0,outhandle
        
        move.l  outhandle,d1   ; Output handle to d1
        movem.l (sp)+,a0/d0    ; retrieve command line
        move.l  a0,d2          ; command line text start addr to d2
        move.l  d0,d3          ; command line text len to d3
        jsr     Write(a6)

        move.l  a6,a1
        move.l  ExecBase,a6
        jsr     CloseLib(a6)    ; close DosLib

        rts

dosname:        dc.b    "dos.library",0
        even
outhandle:      ds.l    1
