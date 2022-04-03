import oscP5.*;
import Message.*;

OscP5 oscP5;
PShader shader;
float p;
Message msg;

void setup() {
  size(640, 640, P2D);
  noStroke();
  p = 0.0;
  oscP5 = new OscP5(this, 2020);
  msg = new Message();
  shader = loadShader("bump.frag");
}

void draw() {
  shader.set("u_resolution", float(width), float(height));
  shader.set("u_mouse", float(mouseX), float(mouseY));
  shader.set("u_time", millis() / 1000.0);
  
  if (p > 0.0) {
    p -= 0.05;
  }
  
  shader.set("u_pulse", p);
  shader.set("u_disp", msg.n);
  shader(shader);
  rect(0,0,width,height);
}

void oscEvent(OscMessage m){
  p = 1.0;
  msg = new Message(m);
}
