	.equ SWI_Exit, 0x11
	.equ DisplayChar, 0x207
	.equ DisplayString, 0x204
	.equ DisplayInt, 0x205
	.equ SWI_CheckBlue, 0x203
	.equ BLUE_KEY_00, 0x01 @button(0)
	.equ BLUE_KEY_01, 0x02 @button(1)
	.equ BLUE_KEY_02, 0x04 @button(2)
	.equ BLUE_KEY_03, 0x08 @button(3)
	.equ BLUE_KEY_04, 0x10 @button(4)
	.equ BLUE_KEY_05, 0x20 @button(5)
	.equ BLUE_KEY_06, 0x40 @button(6)
	.equ BLUE_KEY_07, 0x80 @button(7)
	.equ BLUE_KEY_08, 1<<8 @button(8) - different way to set

	.text


Valid_Pseudo:
	@r3 is y, r4 is x
	mov r0, #32
	mul r12, r4, r0
	mov r0, #4
	mul r7, r3, r0
	add r12, r12, r7
	ldr r0, =ARR
	add r10, r12, r0 @r10 stores current position 
	ldr r0, [r0, r12]
	mov r5, #0 @total
	cmp r0, #0
	bne Pseudo_CheckValid
		
	Pseudo_CheckUp:
		mov r6, r3 @q
		mov r7, r4 @p
		cmp r4, #1
		ble Pseudo_CheckDown
		@ldr r0, =ARR
		ldr r0, [r10, #-32]
		cmp r0, r9
		beq Pseudo_CheckDown
		cmp r0, #0
		beq Pseudo_CheckDown
		cmp r0, #3
		beq Pseudo_CheckDown

		Pseudo_WhileUp:
		ldr r0, [r10, #-32]
		cmp r0, r9
		beq ExitPseudo_WhileUp
		cmp r0, #0
		beq ExitPseudo_WhileUp
		cmp r0, #3
		beq ExitPseudo_WhileUp
		cmp r7, #1
		ble ExitPseudo_WhileUp
		sub r7, r7, #1
		sub r10, r10, #32
		b Pseudo_WhileUp

		ExitPseudo_WhileUp:
		sub r7, r7, #1 
		sub r10, r10, #32
		ldr r0, [r10]
		cmp r0, r9
		bne Pseudo_CheckDown
		add r7, r7, #1 @r7 is p+1
		add r10, r10, #32 @r10 is arr[p+1][y]
		sub r5, r5, r7
		add r5, r5, r4

	Pseudo_CheckDown:
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r4, #6
		bge Pseudo_CheckLeft
		@ldr r0, =ARR
		ldr r0, [r10, #32]
		cmp r0, r9
		beq Pseudo_CheckLeft
		cmp r0, #0
		beq Pseudo_CheckLeft
		cmp r0, #3
		beq Pseudo_CheckLeft
		Pseudo_WhileDown:
		ldr r0, [r10, #32]
		cmp r0, r9
		beq ExitPseudo_WhileDown
		cmp r0, #0
		beq ExitPseudo_WhileDown
		cmp r0, #3
		beq ExitPseudo_WhileDown
		cmp r7, #6
		bge ExitPseudo_WhileDown
		add r7, r7, #1
		add r10, r10, #32
		b Pseudo_WhileDown

		ExitPseudo_WhileDown:
		add r7, r7, #1 
		add r10, r10, #32
		ldr r0, [r10]
		cmp r0, r9
		bne Pseudo_CheckLeft
		sub r7, r7, #1 @r7 is p-1
		sub r10, r10, #32 @r10 is arr[p-1][y]
		sub r5, r5, r4
		add r5, r5, r7		

	Pseudo_CheckLeft:
		
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 
		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #1
		ble Pseudo_CheckRight
		@ldr r0, =ARR
		ldr r0, [r10, #-4]
		cmp r0, r9
		beq Pseudo_CheckRight
		cmp r0, #0
		beq Pseudo_CheckRight
		cmp r0, #3
		beq Pseudo_CheckRight

		Pseudo_WhileLeft:
		ldr r0, [r10, #-4]
		cmp r0, r9
		beq ExitPseudo_WhilLeft
		cmp r0, #0
		beq ExitPseudo_WhilLeft
		cmp r0, #3
		beq ExitPseudo_WhilLeft
		cmp r6, #1
		ble ExitPseudo_WhilLeft
		sub r6, r6, #1
		sub r10, r10, #4
		b Pseudo_WhileLeft

		ExitPseudo_WhilLeft:
		sub r6, r6, #1 
		sub r10, r10, #4
		ldr r0, [r10]
		cmp r0, r9
		bne Pseudo_CheckRight
		add r6, r6, #1 @r6 is q+1
		add r10, r10, #4 @r10 is arr[p+1][y]
		sub r5, r5, r6
		add r5, r5, r3

		

	Pseudo_CheckRight:
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #6
		bge Pseudo_CheckUL
		@ldr r0, =ARR
		ldr r0, [r10, #4]
		cmp r0, r9
		beq Pseudo_CheckUL
		cmp r0, #0
		beq Pseudo_CheckUL
		cmp r0, #3
		beq Pseudo_CheckUL

		Pseudo_WhileRight:
		ldr r0, [r10, #4]
		cmp r0, r9
		beq ExitPseudo_WhileRight
		cmp r0, #0
		beq ExitPseudo_WhileRight
		cmp r0, #3
		beq ExitPseudo_WhileRight
		cmp r6, #6
		bge ExitPseudo_WhileRight
		add r6, r6, #1
		add r10, r10, #4
		b Pseudo_WhileRight

		ExitPseudo_WhileRight:
		add r6, r6, #1 
		add r10, r10, #4
		ldr r0, [r10]
		cmp r0, r9
		bne Pseudo_CheckUL
		sub r6, r6, #1 @r6 is q-1
		sub r10, r10, #4 @r10 is arr[x][q-1]
		sub r5, r5, r3
		add r5, r5, r6

		

	Pseudo_CheckUL:
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #1
		ble Pseudo_CheckDR
		cmp r4, #1
		ble Pseudo_CheckDR
		@ldr r0, =ARR
		ldr r0, [r10, #-36]
		cmp r0, r9
		beq Pseudo_CheckDR
		cmp r0, #0
		beq Pseudo_CheckDR
		cmp r0, #3
		beq Pseudo_CheckDR

		Pseudo_WhileUL:
		ldr r0, [r10, #-36]
		cmp r0, r9
		beq ExitPseudo_WhileUL
		cmp r0, #0
		beq ExitPseudo_WhileUL
		cmp r0, #3
		beq ExitPseudo_WhileUL
		cmp r6, #1
		ble ExitPseudo_WhileUL
		cmp r7, #1
		ble ExitPseudo_WhileUL
		sub r6, r6, #1
		sub r7, r7, #1
		sub r10, r10, #36
		b Pseudo_WhileUL

		ExitPseudo_WhileUL:
		sub r6, r6, #1 
		sub r7, r7, #1
		sub r10, r10, #36

		ldr r0, [r10]
		cmp r0, r9
		bne Pseudo_CheckDR
		add r6, r6, #1 @r6 is q+1
		add r7, r7, #1 @r7 is p+1
		add r10, r10, #36 @r10 is arr[p+1][q+1]
		sub r5, r5, r6
		add r5, r5, r3

		

	Pseudo_CheckDR:
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #6
		bge Pseudo_CheckUR
		cmp r4, #6
		bge Pseudo_CheckUR
		@ldr r0, =ARR
		ldr r0, [r10, #36]
		cmp r0, r9
		beq Pseudo_CheckUR
		cmp r0, #0
		beq Pseudo_CheckUR
		cmp r0, #3
		beq Pseudo_CheckUR

		Pseudo_WhileDR:
		ldr r0, [r10, #36]
		cmp r0, r9
		beq ExitPseudo_WhileDR
		cmp r0, #0
		beq ExitPseudo_WhileDR
		cmp r0, #3
		beq ExitPseudo_WhileDR
		cmp r6, #6
		bge ExitPseudo_WhileDR
		cmp r7, #6
		bge ExitPseudo_WhileDR
		add r6, r6, #1
		add r7, r7, #1
		add r10, r10, #36
		b Pseudo_WhileDR

		ExitPseudo_WhileDR:
		add r6, r6, #1 
		add r7, r7, #1
		add r10, r10, #36

		ldr r0, [r10]
		cmp r0, r9
		bne Pseudo_CheckUR
		sub r6, r6, #1 @r6 is q-1
		sub r7, r7, #1
		sub r10, r10, #36 @r10 is arr[p-1][q-1]
		sub r5, r5, r3
		add r5, r5, r6

		
	Pseudo_CheckUR:

		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #6
		bge Pseudo_CheckDL
		cmp r4, #1
		ble Pseudo_CheckDL
		@ldr r0, =ARR
		ldr r0, [r10, #-28]
		cmp r0, r9
		beq Pseudo_CheckDL
		cmp r0, #0
		beq Pseudo_CheckDL
		cmp r0, #3
		beq Pseudo_CheckDL

		Pseudo_WhileUR:
		ldr r0, [r10, #-28]
		cmp r0, r9
		beq ExitPseudo_WhileUR
		cmp r0, #0
		beq ExitPseudo_WhileUR
		cmp r0, #3
		beq ExitPseudo_WhileUR
		cmp r6, #6
		bge ExitPseudo_WhileUR
		cmp r7, #1
		ble ExitPseudo_WhileUR
		add r6, r6, #1
		sub r7, r7, #1
		sub r10, r10, #28
		b Pseudo_WhileUR

		ExitPseudo_WhileUR:
		add r6, r6, #1 
		sub r7, r7, #1
		sub r10, r10, #28

		ldr r0, [r10]
		cmp r0, r9
		bne Pseudo_CheckDL
		sub r6, r6, #1 @r6 is q-1
		add r7, r7, #1
		add r10, r10, #28 @r10 is arr[p+1][q-1]
		sub r5, r5, r3
		add r5, r5, r6

		
	Pseudo_CheckDL:

		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r4, #6
		bge Pseudo_CheckValid
		cmp r3, #1
		ble Pseudo_CheckValid
		@ldr r0, =ARR
		ldr r0, [r10, #28]
		cmp r0, r9
		beq Pseudo_CheckValid
		cmp r0, #0
		beq Pseudo_CheckValid
		cmp r0, #3
		beq Pseudo_CheckValid



		Pseudo_WhileDL:
		ldr r0, [r10, #28]
		cmp r0, r9
		beq ExitPseudo_WhileDL
		cmp r0, #0
		beq ExitPseudo_WhileDL
		cmp r0, #3
		beq ExitPseudo_WhileDL
		cmp r7, #6
		bge ExitPseudo_WhileDL
		cmp r6, #1
		ble ExitPseudo_WhileDL
		sub r6, r6, #1
		add r7, r7, #1
		add r10, r10, #28
		b Pseudo_WhileDL

		ExitPseudo_WhileDL:
		sub r6, r6, #1 
		add r7, r7, #1
		add r10, r10, #28

		ldr r0, [r10]
		cmp r0, r9
		bne Pseudo_CheckValid
		add r6, r6, #1 @r6 is q+1
		sub r7, r7, #1
		sub r10, r10, #28 @r10 is arr[p-1][q+1]
		add r5, r5, r3
		sub r5, r5, r6

		

	Pseudo_CheckValid:
		cmp r5, #0
		
		beq Re_Loop_Valid_Check	
		ldr r0, =ARR
		mov r2, #3 
		str r2, [r0, r12] 
		add r8, r8, #1
		mov r2, #2
		mov r1, r4
		add r1, r1, #1
		mul r0, r3, r2
		add r0, r0, #13
		mov r2, #'X
		swi DisplayChar

		b Re_Loop_Valid_Check
		
Assigner:
	
	cmp r0,#BLUE_KEY_08
	beq EIGHT
	cmp r0,#BLUE_KEY_07
	beq SEVEN
	cmp r0,#BLUE_KEY_06
	beq SIX
	cmp r0,#BLUE_KEY_05
	beq FIVE
	cmp r0,#BLUE_KEY_04
	beq FOUR
	cmp r0,#BLUE_KEY_03
	beq THREE
	cmp r0,#BLUE_KEY_02
	beq TWO
	cmp r0,#BLUE_KEY_01
	beq ONE
	cmp r0,#BLUE_KEY_00
	beq ZERO
	EIGHT:
	mov r0, #8
	b Back
	SEVEN:
	mov r0, #7
	b Back
	SIX:
	mov r0, #6
	b Back
	FIVE:
	mov r0, #5
	b Back
	FOUR:
	mov r0, #4
	b Back
	THREE: 
	mov r0, #3
	b Back
	TWO:
	mov r0, #2
	b Back
	ONE:
	mov r0, #1
	b Back
	ZERO:
	mov r0, #0
	b Back

	Back: mov pc, lr

Reset:
	mov r1, #2
	ldr r0, =P1
	str r1,[r0]
	ldr r0, =P2	
	str r1,[r0]

	ldr r2, =ARR
	mov r1, #0
	mov r0, #0
	LoopR:
		str r1, [r2]
		add r0, r0, #1
		cmp r0, #64
		addne r2, r2, #4
		bne LoopR

	ldr r2, =ARR
	add r2, r2, #108
	mov r1, #2
	str r1, [r2]

	add r2, r2, #4
	mov r1, #1
	str r1, [r2]

	add r2, r2, #28
	mov r1, #1
	str r1, [r2]

	mov r1, #4
	add r2, r2, r1
	mov r1, #2
	str r1, [r2]

	ldr r2, =ARR
	mov pc, lr

MoveExists:
	mov r8, #0
	ldr r0, =ARR	
	mov r3, #0
	mov r4, #0
	stmfd sp!, {r0, r3, r4}

	Loop_Valid_Check:
	ldmfd sp!, {r0, r3, r4}
	ldr r1, [r0]
	cmp r1, #0
	stmfd sp!, {r0, r3, r4}
	bne Re_Loop_Valid_Check	
	b Valid_Pseudo

	Re_Loop_Valid_Check:
	ldmfd sp!, {r0, r3, r4}
	add r0, r0, #4
	cmp r3, #7
	bne NotSeven
	mov r3, #0
	cmp r4, #7
	beq Full
	add r4,r4, #1
	stmfd sp!, {r0, r3, r4}
	b Loop_Valid_Check
	

	NotSeven:
	add r3, r3, #1
	stmfd sp!, {r0, r3, r4}
	ldr r0, =P1
	ldr r3, [r0]
	cmp r3, #0
	beq Next
	ldr r0, =P2
	ldr r4, [r0]
	cmp r4, #0
	beq Next
	add r3, r3, r4
	cmp r3, #64
	beq Next
	b Loop_Valid_Check

	Full:
	mov pc, lr


ThreeToZero:
	
	ldr r10, =ARR
	mov r1, #1
	mov r0, #13
	mov r2, #0 @ZERO
	mov r5, #0 @count

	LoopRZero:
		ldr r11, [r10]
		cmp r11, #3
		bne NoChange
		str r2, [r10]		
		swi DisplayInt

		NoChange:
		add r5, r5, #1
		cmp r0, #27
		bge EndReached
		add r0, r0, #2
		BackfromEndReached:
		cmp r5, #64
		addne r10, r10, #4
		bne LoopRZero
		beq ZeroDone

		NextRow:
		add r1, r1, #1
		b BackfromEndReached


		EndReached:
		mov r0, #13
		cmp r1, #8
		ble NextRow


	mov r0, #0
	b ZeroDone

NoValidMoves:
	mov r5, #1
	b Returned



Valid:
	mov r1, #14
	mov r0, #20
	ldr r2, =PassedBlank	
	swi DisplayString
	b ThreeToZero
	ZeroDone:
	@stmfd sp!, {r5-r11}
	@r3 is y, r4 is x
	mov r0, #32
	mul r12, r4, r0
	mov r0, #4
	mul r7, r3, r0
	add r12, r12, r7
	ldr r0, =ARR
	add r10, r12, r0 @r10 stores current position 
	ldr r0, [r0, r12]
	mov r5, #0 @total
	cmp r0, #0
	bne CheckValid
	
	
	CheckUp:
		mov r6, r3 @q
		mov r7, r4 @p
		cmp r4, #1
		ble CheckDown
		ldr r0, =ARR
		ldr r0, [r10, #-32]
		cmp r0, r9
		beq CheckDown
		cmp r0, #0
		beq CheckDown

		WhileUp:
		ldr r0, [r10, #-32]
		cmp r0, r9
		beq ExitWhileUp
		cmp r0, #0
		beq ExitWhileUp
		cmp r7, #1
		ble ExitWhileUp
		sub r7, r7, #1
		sub r10, r10, #32
		b WhileUp

		ExitWhileUp:
		sub r7, r7, #1 
		sub r10, r10, #32
		ldr r0, [r10]
		cmp r0, r9
		bne CheckDown
		add r7, r7, #1 @r7 is p+1
		add r10, r10, #32 @r10 is arr[p+1][y]
		sub r5, r5, r7
		add r5, r5, r4

		@r7 is z here as it is currently p+1
		ForUP:
		cmp r7, r4
		bge CheckDown
		str r9, [r10]
		mov r2, #2
		mov r1, r7
		add r1, r1, #1
		mul r0, r6, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt
		add r7, r7, #1
		add r10, r10, #32
		b ForUP

	CheckDown:
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r4, #6
		bge CheckLeft
		ldr r0, =ARR
		ldr r0, [r10, #32]
		cmp r0, r9
		beq CheckLeft
		cmp r0, #0
		beq CheckLeft

		WhileDown:
		ldr r0, [r10, #32]
		cmp r0, r9
		beq ExitWhileDown
		cmp r0, #0
		beq ExitWhileDown
		cmp r7, #6
		bge ExitWhileDown
		add r7, r7, #1
		add r10, r10, #32
		b WhileDown

		ExitWhileDown:
		add r7, r7, #1 
		add r10, r10, #32
		ldr r0, [r10]
		cmp r0, r9
		bne CheckLeft
		sub r7, r7, #1 @r7 is p-1
		sub r10, r10, #32 @r10 is arr[p-1][y]
		sub r5, r5, r4
		add r5, r5, r7

		@r7 is z here as it is currently p-1
		ForDOWN:
		cmp r7, r4
		ble CheckLeft
		str r9, [r10]
		mov r2, #2
		mov r1, r7
		add r1, r1, #1
		mul r0, r6, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt
		sub r7, r7, #1
		sub r10, r10, #32
		b ForDOWN


	CheckLeft:
		
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #1
		ble CheckRight
		ldr r0, =ARR
		ldr r0, [r10, #-4]
		cmp r0, r9
		beq CheckRight
		cmp r0, #0
		beq CheckRight

		WhileLeft:
		ldr r0, [r10, #-4]
		cmp r0, r9
		beq ExitWhilLeft
		cmp r0, #0
		beq ExitWhilLeft
		cmp r6, #1
		ble ExitWhilLeft
		sub r6, r6, #1
		sub r10, r10, #4
		b WhileLeft

		ExitWhilLeft:
		sub r6, r6, #1 
		sub r10, r10, #4
		ldr r0, [r10]
		cmp r0, r9
		bne CheckRight
		add r6, r6, #1 @r6 is q+1
		add r10, r10, #4 @r10 is arr[p+1][y]
		sub r5, r5, r6
		add r5, r5, r3

		@r6 is z here as it is currently q+1
		ForLEFT:
		cmp r6, r3
		bge CheckRight
		str r9, [r10]
		mov r2, #2
		mov r1, r7
		add r1, r1, #1
		mul r0, r6, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt
		add r6, r6, #1
		add r10, r10, #4
		b ForLEFT


	CheckRight:
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #6
		bge CheckUL
		ldr r0, =ARR
		ldr r0, [r10, #4]
		cmp r0, r9
		beq CheckUL
		cmp r0, #0
		beq CheckUL

		WhileRight:
		ldr r0, [r10, #4]
		cmp r0, r9
		beq ExitWhileRight
		cmp r0, #0
		beq ExitWhileRight
		cmp r6, #6
		bge ExitWhileRight
		add r6, r6, #1
		add r10, r10, #4
		b WhileRight

		ExitWhileRight:
		add r6, r6, #1 
		add r10, r10, #4
		ldr r0, [r10]
		cmp r0, r9
		bne CheckUL
		sub r6, r6, #1 @r6 is q-1
		sub r10, r10, #4 @r10 is arr[x][q-1]
		sub r5, r5, r3
		add r5, r5, r6

		@r6 is z here as it is currently q-1
		ForRIGHT:
		cmp r6, r3
		ble CheckUL
		str r9, [r10]
		mov r2, #2
		mov r1, r7
		add r1, r1, #1
		mul r0, r6, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt
		sub r6, r6, #1
		sub r10, r10, #4
		b ForRIGHT		

	CheckUL:
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #1
		ble CheckDR
		cmp r4, #1
		ble CheckDR
		ldr r0, =ARR
		ldr r0, [r10, #-36]
		cmp r0, r9
		beq CheckDR
		cmp r0, #0
		beq CheckDR

		WhileUL:
		ldr r0, [r10, #-36]
		cmp r0, r9
		beq ExitWhileUL
		cmp r0, #0
		beq ExitWhileUL
		cmp r6, #1
		ble ExitWhileUL
		cmp r7, #1
		ble ExitWhileUL
		sub r6, r6, #1
		sub r7, r7, #1
		sub r10, r10, #36
		b WhileUL

		ExitWhileUL:
		sub r6, r6, #1 
		sub r7, r7, #1
		sub r10, r10, #36

		ldr r0, [r10]
		cmp r0, r9
		bne CheckDR
		add r6, r6, #1 @r6 is q+1
		add r7, r7, #1 @r7 is p+1
		add r10, r10, #36 @r10 is arr[p+1][q+1]
		sub r5, r5, r6
		add r5, r5, r3

		@r6 is z here as it is currently q+1
		ForUL:
		cmp r6, r3
		bge CheckDR
		str r9, [r10]
		mov r2, #2
		mov r1, r7
		add r1, r1, #1
		mul r0, r6, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt
		add r6, r6, #1
		add r7, r7, #1	
		add r10, r10, #36
		b ForUL

	CheckDR:
		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #6
		bge CheckUR
		cmp r4, #6
		bge CheckUR
		ldr r0, =ARR
		ldr r0, [r10, #36]
		cmp r0, r9
		beq CheckUR
		cmp r0, #0
		beq CheckUR

		WhileDR:
		ldr r0, [r10, #36]
		cmp r0, r9
		beq ExitWhileDR
		cmp r0, #0
		beq ExitWhileDR
		cmp r6, #6
		bge ExitWhileDR
		cmp r7, #6
		bge ExitWhileDR
		add r6, r6, #1
		add r7, r7, #1
		add r10, r10, #36
		b WhileDR

		ExitWhileDR:
		add r6, r6, #1 
		add r7, r7, #1
		add r10, r10, #36

		ldr r0, [r10]
		cmp r0, r9
		bne CheckUR
		sub r6, r6, #1 @r6 is q-1
		sub r7, r7, #1
		sub r10, r10, #36 @r10 is arr[p-1][q-1]
		sub r5, r5, r3
		add r5, r5, r6

		@r6 is z here as it is currently q-1
		ForDR:
		cmp r6, r3
		ble CheckUR
		str r9, [r10]
		mov r2, #2
		mov r1, r7
		add r1, r1, #1
		mul r0, r6, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt
		sub r6, r6, #1
		sub r7, r7, #1
		sub r10, r10, #36
		b ForDR

	CheckUR:

		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r3, #6
		bge CheckDL
		cmp r4, #1
		ble CheckDL
		ldr r0, =ARR
		ldr r0, [r10, #-28]
		cmp r0, r9
		beq CheckDL
		cmp r0, #0
		beq CheckDL

		WhileUR:
		ldr r0, [r10, #-28]
		cmp r0, r9
		beq ExitWhileUR
		cmp r0, #0
		beq ExitWhileUR
		cmp r6, #6
		bge ExitWhileUR
		cmp r7, #1
		ble ExitWhileUR
		add r6, r6, #1
		sub r7, r7, #1
		sub r10, r10, #28
		b WhileUR

		ExitWhileUR:
		add r6, r6, #1 
		sub r7, r7, #1
		sub r10, r10, #28

		ldr r0, [r10]
		cmp r0, r9
		bne CheckDL
		sub r6, r6, #1 @r6 is q-1
		add r7, r7, #1
		add r10, r10, #28 @r10 is arr[p+1][q-1]
		sub r5, r5, r3
		add r5, r5, r6

		@r6 is z here as it is currently q-1
		ForUR:
		cmp r6, r3
		ble CheckDL
		str r9, [r10]
		mov r2, #2
		mov r1, r7
		add r1, r1, #1
		mul r0, r6, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt
		sub r6, r6, #1
		add r7, r7, #1
		add r10, r10, #28
		b ForUR


	CheckDL:

		ldr r0, =ARR
		add r10, r12, r0 @r10 stores current position 

		mov r6, r3 @q
		mov r7, r4 @p
		cmp r4, #6
		bge CheckValid
		cmp r3, #1
		ble CheckValid
		ldr r0, =ARR
		ldr r0, [r10, #28]
		cmp r0, r9
		beq CheckValid
		cmp r0, #0
		beq CheckValid

		WhileDL:
		ldr r0, [r10, #28]
		cmp r0, r9
		beq ExitWhileDL
		cmp r0, #0
		beq ExitWhileDL
		cmp r7, #6
		bge ExitWhileDL
		cmp r6, #1
		ble ExitWhileDL
		sub r6, r6, #1
		add r7, r7, #1
		add r10, r10, #28
		b WhileDL

		ExitWhileDL:
		sub r6, r6, #1 
		add r7, r7, #1
		add r10, r10, #28

		ldr r0, [r10]
		cmp r0, r9
		bne CheckValid
		add r6, r6, #1 @r6 is q+1
		sub r7, r7, #1
		sub r10, r10, #28 @r10 is arr[p-1][q+1]
		add r5, r5, r3
		sub r5, r5, r6

		@r6 is z here as it is currently q-1
		ForDL:
		cmp r6, r3
		bge CheckValid
		str r9, [r10]
		mov r2, #2
		mov r1, r7
		add r1, r1, #1
		mul r0, r6, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt
		add r6, r6, #1
		sub r7, r7, #1
		sub r10, r10, #28
		b ForDL

	CheckValid:
		cmp r5, #0
		beq Back_Valid	
		ldr r0, =ARR
		str r9, [r0, r12] 

		mov r2, #2
		mov r1, r4
		add r1, r1, #1
		mul r0, r3, r2
		add r0, r0, #13
		mov r2, r9
		swi DisplayInt


		cmp r9, #1
		bne Player2
		ldr r0, =P1
		ldr r1, [r0]
		add r1, r1, r5
		add r1, r1, #1
		str r1, [r0]

		ldr r0, =P2
		ldr r1, [r0]
		sub r1, r1, r5
		str r1, [r0]
		b Back_Valid

		Player2:
		ldr r0, =P2
		ldr r1, [r0]
		add r1, r1, r5
		add r1, r1, #1
		str r1, [r0]

		ldr r0, =P1
		ldr r1, [r0]
		sub r1, r1, r5
		str r1, [r0]

		Back_Valid:
		mov pc, lr


	@ldmfd sp!, {r5-r11}

Board:
	@stmfd sp!, {r4-r11}

	mov r11, #1
	mov r0, #13
	LoopI:

		mov r1, #0
		
		mov r2, r11
		swi DisplayInt

		add r0, r0, #2
		add r11, r11, #1
		cmp r11, #9
		bne LoopI

	mov r11, #1
	mov r1, #0
	LoopA:
		mov r0, #0
		add r0, r0, #11
		add r1, r1, #1
		mov r2, r11
		swi DisplayInt

		mov r10, #0
		LoopB:
			add r0, r0, #2
			mov r2, #0
			swi DisplayInt
			add r10, r10, #1
			cmp r10, #8
			bne LoopB



		add r11, r11, #1
		cmp r11, #9
		bne LoopA

	mov r0, #8
	mov r1, #5
	mov r2, #1
	add r0, r0, #11
	swi DisplayInt

	mov r0, #10
	mov r1, #4
	mov r2, #1
	add r0, r0, #11
	swi DisplayInt

	mov r0, #8
	mov r1, #4
	mov r2, #2
	add r0, r0, #11
	swi DisplayInt	

	mov r0, #10
	mov r1, #5
	mov r2, #2
	add r0, r0, #11
	swi DisplayInt

	@ldmfd sp!, {r4-r11}
	mov pc, lr

Main:
	bl Reset
	mov r9, #1 @TURN = 1
	@stmfd sp!, {r0-r3, r12}
	bl Board
	@ldmfd sp!, {r0-r3, r12}

	@possible = r2

	While:
		cmp r9, #1
		bne Ne
		ldr r2, =PrintP1
		b Lo
		Ne:
		ldr r2, =PrintP2
		
		Lo:
		mov r0, #16
		mov r1, #10
		swi DisplayString

		ldr r2, =PrintP11
		mov r0, #6
		mov r1, #12
		swi DisplayString

		
		mov r0, #15
		ldr r2, =Blank
		swi DisplayString
		ldr r0, =P1
		ldr r2, [r0]
		mov r0, #15
		swi DisplayInt

		ldr r2, =PrintP22
		mov r0, #24
		mov r1, #12
		swi DisplayString

		
		ldr r2, =Blank
		mov r0, #33
		swi DisplayString
		
		ldr r0, =P2
		ldr r2, [r0]
		mov r0, #33
		swi DisplayInt

		bl MoveExists
		cmp r8, #0
		beq NoValidMoves

		CheckAgainX:
		mov r0, #0
		swi SWI_CheckBlue
		cmp r0, #0
		beq CheckAgainX
		bl Assigner
		mov r4, r0

		CheckAgainY:
		mov r0, #0
		swi SWI_CheckBlue
		cmp r0, #0
		beq CheckAgainY
		bl Assigner
		mov r3, r0
		@stmfd sp!, {r0-r2, r12}
		bl Valid
		@ldmfd sp!, {r0-r2, r12}

		Returned:
		cmp r5, #0
		beq Else
		cmp r9, #1
		addeq r9, r9, #1
		subne r9, r9, #1
		cmp r8, #0
		bleq Passed

		Else:		
		ldr r11, =P1
		ldr r10, =P1
		add r12, r11, r10
		cmp r12, #64
		beq Next

		b While

		Passed:
		mov r1, #14
		mov r0, #20
		ldr r2, =PassedStr
		swi DisplayString
		mov pc, lr

Next:

	ldr r2, =Over
	mov r0, #0
	mov r1, #14

	swi DisplayString
	cmp r8, #0
	beq NoMovePrint
	ldr r0, =P1
	ldr r1, =P2
	cmp r0, r1
	mov r0, #35
	mov r1, #14
	blt Two
	bgt One
	ldr r2, =None
	swi DisplayString
	b Exit
	One:
	mov r2, #1
	swi DisplayInt
	b Exit

	Two:
	mov r2, #2
	swi DisplayInt
	b Exit
	
	NoMovePrint:
	mov r2, r9
	mov r0, #35
	mov r1, #14
	swi DisplayInt
	
	Exit:
	swi SWI_Exit


.data
	ARR: .space 256
	P1: .space 4
	P2: .space 4
	Message: .asciz "Hello There"
	Print1: .asciz "1 "
	Print2: .asciz "2 "
	PrintP1: .asciz "Player 1"
	PrintP2: .asciz "Player 2"
	PrintP11: .asciz "Player 1: "
	PrintP22: .asciz "Player 2: "
	Pass: .asciz "Pass: "
	Over: .asciz "Game Over!! The Winner is Player: "
	None: .asciz "No One!!!"
	Blank: .asciz "  "
	PassedStr: .asciz "Passed"
	PassedBlank: .asciz "         "
.end
