import oscP5.*;

OscP5 oscP5;
int frames = 60;
float cps;
boolean state;
PVector p1;
PVector p2;
Point startPoint;
Boolean dir = true;

class Point {
  PVector centre;
  PVector velocity;
  
  Point(PVector c) {
    centre = c;
    velocity = new PVector(0, 0);
  }
  
  void display() {
    fill(255);
    ellipseMode(CENTER);
    ellipse(centre.x, centre.y, 10, 10);
  }
  
  void impulse(PVector v) {
    velocity = v;
  }
  
  void move() {
    translate(velocity.x/4, velocity.y);
  }
  
  void slow() {
    if(velocity.x == 0) {
      velocity.x += 5;
    }
  }
}

void setup() {
  size(1280, 720, P3D);
  smooth();
  frameRate(frames);
  oscP5 = new OscP5(this, 2020);
  state = false;
  
  p1 = new PVector(width/2, height/2);
  startPoint = new Point(p1);
  
  background(0);
}

void draw() {
  background(0);
  
  if(state) {
    startPoint.move();
    startPoint.display();
    startPoint.slow();
  }
}

void oscEvent(OscMessage m) {
  // What happens when an incoming OSC message is received
  state = true;
  var msg = new Message(m);
  
  if(dir) {
    startPoint.impulse(new PVector(100, 0));
  } else {
    startPoint.impulse(new PVector(-100, 0));
  }
  
  dir = !dir;
  
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
