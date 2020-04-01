

	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
	export exp
	EXPORT mulsum4
	IMPORT green_led_on
	IMPORT red_led_on
	IMPORT leds_off
	;Be sure to export created functions
	
	
	

		

;Should perform the operation (R0+R1)^R0
;Takes the sum of R0 and R1 and multiplies it by itself R0 times (i.e. raises R0+R1 to the power of R0)
;Assume R0 is greater than 0
;Should return the result in R0
;Inputs: R0 and R1
;Outputs: R0
exp
	PUSH {LR}
	ADDS R3, R0, R1		; R3 = A+B
	SUBS R2, R0, #1		; R2 = A - 1
	MOV R0, R3			; R0 = A+B
	
	CMP R2, #0
	BEQ branch
	
	
exp_loop	
	MUL R0, R0, R3		; R0 = R0 * (A+B)
	SUBS R2, R2, #1		; multiply A times
	BNE exp_loop
	
branch
	POP {LR}
	BX LR


;Should perform the operation (A+B+C)*(B+C+D)*2	
;A, B, C, and D are passed in order in R0-R3
;Should return the result in R0
;Inputs: R0, R1, R2, and R3
;Outputs: R0
mulsum4

	; Your code here
	; Should make calls to both sum3 and mul3
	PUSH{LR}
	PUSH{R4-R5}
	PUSH{R0-R3}
	
	BL sum3
	MOV R4, R0
	
	POP {R0-R3}
	MOV R0, R3
	BL sum3
	MOV R5, R0
	
	MOV R0, R4
	MOV R1, R5
	MOV R2, #2
	BL mul3
	
	POP {R4-R5}
	POP{LR}
	BX LR
	
	
	
	
;Performs the operation R0+R1+R2
;Returns the sum in R0
;Inputs: R0, R1, and R2
;Outputs: R0
sum3
	
	ADD R3, R0, R1
	ADD R0, R2, R3
	
	BX LR

;Should perform the operation R0*R1*R2
;Should return the product in R0
;Inputs: R0, R1, and R2
;Outputs: R0
mul3
	
	;Your code here
	
	MUL R0, R0, R1
	MUL R0, R0, R2	
	
	BX LR


	ALIGN
	END