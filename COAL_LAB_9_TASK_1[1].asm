.MODEL SMALL
.STACK 100H

.DATA
    originalString DB 'Hello, My Name is Mohammad Aqeel', 0   ; The original string
    reversedString DB 20 DUP('$')          ; Placeholder for the reversed string

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX            ; Set up the data segment

        LEA SI, originalString ; Load address of the original string into SI
        LEA DI, reversedString ; Load address of reversed string into DI

        ; Call reverseString procedure
        CALL reverseString

        ; Print the original string
        MOV DX, OFFSET originalString
        MOV AH, 09H
        INT 21H

        ; New line
        MOV AH, 02H
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H

        ; Print the reversed string
        MOV DX, OFFSET reversedString
        MOV AH, 09H
        INT 21H

        ; Exit program
        MOV AH, 4CH
        INT 21H

    MAIN ENDP

    reverseString PROC
        ; Find length of the original string
        MOV CX, 0               ; Initialize counter to 0
        MOV SI, OFFSET originalString

    findLength:
        CMP BYTE PTR [SI], 0    ; Check if end of string
        JE reverseLoop          ; If end, jump to reverse loop
        INC CX                  ; Increment counter
        INC SI                  ; Move to next character
        JMP findLength

    reverseLoop:
        DEC SI                  ; SI now points to the last character
        LEA DI, reversedString   ; DI points to reversedString

    reverseCopy:
        CMP CX, 0               ; If CX is 0, we're done
        JE doneReversing
        MOV AL, [SI]            ; Copy character from original
        MOV [DI], AL            ; Write to reversed string
        DEC SI                  ; Move to previous character in original
        INC DI                  ; Move to next in reversed
        DEC CX                  ; Decrease counter
        JMP reverseCopy

    doneReversing:
        MOV BYTE PTR [DI], '$'  ; End reversed string with '$'
        RET

    reverseString ENDP

END MAIN
