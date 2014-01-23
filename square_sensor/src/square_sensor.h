#ifndef square_sensor_H
#define square_sensor_H
enum{
	AM_CHANNEL = 3,
	TIMER_PERIOD=1000
};
typedef nx_struct SendCMsg {
	nx_uint32_t nodeid;
	nx_uint32_t counter;
}SendCMsg;

#endif /* square_sensor_H */
