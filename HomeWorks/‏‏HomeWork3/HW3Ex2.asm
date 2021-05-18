;HW3Ex2.asm
; A program that displays the number as a mirror number
; The output can be shown in the debug - NOT at the standard out
.MODEL SMALL
.STACK	64
.DATA
num	dw	1234
revnum	dw	0
var	dw	0
ten	dw	10

.CODE
start:
	mov	ax, @data
	mov	ds, ax
	
	mov 	ax, num ; num = 1234
	mov	cx, 3 	; loop 3 times
	
    rev: ;reverse
		mov 	dx, 0
		div 	ten
		
		add	revnum, dx 	; add the remainder
		mov	var, ax
		
		mov	ax, revnum 	; revnum = 4
		
		mul	ten
		mov	revnum, ax 	; revnum = 40
		mov 	ax, var		; var = 123
     	
		loop	rev
		
		add 	revnum, ax ; ax = 1
		; revnum = 4321
	
	;end the program
	mov	ah, 4ch
	mov	al, 0
	int	21H
endcode:
END start
