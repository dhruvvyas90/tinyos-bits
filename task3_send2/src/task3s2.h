#ifndef TASK3S2_H
#define TASK3S2_H
enum{
	AM_SEND = 3,
	TIMER_PERIOD_MILLI=2000
};
typedef nx_struct task3CMsg {
  nx_uint16_t sourceid0;
  nx_uint16_t sourceid1;
  nx_uint16_t sourceid2;
  nx_uint16_t sourceid3;
  nx_uint16_t sourceid4;
  nx_uint16_t sourceid5;
  nx_uint16_t sourceid6;
  nx_uint16_t sourceid7;
  nx_uint8_t hopcnt;
  nx_uint8_t counter;
  nx_uint8_t data0;
  nx_uint8_t data1;
} task3CMsg;

typedef nx_struct SendCMsg {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
} SendCMsg;
#endif /* TASK3S2_H  */
