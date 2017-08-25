;i need help
; Lily Shellhammer
; shellhal@oregonstate.edu
; Homework 4
; 2/14/16


.data
	title			BYTE	"Composite Numbers           by Lily Shellhammer",0
	instructions	BYTE	"Instructions go here",0
	prompt			BYTE	"Enter the number of composites to display [1-400]: ",0
	error_mssg		BYTE	"Error. Out of range, try again."
	number 			DWORD	?

.code
main PROC

;program title and programmers name printed
;counting loop from 1 to n
;readable "list" of what program will do
;each procedure will precity how the logic of its section is implemented
; MODULARIZED INTO
	; intro
	;getUserData
		;validate
	;showComposites
		isComposite
	;farewell

main ENDP


instruction PROC
	;program title and programmers name printed
		mov		edx, title
		call	WriteString
		call 	Crlf
	;instructions displayed
		mov		edx, instructions
		call	WriteString
		call	Crlf
		ret
instruction ENDP

getUserData PROC
	;get user number
	mov		edx, prompt
	call	WriteString
	call	ReadDec
	mov		number, eax

	;SUBPROCEDURE: validate
	ret
getUserData ENDP

showComposites PROC
	;SUBROUTINE is composite
	;show composites
	ret
showComposites ENDP

farewell PROC
	;say goodbye
	ret
farewell ENDP

END main