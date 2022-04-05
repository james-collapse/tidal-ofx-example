import oscP5.*;

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
  shader.set("u_resolution", float(width), float(height));
}

void draw() {
  shader(shader);
  rect(0,0,width,height);
}

void oscEvent(OscMessage m){
  msg = new Message(m);
  shader.set("u_orbit", msg.orbit);
}
