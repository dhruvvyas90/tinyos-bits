#include "sensors1.h" 
#include "printf.h"

configuration sensors1AppC { 
}
implementation {

	/*This file contains the wires 
	linking the main module to the hardware
	Also the components of the hardware to be
	used are declared here.*/
	components MainC;
	components sensors1C as App;
	components new VoltageC();
	components LedsC;
	components SerialPrintfC;
	components SerialStartC;
	components ActiveMessageC;
	components new TimerMilliC() as Timer0;
	components new AMSenderC(AM_CHANNEL);
	components new AMReceiverC(AM_CHANNEL);
	components new DemoSensor1C() as Sensor;


	App.Boot -> MainC;
	App.Read->VoltageC;
	App.Leds->LedsC;
	App.Timer0 -> Timer0;
   App.Packet -> AMSenderC;
   App.AMPacket -> AMSenderC;
   App.AMSend -> AMSenderC;
   App.AMControl -> ActiveMessageC;
   App.Read1 -> Sensor;
   
}
