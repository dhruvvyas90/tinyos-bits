#include "task415.h"
#include "printf.h"
configuration task415AppC{
}
implementation{
	components MainC;
	components LedsC;
	components task4153C as App;
	components ActiveMessageC;
	components new TimerMilliC() as Timer0;
	components new AMSenderC(AM_SEND);
	components new AMReceiverC(AM_SEND);
	components PrintfC;
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
