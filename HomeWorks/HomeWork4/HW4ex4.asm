;HW4ex4.asm
; A program that receives from the user 10 strings (one string at a time), which constitute an email address.
; For each string, the program will check if the @ character appears exactly once
; And print an appropriate message.
; If the @ character did not appear at all or appeared more than once, it should be printed
; Error message and move on to the next string.
.MODEL	SMALL
.STACK	20
.DATA
	string 	    db	50, ? , 50 dup('$')
    	ok          db  "Currect input", '$'
    	error       db  "Error, string must have exactly one '@'", '$'
    	new_line    db  0DH, 0AH, '$' 


.CODE
	start:    
	    mov  ax, @DATA
	    mov  ds, ax
	;----------------the code itself begins here------------------
       
        mov cx, 10 ; to get 10 strings from the user
       
       GO:
        ;getting input
        call PROC_GET_STRING
        ; print new line
        call PROC_NEW_LINE

        ; check if '@' apear in the string
        call PROC_CHECK_INPUT 
        ; print new line
        call PROC_NEW_LINE
        loop GO

	;end program
	mov	ah, 4ch
	mov	al, 0
	int	21H

    ; print new line
    PROC_NEW_LINE PROC
        mov ah, 9
        lea dx, new_line
        int 21H
        ret
    PROC_NEW_LINE ENDP

    ; getting string from user
    PROC_GET_STRING PROC 
        mov ah, 0AH
        lea dx, string
        int 21H
        mov si, dx
        ret
    PROC_GET_STRING ENDP 
        
    ; print error message
    PROC_ERROR_MESSAGE PROC
        mov ah, 9
        lea dx, error
        int 21H
        ret
    PROC_ERROR_MESSAGE ENDP

    ; print correct message
    PROC_CORRECT_MESSAGE PROC
        mov ah, 9
        lea dx, ok
        int 21H
        ret
    PROC_CORRECT_MESSAGE ENDP

    ; check numeber of time '@' char apear in the string
    PROC_CHECK_INPUT PROC
        push cx         ; to save the cx value of the main proc - the number of strings user input
        mov cx, [si+1]  ; the length of the string 
        mov	 ch, 0	    ; cause the ch is the value of the first char in the string


        mov bx, 0   ; to count the number of time @ apear in the string
        SEARCH:
            mov al, [si+2]
            cmp al, '@' ; check if the char is @
            je  ADD_ONE ; if true, increment bx register by 1
            jmp NEXT_CHAR ; else, moving to the next char
            ADD_ONE:
                add bx, 1
            NEXT_CHAR:
                inc si
        loop SEARCH

        cmp bl, 1
        jg ERROR_INPUT  ; if the number of times bigger then 1, jump to error message proc
        cmp bl, 1
        jl  ERROR_INPUT ; if the number of times lower then 1, jump to error message proc
        CORRECT_INPUT:  ; else, its correct input, jmp to correct proc
            call PROC_CORRECT_MESSAGE
            jmp FINISH
        ERROR_INPUT:
            call PROC_ERROR_MESSAGE
        FINISH:
            pop cx
            ret
    PROC_CHECK_INPUT ENDP

END start
