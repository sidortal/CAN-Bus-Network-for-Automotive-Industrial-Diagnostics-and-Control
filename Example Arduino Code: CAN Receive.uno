#include <SPI.h>
#include <mcp_can.h>

const int SPI_CS_PIN = 5;
MCP_CAN CAN(SPI_CS_PIN);

void setup() {
  Serial.begin(115200);
  while (CAN_OK != CAN.begin(CAN_500KBPS)) {
    Serial.println("CAN BUS init failed");
    delay(100);
  }
  Serial.println("CAN BUS init success");
}

void loop() {
  unsigned char len = 0;
  unsigned char buf[8];

  if (CAN_MSGAVAIL == CAN.checkReceive()) {
    CAN.readMsgBuf(&len, buf);
    Serial.print("Data received: ");
    for (int i = 0; i < len; i++) {
      Serial.print(buf[i], HEX); Serial.print(" ");
    }
    Serial.println();
  }
}
