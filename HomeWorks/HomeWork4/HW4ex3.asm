;HW4ex3.asm
; A program receives two numbers (the numbers are positive, 
; and do not go beyond the size of a word - there is no obligation to check this).
; The program will divide the large number by the small number and print the dose and the remainder.
; Note that the first number can be larger or smaller than the second number.
.MODEL	SMALL
.STACK	20
.DATA
	num 	     	db	6, ?, 6 dup('$')
	new_line 	db  	0DH, 0AH, '$'
    	val          	db  	?

.CODE
	start:    
	    mov  ax, @DATA
	    mov  ds, ax
	;----------------the code itself begins here------------------
       
        mov cx, 2
        mov val, 2
        INPUT:
            ;getting input
            mov ah, 0AH
            lea dx, num
            int 21H
            
            mov si, dx
        
        ; to change the number from string to real number
            call PROC_STRING_TO_NUM

            mov ax, 0
            mov bx, 0
            mov cx, 0

            ; print new line
            mov ah, 9
            lea dx, new_line
            int 21H
            ; to know when to stop the loop
            dec [val]
            cmp [val], 0
            je  JUMP

        loop INPUT

        JUMP:
        pop bx ; pull out from the stack the second number to register bx
        pop cx ; pull out from the stack the first number to register cx 

        call PROC_FIND_MAX
        mov dx, 0
        mov ax, cx
        div bx

        ; to print the dose of the number
        call PROC_PRINT_NUM

        push dx ; to save the value of the remainder
        ; to print the dot for the remainder
        mov dx, 0
        mov ah, 02
        mov dl, '.'
        int 21H

        pop dx ; to pull out the value of the remainder
        mov ax, dx
        cmp ax, 0
        je  REMAINDER_ZERO
        ; to print the remainder of the number
        call PROC_PRINT_NUM
        jmp TO_THE_END

        REMAINDER_ZERO:
        mov ah, 02
        mov dl, '0'
        int 21H

    TO_THE_END:
	;end program
	mov	ah, 4ch
	mov	al, 0
	int	21H

    ; Procedures:

    ; change the inut number from string to number
    PROC_STRING_TO_NUM PROC
        mov ah, 0
        mov bx, 0
        mov dx, 0

        mov cx, [si+1]   ; length of the number
        mov ch, 0
        cmp cl, 1
        dec cx
        jne GO
        mov bl, [si+2]
        sub bl, '0' ; to get the real number and not the ascii value
        jmp DONE

        GO:
            mov dx, 0
            mov dl, [si+2]
            sub dl, '0' ; to get the real number and not the ascii value
            
            add bx, dx ; add the digit to the number 
            mov ax, 10
            mul bx ; mult the number by 10
            mov bx, ax ; move the number from ax register to bx
            inc si
        loop GO
        ; for the last digit, to add it to the number
        mov dx, 0
        mov dl, [si+2]
        sub dl, '0' ; to get the real number and not the ascii value
        add bx, dx  ; the real number is in register bx
        DONE:
            pop  dx ; pull out the IP in the stack
            push bx ; to save the number in the stack
            push dx ; push back to the stack the IP that it will return to the point in the main it called
            ret
    PROC_STRING_TO_NUM ENDP

    ; find the max number between 2 numbers
    PROC_FIND_MAX PROC
        cmp cx, bx
        jae FINISH ; if cx value bigger or equal to bx value, jump to finish
        ; if cx lower then cx, then flip bx value to cx value and cx value to bx value
        push cx
        mov cx, bx
        pop bx
        FINISH:
            ; check that the denominator of a number is not zero
            cmp bx, 0
            je TO_THE_END ; if the denominator is zero, End the prog
            ret
    PROC_FIND_MAX ENDP

    PROC_PRINT_NUM PROC
        push dx ; to save the real remainder of the real number
        mov bx, 0
        mov cx, 0
        mov dx, 0

        DIVIDE:
            cmp ax, 0 ; when ax (the dose) will be 0 then start print
            je PRINT
            
            mov bx, 10
            div bx

            push dx

            inc cx ; to know the length of the number
            mov dx, 0
            jmp DIVIDE ; jump back to the DIVIDE tag until the dose will be 0
        
        PRINT:
            cmp cx, 0 ; if the number have zero length
            je FINISH2

            pop dx
            add dx, '0'
            
            ; print the char number
            mov ah, 02
            int 21H

            dec cx
            jmp PRINT
        FINISH2:
            pop dx
            ret
    PROC_PRINT_NUM ENDP

END start
