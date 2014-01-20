generic configuration DemoSensor1C() {
  provides interface Read<uint16_t>;
}
implementation {
  components new msp430sensor1();
  Read = msp430sensor1.Read;
}