#include "PortF.h"
#include "stdint.h"
#include "tm4c123gh6pm.h"

void PortF_Init(void){
	//Initialize PF3, PF2, and PF1 as outputs
	//Initialize PF4 and PF0 as inputs
	volatile uint32_t delay;
	SYSCTL_RCGC2_R |= 0x20;
	delay=SYSCTL_RCGC2_R;
	GPIO_PORTF_LOCK_R = 0x4C4F434B;
  GPIO_PORTF_CR_R = 0x1F;
	GPIO_PORTF_AMSEL_R &= ~0x1F;
	GPIO_PORTF_AFSEL_R &= ~0x1F;
	GPIO_PORTF_PCTL_R &= ~0x000FFFFF;
	GPIO_PORTF_DIR_R |= 0x0E;
	GPIO_PORTF_DIR_R &= ~0x11;
	GPIO_PORTF_PUR_R |= 0x11;
	GPIO_PORTF_DEN_R |= 0x1F;
}

// Returns only the state of the buttons
// You may change this function if you wish
uint32_t pushbuttons(void){
	return GPIO_PORTF_DATA_R & 0x11;
}
