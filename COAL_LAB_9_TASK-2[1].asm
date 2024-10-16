.MODEL SMALL
.STACK 100H

.DATA
    num1 DW 10            ; First number
    num2 DW 20            ; Second number
    num3 DW 30            ; Third number
    sum  DW ?             ; Result will be stored here

    message DB 'The sum of three digits is: $'

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX           ; Initialize the data segment

        ; Call procedure to add the numbers
        CALL addThreeNumbers

        ; Print the message
        MOV DX, OFFSET message
        MOV AH, 09H
        INT 21H

        ; Print the result
        MOV AX, sum
        CALL printNumber

        ; Exit program
        MOV AH, 4CH
        INT 21H

    MAIN ENDP

    ; Procedure to add three numbers
    addThreeNumbers PROC
        MOV AX, num1
        ADD AX, num2
        ADD AX, num3
        MOV sum, AX
        RET
    addThreeNumbers ENDP

    ; Procedure to print number
    printNumber PROC
        MOV BX, 10           ; Divider for decimal conversion
        XOR CX, CX           ; Clear CX to store digits

    convertLoop:
        XOR DX, DX           ; Clear DX
        DIV BX               ; Divide AX by 10, quotient in AX, remainder in DX
        PUSH DX              ; Push remainder (digit) onto the stack
        INC CX               ; Count the digit
        CMP AX, 0
        JNE convertLoop      ; Repeat if quotient is not zero

    printLoop:
        POP DX               ; Get digit from stack
        ADD DL, 30H          ; Convert to ASCII
        MOV AH, 02H
        INT 21H              ; Print digit
        LOOP printLoop       ; Repeat for all digits

        RET
    printNumber ENDP

END MAIN
