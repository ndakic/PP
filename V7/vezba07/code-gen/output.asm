
a:
		 WORD 1
b:
		 WORD 1
main:
			PUSH	%14
			MOV 	%15,%14
@main_body:
			MOV 	$0,a
			ADDS	a,$5,%0
			MOV 	%0,a
			MOV 	a,%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET