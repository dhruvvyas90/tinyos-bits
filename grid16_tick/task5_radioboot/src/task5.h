#ifndef TASK5_H
#define TASK5_H
enum{
	AM_SEND = 13,
	TIMER_PERIOD_MILLI=1  //Propagation Delay
};
typedef nx_struct task5CMsg {
  nx_uint8_t sourceid0;
  nx_uint8_t hopcnt;
  nx_uint8_t counter0;
} task5CMsg;

#endif /* TASK5_H  */
