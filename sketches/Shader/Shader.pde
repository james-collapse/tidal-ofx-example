import oscP5.*;

OscP5 oscP5;
PShader shader;
Message msg = new Message();
float[] bus = new float[4];

void setup() {
  size(640, 640, P2D);
  frameRate(60);
  noStroke();
  oscP5 = new OscP5(this, 2020);
  msg = new Message();
  shader = loadShader("bump.frag");
  shader.set("u_resolution", float(width), float(height));
}

void draw() {
  shader(shader);
  rect(0,0,width,height);
  
  shader.set("u_orbit_0", bus[0]);
  shader.set("u_orbit_1", bus[1]);
  shader.set("u_orbit_2", bus[2]);
  shader.set("u_orbit_3", bus[3]);
  
  advance();
}

void advance() {
  for (int i = 0; i < bus.length; i++) {
    bus[i] = bus[i] + 0.025;
  }
}

void oscEvent(OscMessage m){
  msg = new Message(m);
  
  routeMessage(msg);
  
  m.print();
}

void routeMessage(Message msg) {
  bus[msg.orbit] = 0.0;
}
