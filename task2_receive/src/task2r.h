#ifndef TASK2R_H
#define TASK2R_H
	enum{
		AM_SEND = 3,
		TIMER_PERIOD_MILLI=1000,
		AM_TEST_SERIAL_MSG = 138
	};
	typedef nx_struct task2CMsg {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
} task2CMsg;
#endif /* TASK2R_H */
