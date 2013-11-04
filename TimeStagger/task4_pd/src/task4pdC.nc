#include <Timer.h>
#include "task3s1.h"
#include "printf.h"
module task4pdC{
	uses interface Boot;
	uses interface Leds;
	uses interface Timer<TMilli> as Timer0;
	uses interface Packet;
	uses interface AMPacket;
	uses interface AMSend;
	uses interface SplitControl as AMControl;
	uses interface Receive;
}
implementation{
	uint32_t counter=0;
	message_t pkt;

	event void Boot.booted(){
		// TODO Auto-generated method stub
		call AMControl.start();
	}

	event void AMControl.startDone(error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){
			if(TOS_NODE_ID==1){
			if(call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(SendCMsg))==SUCCESS){
				call Leds.led0Toggle();
				call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
			}
		}
			//call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
		}else{
			call AMControl.start();
		}
	}
	
	event void AMControl.stopDone(error_t error){
		// TODO Auto-generated method stub
	}
	
	event void Timer0.fired(){
		// TODO Auto-generated method stub
		counter++;
	}

	event void AMSend.sendDone(message_t *msg, error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){

		}
	}

	event message_t * Receive.receive(message_t *msg, void *payload, uint8_t len){
		// TODO Auto-generated method stub
		if(TOS_NODE_ID==1){
			call Leds.led1Toggle();
			printf("%u",counter);
		}
		if(TOS_NODE_ID==2){
		call Leds.led1Toggle();
		if(call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(SendCMsg))==SUCCESS){
		
		}	
		}
		return msg;
	}
}
