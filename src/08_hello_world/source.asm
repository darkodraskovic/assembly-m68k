        SECTION TEXT

;;; store dos.library base ptr to DosHandle
        lea dosname,a1          ; dos.library - param for OpenLibrary
        moveq.l #0,d0           ; exec.library version - param for OpenLibrary
        move.l $4,a6            ; move exec.library base ptr to a6
        ;; exec OpenLibrary in exec.library
        ;; ret val is ptr to dos.library base ptr; OpenLibrary stores it in d0
        jsr (-552,a6)

        move.l d0,(DosHandle)   ; save base ptr to dos.library in DosHandle

;;; store Console base ptr to ConsoleHandle 
        move.l d0,a6            ; move dos.library base ptr to a6
        move.l #consolename,d1  ; pass the address of the string 'CONSOLE' to D1
        move.l #1005,d2         ; ModeOld
        jsr (-30,a6)            ; call "Dos: Open" to get Console ptr in d0

        move.l d0,(ConsoleHandle) ; save ptr to Console in ConsoleHandle

        lea Message,a3
        jsr PrintString
        jsr New_Line
        rts                     ;return to OS
        
;;; char to output is in d0
PrintChar:
        moveM.l d0-d3/a0,-(sp)
        
        move.b d0,(CharBuffer)  ; move char to output at address CharBuffer
        move.l (DosHandle),a0
        move.l (ConsoleHandle),d1
        move.l #CharBuffer,d2   ; address of char to output
        move.l #1,d3            ; buffer len (1 byte)
        jsr (-48,a0)            ; exec "Dos: Write"

        moveM.l (sp)+,d0-d3/a0
        rts

;;; a3 holds string address
PrintString:
        move.b (a3)+,d0         ; read char from a3
        cmp.b #255,d0
        beq PrintString_Done
        jsr PrintChar
        bra PrintString
PrintString_Done:
        rts

New_Line:
        move.b #$0d,d0          ; char 13 cr
        jsr PrintChar
        move.b #$0a,d0          ; char 10 LF
        jsr PrintChar
        rts

        even
Message:        dc.b 'Hello World',255
dosname:        dc.b 'dos.library',0   ; library name
consolename:    dc.b 'CONSOLE:',0
        
        SECTION ChipRAM,Data_c  ; request chip mem

DosHandle:      dc.l 0
ConsoleHandle:  dc.l 0
CharBuffer:     dc.b 0        ; character to print
