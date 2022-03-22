float lerpAmount = 0.0;
ArrayList<BezierShape> shapes = new ArrayList<BezierShape>();

void setup() {
  size(1280, 720);
  colorMode(RGB, 255, 255, 255, 100);
  //shapes.add(new BezierShape(color(250, 44, 40, 2)));
  //shapes.add(new BezierShape(color(250, 250, 40, 2)));
  shapes.add(new BezierShape(color(255, 255, 255, 2)));

  background(0);
}

class BezierShape {
  float[] x = new float[6];
  float[] y = new float[6];
  float[] xNew = new float[6];
  float[] yNew = new float[6];
  color colour;
  
  BezierShape(color c) {
    x = randomX();
    y = randomY();
    xNew = randomX();
    yNew = randomY();
    colour = c;
  }
  
  void restore() {
    x = xNew;
    y = yNew;
    xNew = randomX();
    yNew = randomY();
  }
  
  void mutate(float lerpAmount) {
      x[0] = lerp(x[0], xNew[0], lerpAmount);
      x[1] = lerp(x[1], xNew[1], lerpAmount);
      x[2] = lerp(x[2], xNew[2], lerpAmount);
      x[3] = lerp(x[3], xNew[3], lerpAmount);
      x[4] = lerp(x[4], xNew[4], lerpAmount);
      x[5] = lerp(x[5], xNew[5], lerpAmount);
      
      y[0] = lerp(y[0], yNew[0], lerpAmount);
      y[1] = lerp(y[1], yNew[1], lerpAmount);
      y[2] = lerp(y[2], yNew[2], lerpAmount);
      y[3] = lerp(y[3], yNew[3], lerpAmount);
      y[4] = lerp(y[4], yNew[4], lerpAmount);
      y[5] = lerp(y[5], yNew[5], lerpAmount);
  }

  float[] randomX() {
    var xArray = new float[6];
    
    xArray[0] = random(0, width/2);
    xArray[2] = random(width/2, width);
    xArray[1] = lerp(xArray[0], xArray[2], 0.5);
    xArray[3] = random(width/2, width);
    xArray[5] = random(0, width/2);
    xArray[4] = lerp(xArray[3], xArray[5], 0.5);
    
    return xArray;
  }
  
  float[] randomY() {
    var yArray = new float[6];
    
    yArray[0] = random(0, height/2);
    yArray[2] = random(0, height/2);
    yArray[1] = lerp(yArray[0], yArray[2], 0.5);
    yArray[3] = random(height/2, height);
    yArray[5] = random(height/2, height);
    yArray[4] = lerp(yArray[3], yArray[5], 0.5);
    
    return yArray;
  }
  
  void style() {
    noFill();
    strokeWeight(2);
    stroke(colour);
  }
  
  void display() {
    beginShape();
    vertex(x[1], y[1]);
    bezierVertex(x[2], y[2], x[3], y[3], x[4], y[4]);
    bezierVertex(x[5], y[5], x[0], y[0], x[1], y[1]);
    endShape();
  }
}

void draw() {
  lerpAmount += 0.001;
  for (BezierShape s : shapes) {
    if (lerpAmount < 0.2) {
      s.mutate(lerpAmount);
    } else {
      s.restore(); //<>//
      lerpAmount = 0.0;
    }
    s.style();
    s.display();
  }
}
