import oscP5.*;

OscP5 oscP5;
int frames = 30;
float cps;
boolean state;
PVector acceleration;
Point point;
boolean dir = true;

class Point {
  PVector location;
  PVector velocity;
  float topSpeed;
  
  Point() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    topSpeed = 5;
  }
  
  void update() {
    // Rebound if the shape reaches the middle of the screen
    if(location.y > height/2) {
      velocity.y = velocity.y * -0.8;
      location.y = height/2;
    }
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topSpeed);
    // Location changes by velocity
    location.add(velocity);
  }
  
  float vMagnitude() {
    return mag(velocity.x, velocity.y);
  }
  
  void display() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(location.x, location.y, 48, 4);
  }
}

void setup() {
  size(1280, 720, P3D);
  smooth();
  frameRate(frames);
  oscP5 = new OscP5(this, 2020);
  state = false;
  
  point = new Point();
  var dir = new PVector(width/2, height/2 + 1);
  acceleration = PVector.sub(dir, point.location);
  acceleration.setMag(0.15);
  
  background(0);
}

void draw() {
  background(0);
  
  if(state) {
    point.update();
    point.display();
  }
}

void oscEvent(OscMessage m) {
  // What happens when an incoming OSC message is received
  state = true;
  var msg = new Message(m);

  point.velocity.y = -2;
  
  if (msg.cycle % 1 == 0 && cps == 0) {
    cps = msg.cps;
  }
}

class Message {
  float cps;
  float cycle;
  float delta;
  float n;
  int orbit;
  String s;
  float gain;
  float djf;
  
  Message() {
    cps = 0;
    cycle = 0;
    delta = 0;
    n = 0;
    orbit = 0;
    s = "";
    gain = 0;
    djf = 0;
  }

  Message(OscMessage m) {
    int i;

    for(i = 0; i < m.typetag().length(); ++i) {
      String name = m.get(i).stringValue();
      switch(name) {
        case "cps":
          cps = m.get(i+1).floatValue();
          break;
        case "cycle":
          cycle = m.get(i+1).floatValue();
          break;
        case "delta":
          delta = m.get(i+1).floatValue();
          break;
        case "n":
          n = m.get(i+1).floatValue();
          break;
        case "orbit":
          orbit = m.get(i+1).intValue();
          break;
        case "s":
          s = m.get(i+1).stringValue();
          break;
        case "gain":
          gain = m.get(i+1).floatValue();
        case "djf":
          djf = m.get(i+1).floatValue();
      }
      ++i;
    }
  }
}
