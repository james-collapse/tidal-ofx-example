import oscP5.*;

OscP5 oscP5;
ArrayList<MyShape> shapes = new ArrayList<MyShape>();
int frames = 60;
float cps;
float theta;
PVector start;
boolean on = true;
boolean state;
float intensity;
int elapsed;
float atk = 3;
float rel = 8;

class MyShape {
  PVector centre;
  float rotation;
  
  MyShape (PVector v, float r) {
    centre = v;
    rotation = r;
  }
}

void setup() {
  size(1280, 720, P3D);
  smooth();
  frameRate(frames);
  oscP5 = new OscP5(this, 2020);
  start = new PVector(width/2, height/2);
  state = false;
  theta = 0;
  elapsed = 0;
  intensity = 0;
  
  for (int i = width/6; i <= width - width/6; i+=width/6) {
    var v = new PVector(i, height/2, 0);
    shapes.add(new MyShape(v, 0));
  }
  
  background(0);
}

void calculateIntensity() {
  if (state) {
    if (elapsed < atk) {
      // Ramp up the intensity
      intensity += 255/atk;
      elapsed++;
    } else if (elapsed >= atk && elapsed <= (atk + rel)) {
      // Ramp down the intensity
      intensity -= 255/rel;
      elapsed++;
    } else {
      // Reset the counter
      intensity = 0;
      elapsed = 0;
      state = false;
    }
  }
}

void display() {
  background(0);
  stroke(intensity);
  strokeWeight(2);
    
  for (MyShape s : shapes) {
    pushMatrix();
    translate(s.centre.x, s.centre.y, 0);
    rotateX(s.rotation);
    rotateY(s.rotation);
    rotateZ(s.rotation);
    rectMode(CENTER);
    rect(0, 0, 130, 130);
    fill(0);
    var t = random(90, 125);
    rect(0, 0, t, t);
    popMatrix();
  }
}

void calculatePosition() {
  for (MyShape s : shapes) {
    var r = random(10);
    
    if (r < 5) {
      s.rotation += radians(random(15));
    } else {
      s.rotation -= radians(random(15));
    }
  }
}

void draw() {
  calculateIntensity();
  display();
}

void oscEvent(OscMessage m) {
  // What happens when an incoming OSC message is received
  state = true;
  var msg = new Message(m);
  
  if (msg.cycle % 1 == 0 && cps == 0) {
    cps = msg.cps;
  }
  
  //if (msg.cycle % 2 == 0 && cps != 0) {
    calculatePosition();
  //}
}

class Message {
  float cps;
  float cycle;
  float delta;
  float n;
  float orbit;
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
