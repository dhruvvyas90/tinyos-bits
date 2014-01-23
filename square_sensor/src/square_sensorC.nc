#include "square_sensor.h"
#include <Timer.h>
#include "printf.h"

module square_sensorC{
	uses interface Boot;
	uses interface Leds;
	uses interface Timer<TMilli> as Timer0;
	uses interface Packet;
	uses interface AMPacket;
	uses interface AMSend;
	uses interface SplitControl as AMControl;
	uses interface Receive;
	uses interface HplMsp430Interrupt as sensorRead;

}
implementation{
	uint32_t counter;
	bool busy=FALSE;
	message_t pkt;

	event void Boot.booted(){
		//call AMControl.start();
		call Timer0.startPeriodic(TIMER_PERIOD);
			}
	
	event void AMControl.startDone(error_t error){
		if(error == SUCCESS){
			call Timer0.startOneShot(TIMER_PERIOD);
		}else{
			call AMControl.start();
		}
	}

	event void AMControl.stopDone(error_t error){
	}
		
	event void Timer0.fired(){
		call sensorRead.enable();
		call sensorRead.edge(FALSE);

		call Leds.led2Toggle();
		if(call sensorRead.getValue())
		call Leds.led1Toggle();
	}
	
	event void AMSend.sendDone(message_t *msg, error_t error){
		if (&pkt == msg) {
			busy = FALSE;
		}
	}
	
		event message_t * Receive.receive(message_t *msg, void *payload, uint8_t len){
			
			SendCMsg* btrpkt = (SendCMsg*)payload;
			call Leds.set(btrpkt->counter);
			
			return msg;
	}

	async event void sensorRead.fired(){
		call Leds.led0Toggle();
		printf("hellloooo");
	}
}
