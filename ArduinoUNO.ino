#include <Servo.h>

const int trigPin = 9;
const int echoPin = 10;
Servo servo;

void setup() {
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  servo.attach(6);
}

void loop() {
  int pos;
  
  // servo motoru 0-180 derece arasında hareket ettir
  for (pos = 0; pos <= 180; pos += 1) {
    servo.write(pos);
    delay(15);
    
    // ultrasonik sensörle engel tespiti
    long duration, distance;
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
    duration = pulseIn(echoPin, HIGH);
    distance = duration * 0.034 / 2;
    
    if (distance < 20) {
      Serial.println(distance);
    } else {
      Serial.println("0");
    }
  }
  
  // servo motoru 180-0 derece arasında hareket ettir
  for (pos = 180; pos >= 0; pos -= 1) {
    servo.write(pos);
    delay(15);
    
    // ultrasonik sensörle engel tespiti
    long duration, distance;
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
    duration = pulseIn(echoPin, HIGH);
    distance = (duration * 0.034) / 2;
    
    if (distance < 20) {
      Serial.println(distance);
    } else {
      Serial.println("0");
    }
  }
}
