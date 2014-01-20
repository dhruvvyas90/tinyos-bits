generic configuration DemoSensorStream1C() {
  provides interface ReadStream<uint16_t>;
}
implementation {
  components new msp430sensor1();
  ReadStream = msp430sensor1.ReadStream;
}