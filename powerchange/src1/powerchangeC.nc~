#include <Timer.h>
#include "task2r.h"
#include "printf.h"
#include "math.h"
module task2rC{
	uses interface Boot;
	uses interface Leds;
	//Protos for AM
	uses interface Packet;
  	uses interface AMPacket;
  	uses interface SplitControl as AMControl;
	uses interface Receive;
	//Protos for Serial
//	uses interface SplitControl as SerialControl;	
//    uses interface AMSend as UartSend;
//    uses interface Packet as UartPacket;
//    uses interface AMPacket as UartAMPacket;
}
implementation{
	bool busy_u = TRUE;
	bool busy_a = TRUE;
  	message_t pkt;
	uint16_t counter[5]={0,0,0,0,0};
	uint16_t node_id[5]={2,3,4,5,6};
	int i=0;
	
	void printfFloat(uint16_t,uint16_t,uint16_t,float);
	
	event void Boot.booted(){
		call AMControl.start();
	}

	event void AMControl.startDone(error_t error){
		if(error==SUCCESS){
//			call SerialControl.start();
			busy_u=FALSE;
			busy_a=FALSE;
	
		}else{
			call AMControl.start();	
		}
	}

	event void AMControl.stopDone(error_t error){
	}

/*	event void SerialControl.startDone(error_t error){
		if(error==SUCCESS){
		busy_u=FALSE;
		busy_a=FALSE;
	}else{
		call SerialControl.start();
	}
	}

	event void SerialControl.stopDone(error_t error){
	}*/
	
	event message_t * Receive.receive(message_t *msg, void *payload, uint8_t len){
		int a=0;
		float count=0;
		if(!busy_a){
		if (len == sizeof(task2CMsg)) {
    			task2CMsg* btrpkt = (task2CMsg*)payload;
    			call Leds.set(btrpkt->counter);
    			busy_u=FALSE;
    			for(i=0;i<5;i++){
    				if(node_id[i]==btrpkt->nodeid){
    					busy_u=TRUE;
    					counter[i]++;
    					count=((float)counter[i]/(float)btrpkt->counter);
    					//printf("%u %u %u %d \n",i,counter[i],btrpkt->counter,count);
    					printfFloat(i,counter[i],btrpkt->counter,count);
    					//break;
    				}
   			 }
   			 }
			}
		return msg;
	}
void printfFloat(uint16_t a,uint16_t b,uint16_t d,float toBePrinted) {
     uint32_t fi, f0, f1, f2;
     char c;
     float f = toBePrinted;

     if (f<0){
       c = '-'; f = -f;
     } else {
       c = ' ';
     }

     // integer portion.
     fi = (uint32_t) f;

     // decimal portion...get index for up to 3 decimal places.
     f = f - ((float) fi);
     f0 = f*10;   f0 %= 10;
     f1 = f*100;  f1 %= 10;
     f2 = f*1000; f2 %= 10;
     printf("%u %u %u %c%ld.%d%d%d \n\n",a,b,d, c, fi, (uint8_t) f0, (uint8_t) f1,  
(uint8_t) f2);
   }

	/*event void UartSend.sendDone(message_t *msg, error_t error){
	}*/
}