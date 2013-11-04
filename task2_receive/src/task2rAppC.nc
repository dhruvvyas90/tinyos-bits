#include <Timer.h>
#include "task2r.h" 
#include "printf.h"

configuration task2rAppC{
}
implementation{
   components MainC;
   components LedsC;
   components task2rC as App;
   components new TimerMilliC() as Timer0;
   components ActiveMessageC;
   components new AMReceiverC(AM_SEND);
   components SerialActiveMessageC as Serial;
  components PrintfC;
  components SerialStartC;
  
   App.Boot -> MainC;
   App.Leds -> LedsC;
   App.Packet -> AMReceiverC;
   App.AMPacket -> AMReceiverC;
   App.AMControl -> ActiveMessageC;
   App.Receive -> AMReceiverC;
   
   //App.SerialControl -> Serial;
   //App.UartSend -> Serial.AMSend[AM_TEST_SERIAL_MSG];
   //App.UartPacket -> Serial;
   //App.UartAMPacket -> Serial;
}