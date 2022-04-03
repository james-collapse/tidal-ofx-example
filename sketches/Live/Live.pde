import oscP5.*;

OscP5 oscP5;
MyShape[] shapes = new MyShape[3];
int frames = 60;
float cps;
boolean state;
color backgroundColour;
Message testMessage = new Message();

class MyShape {
  PVector centre;
  color col;
  int mode;
  float shift;
  
  MyShape (PVector v, color c) {
    centre = v;
    col = c;
    mode = 0;
    shift = 0;
  }

  void switchMode() {
    switch(mode) {
      case 1:
        pushMatrix();
        fill(col);
        rect(0, 0, 200, 200);
        fill(backgroundColour);
        rect(0, 0, 168, 168);
        popMatrix();
        break;
      case 2:
        pushMatrix();
        translate(-84, 0);
        translate(shift*192, 0);
        fill(col);
        rect(0, 0, 16, 200);
        popMatrix();
        break;
      case 3:
        pushMatrix();
        translate(0, -84);
        translate(0, shift*192);
        fill(col);
        rect(0, 0, 200, 16);
        popMatrix();
        break;
      default:
        break;
    }
  }
  
  void display() { //<>//
    pushMatrix();
    translate(centre.x, centre.y, centre.z);
    rectMode(CENTER);
    switchMode(); //<>//
    popMatrix();
  }
  
  void update(Message msg) {
    mode = msg.mode;
    shift = msg.shift;
    col = color(255, 255, 255, 100);
    }
}

void setup() {
  size(1280, 720, P3D);
  colorMode(RGB, 255, 255, 255, 100);
  smooth();
  frameRate(frames);
  oscP5 = new OscP5(this, 2020);
  state = false;
  testMessage.cps = 2;
  testMessage.mode = 1;
  
  rectMode(CENTER);
  noStroke();
  
  var c = color(255, 0);
  backgroundColour = color(0, 0);
  
  shapes[0] = new MyShape(new PVector(width/4, height/2), c);
  shapes[1] = new MyShape(new PVector(width/2, height/2), c);
  shapes[2] = new MyShape(new PVector(3 * width/4, height/2), c);
  
  background(backgroundColour);
}

void draw() {
  background(backgroundColour);
  
  if(state) {
    for(MyShape s : shapes) {
      var c = s.col; //<>//
      var a = alpha(c); //<>//
      if(a > 0) {
        a -= 100/15;
        s.col = color(red(c), green(c), blue(c), a);  //<>//
      }
      s.display(); //<>//
    }
  }
}

void oscEvent(OscMessage m) { //<>//
  // What happens when an incoming OSC message is received
  state = true;

  var msg = new Message(m);
  m.print();
  
  shapes[msg.orbit].update(msg);
  
  if (msg.cycle % 1 == 0 && cps == 0) {
    cps = msg.cps;
  }
}

void mouseClicked() {
  state = true;
  shapes[testMessage.orbit].update(testMessage);
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
  int mode;
  float shift;
  
  Message() {
    cps = 0;
    cycle = 0;
    delta = 0;
    n = 0;
    orbit = 0;
    s = "";
    gain = 0;
    djf = 0;
    mode = 0;
    shift = 0;
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
          break;
        case "djf":
          djf = m.get(i+1).floatValue();
          break;
        case "mode":
          mode = m.get(i+1).intValue();
          break;
        case "shift":
          shift = m.get(i+1).floatValue();
          break;
      }
      ++i;
    }
  }
}
