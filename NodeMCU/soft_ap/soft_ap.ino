#include <ESP8266WiFi.h>

const char* ssid = "NodeMCU";
const char* password = "bioguarded";

void setup()
{
  Serial.begin(115200);
  Serial.println();

  Serial.print("Setting soft-AP ... ");
  boolean result = WiFi.softAP(ssid, password);
  if(result == true)
  {
    Serial.println("Ready to connect!");
  }
  else
  {
    Serial.println("Failed to setup!");
  }
}

void loop()
{
  Serial.printf("Stations connected = %d\n", WiFi.softAPgetStationNum());
  delay(3000);
}
