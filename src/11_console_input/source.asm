        include "../include/libs.asm"

;;; DOS-Lib open
        move.l  ExecBase,a6
        move.l  dosname,a1
        clr.l   d0
        jsr     OpenLib(a6)
        
;;; Data
dosname:        dc.b    "dos.library",0
        even
dosbase:        ds.l    1
text1:          dc.b    "Please, input the text: "
        even
text2:          dc.b    "You have written: "
        even
buffer:         ds.b    40
