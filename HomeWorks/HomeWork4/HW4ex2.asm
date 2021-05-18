;HW4ex2.asm
; A program that receives text into a string (not initialized),
; The program will print only the digits from the input string.
.MODEL	SMALL
.STACK	20
.DATA
	string 	 	db 20, ?, 20 dup('$')
	new_line 	db 0DH, 0AH, '$'

.CODE
	start:    
	    mov  ax, @DATA
	    mov  ds, ax
	;----------------the code itself begins here------------------
            
        ;getting input
        mov ah, 0AH
        lea dx, string
        int 21H

        mov si, dx
        mov cx, [si+1]
        mov ch, 0

        ; print new line
        mov ah, 09
        lea dx, new_line
        int 21H

        PRINT_NUM:
            mov al, [si+2]
            sub al, '0' ; sub '0' to get the number it self and not the ascii value
            cmp al, 0
            jl  NEXT_CHAR
            cmp al, 9
            jg  NEXT_CHAR

            add al, '0' ; add '0' to get the ascii value to print it

            ; print the number
            mov ah, 02
            mov dl, al
            int 21H            

            NEXT_CHAR:
                inc si
                mov ah, 0

        loop PRINT_NUM


	;end program
	mov	ah, 4ch
	mov	al, 0
	int	21H
END start
