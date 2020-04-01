#include "Inits.h"
#include "tm4c123gh6pm.h" // Hardware register definitions
#include "stdint.h"

// Initialize PD1 and PD0 as inputs
// Leave everything else unchanged
void PortD_Init(void){
	long delay;
	SYSCTL_RCGC2_R |= 0x00000008;     // 1) activate clock for Port D

  delay = SYSCTL_RCGC2_R;           // allow time for clock to start
	
                                    // 2) no need to unlock GPIO Port D/E
	
	GPIO_PORTD_AMSEL_R &= ~0x03;      // 3) disable analog on D0 D1

  GPIO_PORTD_PCTL_R &= ~0x00000003; // 4) PCTL GPIO on D0 D1

	GPIO_PORTD_DIR_R &= ~0x03;				// 5)	directing PD0 and PD1 as input 0
	
  GPIO_PORTD_AFSEL_R &= ~0x03;      // 6) D0, D1 regular port function

  GPIO_PORTD_DEN_R |= 0x03;         // 7) enable D0 D1 digital port
}

// Initialize PE5, PE4, and PE3 as outputs
// Leave everything else unchanged
void PortE_Init(void){
	long delay;
	
	SYSCTL_RCGC2_R |= 0x00000010;     // 1) activate clock for Port E
	
	delay = SYSCTL_RCGC2_R;           // allow time for clock to start
	
	GPIO_PORTE_AMSEL_R &= ~0x38;      // 3) disable analog on PE3 PE4 PE5
	
	GPIO_PORTE_PCTL_R &= ~0x00000038; // 4) PCTL GPIO on E3, E4, E5
	
	GPIO_PORTE_DIR_R |= 0x38;        // 5) directing PE3 PE4 PE5 as output 1
	
	GPIO_PORTE_AFSEL_R &= ~0x38;      // 6) E3, E4, E5 regular port function
	
	GPIO_PORTE_DEN_R |= 0x38;         // 7) enable E3 E4 E5 digital port
}
