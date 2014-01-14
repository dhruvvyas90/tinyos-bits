#ifndef Send_receive_H
#define Send_receive_H
enum{
	AM_CHANNEL = 3,
	TIMER_PERIOD=1000
};
typedef nx_struct SendCMsg {
	nx_uint32_t nodeid;
	nx_uint32_t counter;
}SendCMsg;

#endif /* Send_receive_H */
