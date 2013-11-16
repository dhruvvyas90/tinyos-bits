#ifndef TASK5_H
#define TASK5_H
enum{
	AM_SEND = 13,
	TIMER_PERIOD_MILLI=600  //Propagation Delay
};
typedef nx_struct task5CMsg {
  nx_uint8_t sourceid0;
  nx_uint8_t sourceid1;
  nx_uint8_t sourceid2;
  nx_uint8_t sourceid3;
  nx_uint8_t sourceid4;
  nx_uint8_t sourceid5;
  nx_uint8_t sourceid6;
  nx_uint8_t sourceid7;
  nx_uint8_t sourceid8;
  nx_uint8_t sourceid9;
  nx_uint8_t sourceid10;
  nx_uint8_t sourceid11;
  nx_uint8_t hopcnt;
  nx_uint8_t counter;
} task5CMsg;

#endif /* TASK5_H  */
