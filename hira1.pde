import processing.serial.*;

Serial port;
int xPos = 0;
float yPos = 0;
boolean obstacleDetected = false;

void setup() {
  size(800, 400);
  smooth();
  frameRate(60);
  background(255);
  stroke(0);
  port = new Serial(this, "COM5", 9600); // Arduino'nun seri port bağlantısı
}

void draw() {
  background(255);
  stroke(0);

  // X eksenindeki çizgi
  line(0, height/2, width, height/2);

  // Engelin tespit edildiği durumda
  if (obstacleDetected) {
    fill(255, 0, 0);
    ellipse(xPos, height/2 - yPos, 20, 20);
    text("Distance: " + distToString(yPos), xPos+20, height/2 - yPos - 20);
    text("Angle: " + angleToString(xPos), xPos+20, height/2 - yPos);
  }

  // Seri port üzerinden gelen verileri oku
  while (port.available() > 0) {
    String message = port.readStringUntil('\n');
    if (message != null) {
      float distance = parseFloat(message.trim());
      if (!Float.isNaN(distance)) {
        // Engeli tespit ettik
        obstacleDetected = true;
        yPos = map(distance, 0, 20, 0, height/2);
      } else {
        // Engel yok
        obstacleDetected = false;
      }
    }
  }

  // Y eksenindeki çizgi
  line(xPos, 0, xPos, height);
  xPos++;
  if (xPos >= width) {
    xPos = 0;
  }
}

String distToString(float distance) {
  if (distance < 10) {
    return nf(distance, 1, 2) + " cm";
  } else {
    return nf(distance, 1, 1) + " cm";
  }
}

String angleToString(int angle) {
  int mappedAngle = PApplet.parseInt(map(angle, 0, width, -90, 90));
  return nf(mappedAngle, 3) + "°";
}
