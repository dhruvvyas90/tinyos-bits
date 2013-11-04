#include <Timer.h>
#include "task3s1.h"
#include "printf.h"
module task3s1C{
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
	bool busy=FALSE;
	uint8_t counter = 0;
	message_t pkt;
	am_addr_t x;
	uint8_t cnt=0;
	uint8_t cntpdr=0;
	uint8_t z;
	uint8_t inc=1;
	
	event void Boot.booted(){
		// TODO Auto-generated method stub
		call AMControl.start();
	}

	event void AMControl.startDone(error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){
			call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
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
		if(!busy){
			task3CMsg* btrpkt = (task3CMsg*)(call Packet.getPayload(&pkt, sizeof (task3CMsg)));
			busy=TRUE;
			btrpkt->sourceid0=TOS_NODE_ID;
			btrpkt->sourceid1=0;
			btrpkt->sourceid2=0;
			btrpkt->sourceid3=0;
			btrpkt->sourceid4=0;
			btrpkt->sourceid5=0;
			btrpkt->sourceid6=0;
			btrpkt->sourceid7=0;
			btrpkt->hopcnt=1;
			btrpkt->counter=counter;
	
			if(call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(task3CMsg))==SUCCESS){
				//call Leds.set(counter);
			}			
		}
	}

	event void AMSend.sendDone(message_t *msg, error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){
			busy=FALSE;
		}
	}

	event message_t * Receive.receive(message_t *msg, void *payload, uint8_t len){
		// TODO Auto-generated method stub
	
		task3CMsg* btrpkt = (task3CMsg*)payload;
		x=TOS_NODE_ID;
		//printf("%u\n",btrpkt->sourceid1);
		if(TOS_NODE_ID==16){
			if(cnt<(btrpkt->counter)){
				cnt=btrpkt->counter;
				cntpdr=cntpdr+1;
			}
		}
		else{
			am_addr_t z1=call AMPacket.source(msg);
				if(z1< x){
				printfflush();
				printf("%u\n",btrpkt->sourceid1);
		
				if(btrpkt->hopcnt==1)
				btrpkt->sourceid1=TOS_NODE_ID;
				else if(btrpkt->hopcnt==2)
				btrpkt->sourceid2=TOS_NODE_ID;
				else if(btrpkt->hopcnt==3)
				btrpkt->sourceid3=TOS_NODE_ID;
				else if(btrpkt->hopcnt==4)
				btrpkt->sourceid4=TOS_NODE_ID;
				else
				btrpkt->sourceid5=8;
				btrpkt->hopcnt=(btrpkt->hopcnt)+inc;
				if(call AMSend.send(AM_BROADCAST_ADDR,msg, sizeof(task3CMsg))==SUCCESS){
					call Leds.set(btrpkt->counter);
					z=btrpkt->hopcnt;				
				}
			}
		}
		return msg;
	}
}
