	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT delay
	EXPORT delay_mul
		
DELAYVAL 		EQU 133333
delay
	PUSH {R0}
	LDR R0, =DELAYVAL
delay_loop
	SUBS R0, R0, #1
	BNE delay_loop
	POP {R0}
	BX LR
		
delay_mul
	PUSH {R0}
	PUSH {R14}
delay_mul_loop
	BL delay
	SUBS R0, R0, #1
	BNE delay_mul_loop
	POP {R14}
	POP {R0}
	BX LR
	
	ALIGN
	END