;HW3Ex1.asm
; A program that defines two arrays 'a', 'b' that contain 10 numbers each size of a word each.
; mulArray - will get the multiplication results - each number in the first array 'a' is multiplied by the number corresponding to it in the second array b.
; qArray - will get the dose results of dividing each number by 'a' by a number corresponding to it by 'b'.
; rArrray - will get the remainder results of a division between each number in 'a' and a number corresponding to it in 'b'.
; It must be assumed that array b has no values equal to 0.
; The output can be shown in the debug - NOT at the standard out
.MODEL SMALL
.STACK	64
.DATA
a 		dw 	20, 5, 12, 0, -2, 3, 300, 10, 4, 1  ; size 10
b		dw 	2, 3, 4, 5, 2, 2, 2, 2, 2, 2 	; size 10
mulArray 	dw	10 dup (?)
qArray	 	dw	10 dup (?)
rArray 		dw	10 dup (?)

.CODE
start:
	mov	ax, @data
	mov	ds, ax
	; init the pointer registers to the begining of the arrays
	lea	si, a
	lea	di, b
	lea	bp, mulArray
	mov	cx, 10 	; loop 10 times
	
    calc: ;calculation
		; mulArray
		mov 	ax, [si]
		mov	bx, [di]
		imul	bx
		mov	ds:[bp], ax
		; qArray
		mov 	ax, [si]
		mov	bx, [di]
		idiv	bx
		mov	ds:[bp+20], ax ; move the bp register pointer to the next array - qArray
		; rArray
		mov	ds:[bp+40], dx ; same as above - rArray, the modulo enter to the dx register
		; promoting the addresses of all the pointer registers by 2
     	add	si, 2
	add 	di, 2
     	add	bp, 2
     	loop	calc
	
	;end the program
	mov	ah, 4ch
	mov	al, 0
	int	21H
endcode:
END start
