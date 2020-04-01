; Credit: Based on software by Valvano

	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT   delay
	EXPORT	 delay_dim



;------------delay------------
; Delay function for testing
; Input: none
; Output: none	
DELAYVAL		EQU 0	;Change to calculated value
delay
		;Add Part 2 code here

    BX  LR                          
	
	
DIMSEC			EQU 16000 		; delay_dim_loop will run this many time to create a delay

delay_dim
	LDR R0, =DIMSEC 			; put the value of DIMSEC into R0
delay_dim_loop
	SUBS R0, R0, #1				; R0 = R0 - 1
	BNE delay_dim_loop 			; repeat until R0 == 0
	BX LR						; return
	
	ALIGN                       ; make sure the end of this section is aligned
    END                         ; end of file
