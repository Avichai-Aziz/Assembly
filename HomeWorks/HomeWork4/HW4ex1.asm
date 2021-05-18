;HW4ex1.asm
; A program that receives text into a string (not initialized).
; The program will go over the string and replace each downcast letter with a uppercast one.
; All other chars will remain unchanged.
; The string should be printed after the change, in a separate line.
.MODEL	SMALL
.STACK	20
.DATA
	string 	 	db 20, ?, 20 dup('$')
	new_line 	db 0DH, 0AH, '$'

.CODE
	start:    
	    	mov 	ax, @DATA
	    	mov 	ds, ax
	;----------------the code itself begins here------------------
            
        	;getting input
	    	mov 	ah, 0AH
	    	lea 	dx, string
		int 	21H
		
		mov 	si, dx
	    	mov 	cx, [si+1] ; si+1 is the real size of the input
		mov 	ch, 0		; cause the ch is the value of the first char in the string

	    CHANGE:
		mov 	al, [si+2]	; plus 2 to get the first char in the string
	        cmp 	al, 'a' 	; check if the char is lower then 'a'
	        jl 	NEXT_CHAR 	; if true, then jmp to the next char 'z'
	        cmp 	al, 'z' 	; check if the char is bigger then 'z'
	        jg 	NEXT_CHAR 	; if true, then jmp to the next chari) to get the upcase of this char
	        sub 	al, 32  	; else, sub 32 from the char (ascii) to get the upcase of this char
	        NEXT_CHAR:
			mov 	[si+2], al
			inc 	si
	    loop CHANGE

		; print new line
		mov 	ah, 9
		lea dx, new_line
		int 	21H
		; print the string
		mov 	ah, 9
		mov 	dx, 2 ; to print from index 2 of the string(the 0 and 1 index is the size and the actually size of string)
		int 	21H

	;end program
	mov	ah, 4ch
	mov	al, 0
	int	21H
END start
