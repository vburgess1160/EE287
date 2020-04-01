#include "Inits.h"
#include "IO.h"
#include "stdint.h"

int main(){

	// Must be volatile to guarantee a new button state being retrieved
	volatile uint32_t buttons;

	PortD_Init();
	PortE_Init();
	
	// You will need to write more functions than just these
	//LEDs_on();
	//LEDs_off();
//	while (1 == 1) {
//	buttons = pushbuttons();
//	if (buttons == 0x00)
//		LEDs_off();
//	if (buttons == 0x03)
//		LEDs_on();
//}
	
	
	while (1 == 1) { //run continuously
		buttons = pushbuttons();
		
		if (buttons == 0x01) { //button1 is pressed
			while (1 == 1) {
				count();
				buttons = pushbuttons();
			if (buttons != 0x00)
				break;
			}
		}
		
		if (buttons == 0x02) { //button2 is pressed
			do {
			toggle_boy();
			buttons = pushbuttons();
			} while (buttons != 0x02);
			delay();
			
		}
		
		
	}
	
	
	return 0;
}

