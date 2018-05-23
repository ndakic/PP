
a:
			WORD	1
b:
			WORD	1
main:
			PUSH	%14
			MOV 	%15,%14
			SUBS	%15,$4,%15
@main_body:
			MOV 	$1,-4(%14)
			MOV 	$0,a
			ADDS	-4(%14),$1,-4(%14)
			ADDS	a,$1,a
			ADDS	a,$10,%0
			MOV 	%0,a
			MOV 	-4(%14),%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET