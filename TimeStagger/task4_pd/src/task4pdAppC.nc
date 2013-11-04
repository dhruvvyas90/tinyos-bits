#include "task3s2.h"
#include "printf.h"
configuration task4pdAppC{
}
implementation{
	components MainC;
	components LedsC;
	components task3s2C as App;
	components new TimerMilliC() as Timer0;
	components ActiveMessageC;
	components new AMSenderC(AM_SEND);
	components new AMReceiverC(AM_SEND);
	components SerialPrintfC;
	components SerialStartC;
  
   App.Boot -> MainC;
   App.Leds -> LedsC;
   App.Timer0 -> Timer0;
   App.Packet -> AMSenderC;
   App.AMPacket -> AMSenderC;
   App.AMSend -> AMSenderC;
   App.AMControl -> ActiveMessageC;
   App.Receive -> AMReceiverC;
}
