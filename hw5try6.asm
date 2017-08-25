; Lily Shellhammer
; shellhal@oregonstate.edu
; 2/28/16
; Description: This program asks the user to input a number n between 10 and 200 and then prints out an
; array of n random numbers, displays the median, and then sorts the random integer array and outputs
; the sorted array to the screen


.data
MAX				EQU		<200>
MIN 			EQU 	<10>
instro 			BYTE	"Sorted Array 					by Lily Shellhammer",0
intro2 			BYTE	"This program will accept a number from the user and print an array of that size with random integers, return the median value, and then sort the array and print it to the screen",0
instructions	BYTE	"Enter a number between 10 and 200: ", 0
request			DWORD	?
error_valid		BYTE	"Error! That number was not in the correct range. Re-enter a number: ",0
array 			DWORD	200 DUP(?)
median 			DWORD	0
med 			BYTE	"The median of your numbers is: ",0


	;main: calls functions introduction, validate (input), get_data (for array), fill_array(with
	;random numbers), print_data (unsorted), get_median, and print_data (sorted, except in this try
	;prog it hasn't been sorted yet)

main PROC
	call 	introduction     ; call intro
	call 	validate		 ; validate input from user (between min and max)
	push 	OFFSET request
	call 	get_data         ;call fn get array data, pass request by reference
	push	OFFSET array
	push 	request
	call 	fill_array		;call fn fill array with random numbers, pass array by ref, request by val
	push	OFFSET array
	push 	request
	call 	print_data      ;call fn print array to screen, pass array by ref, request by val
	push 	OFFSET array
	push 	OFFSET array
	push 	request
	call 	sort_array 		;call sort_array sorts array in decrementing order, pass array by ref, request by val
	push 	request
	call 	get_median      ;call fn get median, pass array by ref, request by val
	push	OFFSET array
	push 	request
	call 	print_data      ;call fn print array to screen, pass array by ref, request by val

main ENDP

	;introduction: introduces the user to the name and what the program is about to do
introduction PROC
	mov		edx, OFFSET intro
	call	WriteString
	call	Crlf
	mov		edx, OFFSET intro2
	call	WriteString
	call	Crlf
introduction ENDP


	;get_data: This function gets a number from the user, checks if its in correct range, and saves correct
	;"request" number from user in [edi] (we used pass by ref)
get_data PROC
		push 	ebp
		mov		ebp, esp
		mov		[ebp + 8], edi
		mov		edx, OFFSET instructions
		call	WriteString
		call	ReadInt
		stosd
		jmp		checkBlock
	checkBlock:				;this block loops every time user enters new info to check if its good
		cmp		eax, MIN
		jl		errorBlock
		cmp		eax, MAX     ;IF NUMBER IS IN EAX CAN I COMPARE THERE AND JUST EDIT EDI, NOT COMPARE FROM EDI
		jg		errorBlock
		jmp		done
	errorBlock:					;this block is called when input is bad, loops back to checkBlock
		mov		edx, OFFSET error_valid
		call 	WriteString
		call	ReadInt
		mov		[ebp + 8], edi
		stosd                ;same as   mov eax,[edi]
		jmp		checkBlock      ;jumps to checkBlock, new input in number and eax
	done:
		pop 	ebp
		ret 	8
get_data ENDP

	;fill_array: This function fills the array (up until size) with random numbers
	;before this fn, OFFSET array is pushed and then request is pushed
	;HOW DO I MAKE AN ARRAY AFTER THE USER ENTERS HOW BIG IT IS? JUST 200 AND ONLY FILL UP WHAT YOU NEED?
fill_array PROC
	call 	Randomize
	push 	ebp
	mov		ebp, esp
	pushad
	mov 	esi, [ebp + 12]
	mov		ecx, [edp + 8]
loop1:
	mov		eax, MAX
	sub		eax, MIN
	inc 	eax
	call 	RandomRange
	add		eax, MIN
	stosd
	add		esi, TYPE DWORD
	loop 	loop1
done:
	popad
	pop 	ebp
	ret 	8
fill_array ENDP

	;sort_array:this function
sort_array PROC
	push 	ebp
	mov		ebp, esp
	mov		esi, [ebp + 12]
	mov		eax, [ebp + 8]
sort_array ENDP


	;get_median: This function adds up all the numbers in our array and divides
get_median PROC
	push 	ebp
	mov		ebp, esp
	mov		esi, [ebp + 12]
	cdq
	mov		eax, [ebp + 8]
	idiv 	2
	cmp 	edx, 0
	je		run
	inc 	eax
run:
	mov		ecx, eax
L1:
	lodsd
	add		esi, TYPE DWORD
	loop 	L1

	mov		edx, OFFSET med
	call 	WriteString
	mov		eax, [esi]
	call 	WriteDec

	pop 	ebp
	ret 	8
get_median ENDP

print_data PROC
	push 	ebp
	mov		ebp, esp
	mov		esi, [ebp + 12]
	mov		ecx, [ebp + 8]
	mov		eax, 0
	mov		ebx, 0
L1:
	lodsd
	call 	WriteDec
	add		esi, TYPE DWORD
	inc 	ebx
	cmp 	ebx, 10
	je		reset_loop
looploop:
	loop L1
reset_loop:
	call 	Crlf
	mov		ebx, 0
	jmp 	looploop

done:
	pop 	ebp
	ret 	8
print_data ENDP


END main
