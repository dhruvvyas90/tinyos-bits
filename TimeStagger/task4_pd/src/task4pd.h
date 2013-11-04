#ifndef TASK4PD_H
#define TASK4PD_H
enum{
	AM_SEND = 3,
	TIMER_PERIOD_MILLI=1
};
typedef nx_struct SendCMsg {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
} SendCMsg;
#endif
