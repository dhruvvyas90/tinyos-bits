#include <Timer.h>
#include "task415.h"
#include "printf.h"
module task415C{
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
	bool check=FALSE;
	bool pkt_exist=FALSE;
	uint32_t counter=0;
	message_t pkt;
	am_addr_t x;
	
	event void Boot.booted(){
		// TODO Auto-generated method stub
		call AMControl.start();
	}

	event void AMControl.startDone(error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){
	
		}else{
			call AMControl.start();
		}
	}
	
	event void Timer0.fired(){
		counter++;
		if(!pkt_exist){
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
			btrpkt->counter0=counter;
			btrpkt->counter1=0;
			btrpkt->counter2=0;
			btrpkt->counter3=0;
			btrpkt->counter4=0;
			btrpkt->counter5=0;
			btrpkt->counter6=0;
			btrpkt->counter7=0;
		}
		if(call AMSend.send(AM_BROADCAST_ADDR,&pkt, sizeof(task3CMsg))==SUCCESS){
			
			call Leds.led0Toggle();			
			}
	}

	event void AMControl.stopDone(error_t error){
		// TODO Auto-generated method stub
	}

	event void AMSend.sendDone(message_t *msg, error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){
			busy=FALSE;
		}
	}

	event message_t * Receive.receive(message_t *msg, void *payload, uint8_t len){
		// TODO Auto-generated method stub
		call Leds.led1Toggle();		
		//Saving the packet and appending it
		x=call AMPacket.source(msg);
		if(x==16){
			call Timer0.startPeriodic(TOS_NODE_ID*TIMER_PERIOD_MILLI);
		}
		else{
			pkt_exist=TRUE;
			task3CMsg* btrpkt = (task3CMsg*)payload;
			if((TOS_NODE_ID-X)==1){
				check=TRUE;
			}else if((TOS_NODE_ID-X)==4){
				check=TRUE;
			}
			if(check){
				if(btrpkt->hopcnt==1){
				btrpkt->sourceid1=TOS_NODE_ID;
				btrpkt->counter1=counter;}
				else if(btrpkt->hopcnt==2){
				btrpkt->sourceid2=TOS_NODE_ID;
				btrpkt->counter2=counter;}
				else if(btrpkt->hopcnt==3){
				btrpkt->sourceid3=TOS_NODE_ID;
				btrpkt->counter3=counter;}
				else if(btrpkt->hopcnt==4){
				btrpkt->sourceid4=TOS_NODE_ID;
				btrpkt->counter4=counter;}
				else if(btrpkt->hopcnt==5){
				btrpkt->sourceid5=TOS_NODE_ID;
				btrpkt->counter5=counter;}
				else if(btrpkt->hopcnt==6){
				btrpkt->sourceid6=TOS_NODE_ID;
				btrpkt->counter6=counter;}
				else if(btrpkt->hopcnt==7){
				btrpkt->sourceid7=TOS_NODE_ID;
				btrpkt->counter7=counter;}
				btrpkt->hopcnt=(btrpkt->hopcnt)+1;
				pkt=*msg;
				check=FALSE;
			}
		}
		return msg;
	}
}
