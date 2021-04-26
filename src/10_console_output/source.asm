        include "../include/libs.asm"

;;; Open library
        move.l  ExecBase,a6
        lea     dosname,a1      ; a1 is 1st OpenLib() arg
        clr.l   d0              ; d0 is 2nd OpenLib() arg
        jsr     OpenLib(a6)
        tst.l   d0              ; error by dos.library open?
        beq     end
        move.l  d0,dosbase      ; d0 (base dos.library ptr) is OpenLib() ret val

;;; Get the CLI-Window output handle
        move.l  dosbase,a6
        jsr     Output(a6)      ; get output handle and store it in d0
        move.l  d0,clihandle

;;; Print text
        move.l  clihandle,d1    ; d1 is 1st Write() arg
        move.l  #text,d2        ; addr of the first letter to d2; d2 is 2nd Write() arg
        move.l  #33,d3          ; text len to d3
        jsr     Write(a6)       ; call Write()

;;;
        move.l  dosbase,a1      ; a1 (base ptr to dos.library) is 1st CloseLib() arg
        move.l  ExecBase,a6
        jsr     CloseLib(a6)

end:
        rts                     ; back to CLI
        
;;; Names
dosname:        dc.b    "dos.library",0
        even
dosbase:        ds.l    1
clihandle:      ds.l    1
text:           dc.b    "This text is printed in the CLI window",10
        even
