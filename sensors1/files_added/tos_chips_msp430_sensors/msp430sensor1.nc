generic configuration msp430sensor1() {
  provides interface Read<uint16_t>;
  provides interface ReadStream<uint16_t>;

  provides interface Resource;
  provides interface ReadNow<uint16_t>;
}
implementation {
  components new AdcReadClientC();
  Read = AdcReadClientC;

  components new AdcReadStreamClientC();
  ReadStream = AdcReadStreamClientC;

  components msp430sensor1P;
  AdcReadClientC.AdcConfigure -> msp430sensor1P;
  AdcReadStreamClientC.AdcConfigure -> msp430sensor1P;

  components new AdcReadNowClientC();
  Resource = AdcReadNowClientC;
  ReadNow = AdcReadNowClientC;

  AdcReadNowClientC.AdcConfigure -> msp430sensor1P;
}
