import oscP5.*;

OscP5 oscP5;
int frames = 60;
float cps;
float theta;
PVector start;
boolean on = true;
boolean state;
float intensity;
int elapsed;
float atk = 4;
float rel = 8;

void setup() {
  size(640, 320);
  smooth();
  frameRate(frames);
  oscP5 = new OscP5(this, 2020);
  start = new PVector(width/2, height/2);
  state = false;
  theta = 0;
  elapsed = 0;
  intensity = 0;
  background(0);
}

float calculateAngle(float cps) {
  return (cps * 2 * PI) / frames;
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

void draw() {
  //background(0);
  theta += calculateAngle(cps);
  var a = sin(theta/2); //<>//
  var disp = map(a, -1, 1, -100, 100); //<>//

  translate(start.x, start.y); //<>//
  //translate(disp, 0);
  
  calculateIntensity();

  noStroke();
  rectMode(CENTER);
  fill(intensity);
  rect(0, 0, 4*8, 24*8);
}

void oscEvent(OscMessage m) {
  // What happens when an incoming OSC message is received
  state = true;
  var msg = new Message(m);
  
  if (msg.cycle % 1 == 0 && cps == 0) {
    cps = msg.cps;
  } //<>//
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
