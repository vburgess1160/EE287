



	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT  Start
	IMPORT  PortF_Init;
	IMPORT  delay
	IMPORT	delay_dim
	IMPORT  blue_led_on
	IMPORT  blue_led_off
	IMPORT  red_led_on
	IMPORT  red_led_off
	IMPORT  green_led_on
	IMPORT  green_led_off

Start
	BL PortF_Init; ; Initialize the LEDs and Pushbuttons

loop

	;B parts34 ;Uncomment this line to skip the toggling routine used in Parts 1 and 2

	BL red_led_on
	BL delay_dim
	BL red_led_off
	BL delay_dim
	B loop


parts34

	BL red_led_on
	BL delay
	BL red_led_off
	BL delay
	
	BL green_led_on
	BL delay
	BL green_led_off
	BL delay

	BL blue_led_on
	BL delay
	BL blue_led_off
	BL delay

	B parts34
	
	ALIGN        ; make sure the end of this section is aligned
	END          ; end of file