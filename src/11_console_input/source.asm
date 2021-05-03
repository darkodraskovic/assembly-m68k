        include "../include/libs.asm"

;;; DOS-Lib open
        move.l  ExecBase,a6
        lea     dosname,a1
        ;; OR move.l  #dosname,a1
        clr.l   d0
        jsr     OpenLib(a6)
        tst.l   d0
        beq     end
        move.l  d0,dosbase      ; DOSBase to a6

;;; Get Output handle
        move.l  dosbase,a6
        jsr     Output(a6)      ; get Output handle
        move.l  d0,outhandle    ; save Output handle in outhandle

;;; Display input prompt
        move.l  outhandle,d1    ; Output handle to d1
        move.l  #text1,d2       ; text addr to d2
        move.l  #24,d3          ; text len to d3
        jsr     Write(a6)       ; output prompt txt

;;; Read input
        jsr     Input(a6)       ; get Input handle
        move.l  d0,d1           ; Input handle to d1
        move.l  #buffer,d2      ; buffer start addr to d2
        move.l  #40,d3          ; buffer size to d3
        jsr     Read(a6)
        move.l  d0,d4           ; num read chars to d4
        
;;; Display response
        move.l  outhandle,d1
        move.l  #text2,d2
        move.l  #18,d3
        jsr     Write(a6)

        move.l  outhandle,d1
        move.l  #buffer,d2
        move.l  d4,d3           ; Read() puts # read chars to d4
        jsr     Write(a6)
        
;;; Close library
        move.l  dosbase,a1
        move.l  ExecBase,a6
        jsr     CloseLib(a6)

end:
        rts
        
;;; Data
dosname:        dc.b    "dos.library",0
        even
dosbase:        ds.l    1
outhandle:      ds.l    1
text1:          dc.b    "Please, input the text: ",10
        even
text2:          dc.b    "You have written: ",10
        even
buffer:         ds.b    40
