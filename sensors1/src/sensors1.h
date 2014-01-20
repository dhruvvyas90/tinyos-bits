#ifndef sensors1_H
#define sensors1_H
#include "Msp430Adc12.h"

enum{
	AM_CHANNEL = 3,
};

typedef nx_struct sensorsCMsg {
	nx_uint16_t value;
}sensorsCMsg;

#endif /* Null_H */

/*Header file containing structure type of message and channnel number*/
