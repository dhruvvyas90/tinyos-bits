#include<Timer.h>
#include "powerchange.h"

module powerchangeC{
	uses interface Boot;
	uses interface Leds;
	uses interface Timer<TMilli> as Timer0;
	uses interface Packet;
  	uses interface AMPacket;
  	uses interface AMSend;
  	uses interface SplitControl as AMControl;
	uses interface CC2420Packet;
	uses interface Receive;
}
implementation{
	uint16_t counter = 0;	
	bool busy = FALSE;
  	message_t pkt;
  	int z=0;
  	bool busy_a=TRUE;
	event void Boot.booted(){
		call AMControl.start();
	}

	event void Timer0.fired(){
	 counter++;
     	call Leds.set(counter);
       if (!busy) {
    SendCMsg* btrpkt = (SendCMsg*)(call Packet.getPayload(&pkt, sizeof (SendCMsg)));
    btrpkt->nodeid = TOS_NODE_ID;
    btrpkt->counter = counter;
    call CC2420Packet.setPower(&pkt,2);
    if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(SendCMsg)) == SUCCESS) {
      busy = TRUE;
    }
  }
	}


 	event void AMSend.sendDone(message_t *msg, error_t error){
   if (&pkt == msg) {
      busy = FALSE;
    }
}
	
	event void AMControl.startDone(error_t error){
    if (error == SUCCESS) {
      call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
    }
    else {
      call AMControl.start();
    }
}
	
	event void AMControl.stopDone(error_t error){
	}
	
	event message_t * Receive.receive(message_t *msg, void *payload, uint8_t len){
		if(!busy_a){
		SendCMsg* btrpkt = (SendCMsg*)payload;
    			call Leds.set(btrpkt->counter);
    			
}
		return msg;
	}
}
