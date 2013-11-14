#include "task5.h"
#include "printf.h"
configuration task5AppC{
}
implementation{
	components MainC;
	components LedsC;
	components task5C as App;
	components new TimerMilliC() as Timer0;
	components ActiveMessageC;
	components new AMSenderC(AM_SEND);
	components new AMReceiverC(AM_SEND);
	components PrintfC;
	components SerialStartC;
  
   App.Boot -> MainC;
   App.Leds -> LedsC;
   App.Packet -> AMSenderC;
   App.Timer0->Timer0;
   App.AMPacket -> AMSenderC;
   App.AMSend -> AMSenderC;
   App.AMControl -> ActiveMessageC;
   App.Receive -> AMReceiverC;
}
