#include <Timer.h>
#include "task5.h"
#include "printf.h"
module task5C{
	uses interface Boot;
	uses interface Leds;
	uses interface Timer<TMilli> as Timer0;
	uses interface SplitControl as AMControl;
}
implementation{
	uint32_t counter=0;
	event void Boot.booted(){
		// TODO Auto-generated method stub
		call Timer0.startPeriodic(1);
		call AMControl.start();
		call Leds.led0Toggle();
		printf("%u-%u\n",counter,call Timer0.getNow());
	}

	event void AMControl.startDone(error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){
			printf("%u-%u\n",counter,call Timer0.getNow());
			call Leds.led1Toggle();
			call AMControl.stop();
		}else{
			call AMControl.start();
		}
	}
	event void Timer0.fired(){
		counter++;
	}
	
	event void AMControl.stopDone(error_t error){
		// TODO Auto-generated method stub
		call Leds.led2Toggle();
		printf("%u-%u\n",counter,call Timer0.getNow());
	}
}
