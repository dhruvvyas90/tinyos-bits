#include "Null.h" 

configuration SendAppC { 
}
implementation {

	/*This file contains the wires 
	linking the main module to the hardware
	Also the components of the hardware to be
	used are declared here.*/
	components MainC;
	components NullC as App;
	
	App.Boot -> MainC;
}
