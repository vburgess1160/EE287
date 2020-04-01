

	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start
	IMPORT PortF_Init
	IMPORT LEDs_on
	IMPORT red_toggle
	IMPORT blue_toggle
	IMPORT green_toggle
	IMPORT red_on
	IMPORT blue_on
	IMPORT delay
	IMPORT buttons
	IMPORT all_off
	IMPORT red_off
	IMPORT blue_off
	IMPORT green_off
		
		
	
	
	
	;Be sure to import your created I/O functions


		
Start
	BL PortF_Init
	
	BL loop

SW1
	BL green_off
	BL red_off
	BL blue_on
	BL loop
SW2
	BL green_off
	BL blue_off
	BL	red_on
	BL loop
None
	BL red_off
	BL blue_off
	BL green_toggle
	BL loop	
Both
	BL all_off
	BL delay
	BL buttons
	CMP R0, #0x00
	BNE loop
	
	BL LEDs_on
	BL delay
	BL buttons
	CMP R0, #0x00
	BNE loop
	
	BL green_toggle
	BL delay
	BL buttons
	CMP R0, #0x00
	BNE loop
	
	BL green_toggle
	BL red_toggle
	BL blue_toggle
	;BL delay
	BL buttons
	CMP R0, #0x00
	;BNE loop
	
	BL loop
	
loop

	; Call delay
	BL delay

	; Read the state of the buttons
	BL buttons
	
	; None -> Call toggle
	CMP R0, #0x11
	BEQ None

	; SW1 -> Call blue_on
	CMP R0, #0x01
	BEQ SW1

	; SW2 -> Call red_on
	CMP R0, #0x10
	BEQ SW2
	
	; Both -> Call toggle, blue_on, red_on
	CMP R0, #0x00
	BEQ Both
		
	B loop





	ALIGN
	END