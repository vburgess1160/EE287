GPIO_PORTF_DATA_R  EQU 0x400253FC
GPIO_PORTF_DIR_R   EQU 0x40025400
GPIO_PORTF_AFSEL_R EQU 0x40025420
GPIO_PORTF_PUR_R   EQU 0x40025510
GPIO_PORTF_DEN_R   EQU 0x4002551C
GPIO_PORTF_LOCK_R  EQU 0x40025520
GPIO_PORTF_CR_R    EQU 0x40025524
GPIO_PORTF_AMSEL_R EQU 0x40025528
GPIO_PORTF_PCTL_R  EQU 0x4002552C
GPIO_LOCK_KEY      EQU 0x4C4F434B  ; Unlocks the GPIO_CR register
SYSCTL_RCGC2_R     EQU 0x400FE108
SYSCTL_RCGC2_GPIOF EQU 0x00000020  ; port F Clock Gating Control
LEDS			   EQU 0x40025038
	
	

	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT PortF_Init
	EXPORT LEDs_on
	
	;Be sure to export your created I/O functions
	EXPORT red_toggle
	EXPORT blue_toggle
	EXPORT green_toggle
	EXPORT red_on
	EXPORT blue_on
	EXPORT delay
	EXPORT buttons
	EXPORT all_off
	EXPORT red_off
	EXPORT blue_off
	EXPORT green_off


		
PortF_Init
	;Do not use MOV in the code you write

	; 1) activate clock for Port F
	;SYSCTL_RCGC2_R |= 0x20
	LDR R0, =SYSCTL_RCGC2_R
	LDR R1, [R0]
	ORR R1, R1, #0x20
	STR R1, [R0]
	
    ; allow time for clock to finish
	NOP
	NOP
							 
	; 2) unlock the lock register						 
    LDR R1, =GPIO_PORTF_LOCK_R      
    LDR R0, =0x4C4F434B             ; unlock GPIO Port F Commit Register
    STR R0, [R1]     
    LDR R1, =GPIO_PORTF_CR_R        ; enable commit for Port F
    MOV R0, #0xFF                   ; 1 means allow access
    STR R0, [R1]    
	
	; 3) disable analog functionality
	;GPIO_PORTA_AMSEL_R &= ~0x00 ; 0 means analog is off
    LDR R0, =GPIO_PORTF_AMSEL_R
	LDR R1, [R0]
	BIC R1, R1, #0x1F
	STR R1, [R0]
	
	; 4) configure as GPIO
    LDR R1, =GPIO_PORTF_PCTL_R      
    MOV R0, #0x00000000             ; 0 means configure Port F as GPIO
    STR R0, [R1]                  

	; 5) set direction register
	;GPIO_PORTA_DIR_R |= 0x04
	LDR R0, =GPIO_PORTF_DIR_R
	LDR R1, [R0]
	ORR R1, R1, #0x0E	;switches as input, leds as output
	BIC R1, R1, #0x11

	STR R1, [R0]
	

	; 6) regular port function
	LDR R1, =GPIO_PORTF_AFSEL_R     
    MOV R0, #0                      ; 0 means disable alternate function 
    STR R0, [R1]                    
	LDR R1, =GPIO_PORTF_PUR_R       ; enable pull-up resistors for pushbuttons
	MOV R0, #0x11
    STR R0, [R1] 
	
    ; 7) enable Port F digital port
	;GPIO_PORTA_DEN_R |= 0x20;
	LDR R0, =GPIO_PORTF_DEN_R
	LDR R1, [R0]
	ORR R1, R1, #0x1F
	STR R1, [R0]
	
    

	BX LR


; Used to test init function
; Format should not be copied for later parts of the lab, instead use GPIO_PORTF_DATA_R
LEDs_on
	LDR R0, =LEDS
	MOV R1, #0xFF
	STR R1, [R0]
	BX LR


;Add your functions here

red_on
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	ORR R1, R1, #0x02
	STR R1, [R0]
	BX LR
	
red_off
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	BIC R1, R1, #0x02
	STR R1, [R0]
	BX LR
	
red_toggle
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	EOR R1, R1, #0x02
	STR R1, [R0]
	BX LR

blue_on
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	ORR R1, R1, #0x04
	STR R1, [R0]
	BX LR

blue_off
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	BIC R1, R1, #0x04
	STR R1, [R0]
	BX LR

blue_toggle
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	EOR R1, R1, #0x04
	STR R1, [R0]
	BX LR


green_toggle
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	EOR R1, R1, #0x08
	STR R1, [R0]
	BX LR

green_off
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	BIC R1, R1, #0x08
	STR R1, [R0]
	BX LR

all_off
	LDR R0, =GPIO_PORTF_DATA_R
	LDR R1, [R0]
	BIC R1, R1, #0x0E
	STR R1, [R0]
	BX LR
	
buttons
	LDR R1, =GPIO_PORTF_DATA_R
	LDR R0, [R1]
	BIC R0, R0, #0xEE
	BX LR

DELAYVAL	EQU 2666666	
delay
	LDR R0, =DELAYVAL
delay_loop
	SUBS R0, R0, #1
	BNE delay_loop
	


	
	BX LR


	ALIGN
	END