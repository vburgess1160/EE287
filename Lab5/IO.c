#include "IO.h"
#include "tm4c123gh6pm.h"


#define PD0   (*((volatile unsigned long *)0x40007004))
#define PD1   (*((volatile unsigned long *)0x40007008))
#define PE3   (*((volatile unsigned long *)0x40024020))
#define PE4   (*((volatile unsigned long *)0x40024040))
#define PE5   (*((volatile unsigned long *)0x40024080))


//Place the definition for bit specific addressing here.  
//The below example is for PortA pin 5
//#define PA5 (*((volatile uint32_t *)0x40004080))

//Place your pushbutton and led functions here

//Turns off all LEDs
void LEDs_off(void){
	//GPIO_PORTE_DATA_R &= ~0x38;
	PE3 = ~0x08;
	PE4 = ~0x10;
	PE5 = ~0x20;
}

//Turns on all LEDs
void LEDs_on(void){
	//GPIO_PORTE_DATA_R |= 0x38;
	PE3 = 0x08;
	PE4 = 0x10;
	PE5 = 0x20;
}

void red_on(void) {
	PE4 = 0x10;
}

void green_on(void) {
	PE5 = 0x20;
}

void yellow_on(void) {
	PE3 = 0x08;
}

void count(void) {
	LEDs_off(); //000
	delay();
	
	yellow_on(); //001
	delay();
	
	LEDs_off(); //010
	green_on();
	delay();
	
	yellow_on(); //011
	delay();
	
	LEDs_off(); //100
	red_on();
	delay();
	
	yellow_on(); //101
	delay();
	
	LEDs_off(); //110
	red_on();
	green_on();
	delay();
	
	yellow_on(); //111
	delay();
	
	LEDs_off();
}

void toggle_boy(void) {
	LEDs_off();
	
	green_on();
	delay();
	
	LEDs_off();
	red_on();
	yellow_on();
	delay();
	
	LEDs_off();
}

//Should return the button states
uint32_t pushbuttons(void){
	
	// Set to 42 because the compiler expects a return value.  
	// Your function only needs to return a value denoting the button states
	// rather than the answer to life, the universe, and everything...
	if ( PD0 == 0x00 && PD1 == 0x00 )
		return 0x03;
	else if (PD0 != 0x00 && PD1 == 0x00)
		return 0x02;
	else if (PD1 != 0x00 && PD0 == 0x00)
		return 0x01;
	else
		return 0x00;
		
}

void delay(void) {
	int i = 2666666;
	while (i > 0)
		i--;
}

