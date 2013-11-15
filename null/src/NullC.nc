#include "Null.h"
module NullC{

	//interfaces used by the code like boot,leds,packet
	uses interface Boot;
}
implementation{

	//Main Code
	event void Boot.booted(){
		//start your code from here
	}
}
