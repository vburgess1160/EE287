#include "SysTick.h"
#include "tm4c123gh6pm.h"
#include "stdint.h"

// Used in part 3
volatile uint32_t g_handler_calls;

//Initialize Systick
void SysTick_Init(void){
	NVIC_ST_CTRL_R = 0;         // disable SysTick during setup
	NVIC_ST_RELOAD_R = 0; // reload value
	NVIC_ST_CURRENT_R = 0;      // any write to current clears it
	NVIC_ST_CTRL_R = 0x05; // enable SysTick with core clock and interrupts
	// enable interrupts after all initialization is finished
}


// Configure SysTick to generate an interrupt every 20ms
// Assume 16 MHz clock
void SysTick_Init_Interrupts(void){
	g_handler_calls = 0; //Initialize counter as 0

	//initialize control 0, reload = 20ms
	NVIC_ST_CTRL_R = 0;
	NVIC_ST_RELOAD_R = 320000-1;
	NVIC_SYS_PRI3_R = (NVIC_SYS_PRI3_R&0x00FFFFFF)|0x40000000; // priority 2
	NVIC_ST_CTRL_R = 0x07;
}

// Clock speed is 16 MHz
static void SysTick_Delay1ms_16MHz(void){
	
	// Choose the number of clock ticks to wait
	NVIC_ST_RELOAD_R = 16000-1;
	
	NVIC_ST_CURRENT_R = 0; // Any value written to write clears it
	while((NVIC_ST_CTRL_R&0x00010000)==0){} // Wait for count flag
}


// Write code to generate a 2 sec delay
// Your code should call SysTick_Delay1ms()
void SysTick_Delay2s_16MHz(void){
	// Choose the number of clock ticks to wait
	NVIC_ST_RELOAD_R = 32000000-1;
	
	NVIC_ST_CURRENT_R = 0; // Any value written to write clears it
	while((NVIC_ST_CTRL_R&0x00010000)==0){} // Wait for count flag
} 


// Write code to generate 1ms delay assuming a clock speed of 50MHz
static void SysTick_Delay1ms_50MHz(void){
	// Choose the number of clock ticks to wait
	NVIC_ST_RELOAD_R = 49999;
	
	NVIC_ST_CURRENT_R = 0; // Any value written to write clears it
	while((NVIC_ST_CTRL_R&0x00010000)==0){} // Wait for count flag
}


// Write code to generate a 2 sec delay when the clock speed is 50MHz
// Your code should call SysTick_Delay1ms_50MHz()
void SysTick_Delay2s_50MHz(void){
	int i;
	for (i = 0; i < 2000; i++)
		SysTick_Delay1ms_50MHz();
}
	


// Toggle green LED every 2 seconds PF3
// Toggle blue LED every 1 second PF2
void SysTick_Handler(void){
	g_handler_calls++;
	if (g_handler_calls % 50 == 0)
		GPIO_PORTF_DATA_R ^= 0x04;
	if (g_handler_calls % 100 == 0) 
		GPIO_PORTF_DATA_R ^= 0x08;
	
}
