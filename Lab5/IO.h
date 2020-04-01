#ifndef _IO_h
#define _IO_h
#include "stdint.h"

//Place prototypes for your pushbutton and LED functions here

void LEDs_off(void);
void LEDs_on(void);
uint32_t pushbuttons(void);
void red_on(void);
void green_on(void);
void yellow_on(void);
void delay(void);
void count(void);
void toggle_boy(void);


#endif
