#ifndef powerchange_H
#define powerchange_H
	enum{
		AM_BLINKTORADIO = 3,
		TIMER_PERIOD_MILLI=1000
	};
typedef nx_struct SendCMsg {
  nx_uint16_t nodeid;
  nx_uint16_t counter;
} SendCMsg;

#endif /* powerchange_H */
