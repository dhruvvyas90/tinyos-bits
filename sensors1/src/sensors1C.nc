#include "sensors1.h"
#include "printf.h"
#include <Timer.h>

module sensors1C{

	//interfaces used by the code like boot,leds,packet
	uses interface Boot;
	uses interface Read<uint16_t>;
	uses interface Leds;
	uses interface Timer<TMilli> as Timer0;
	uses interface Packet;
	uses interface AMPacket;
	uses interface AMSend;
	uses interface SplitControl as AMControl;
	uses interface Read<uint16_t> as Read1;
}
implementation{
	int i=0;
	message_t pkt;
	event void Boot.booted(){
		call AMControl.start();
		call Timer0.startPeriodic(1000);	
	}

	event void Timer0.fired(){
		call Read1.read();
	}

	event void Read.readDone(error_t result, uint16_t data) {
    if (result == SUCCESS)
      {
      	sensorsCMsg* btrpkt = (sensorsCMsg*)(call Packet.getPayload(&pkt, sizeof (sensorsCMsg)));
      	for(i=0;i<10;i++)
      	{
      		printf("The voltage measured is: %u\n",data );
			    printfflush();
      	}
      	
			btrpkt->value=data;
      	call AMSend.send(AM_BROADCAST_ADDR,&pkt, sizeof(sensorsCMsg));
      	call Leds.set(data);
      }
  }

  event void AMSend.sendDone(message_t *msg, error_t error){

  }

  event void AMControl.startDone(error_t error){

  }

  event void AMControl.stopDone(error_t error){

  }

  event void Read1.readDone(error_t result, uint16_t data) {
    if (result == SUCCESS)
      {
      	printf("The voltage measured is: %u\n",data );
        call Leds.set(data);
      }
  }
}
