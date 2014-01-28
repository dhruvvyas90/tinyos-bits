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
	uses interface Msp430Capture as sensorRead;
	uses interface Msp430TimerControl as sensorControl;
	uses interface Msp430Timer as sensorTimer;
}
implementation{
	uint32_t counter=0;
	bool busy=FALSE;
	message_t pkt;

	event void Boot.booted(){
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
		if(counter==0){
		msp430_compare_control_t x=call sensorControl.getControl();
		call sensorControl.setControl(x);
		counter=1;
		}else if(counter==1){
		call sensorControl.setControlAsCapture(MSP430TIMER_CM_BOTH);
		counter=2;
	}else if(counter==2){
		call sensorRead.setEdge(MSP430TIMER_CM_BOTH);
		call sensorRead.setSynchronous(FALSE);
		call sensorTimer.clear();
		counter=3;
		}else if(counter == 3)
		{
			call sensorTimer.enableEvents();
			call sensorControl.enableEvents();
			call sensorRead.clearOverflow();
			counter=4;
		}
		else{
		//if(==FALSE)
		printf("%u",call sensorRead.getEvent());
	}
		call Leds.led0Toggle();
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

	async event void sensorRead.captured(uint16_t time){
		call Leds.led1Toggle();
		printf("hellloooo");
	}
	async event void sensorTimer.overflow(){
		//printf("helllo");
	}
}
