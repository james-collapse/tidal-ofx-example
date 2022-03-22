ArrayList<Wave> waves = new ArrayList<Wave>();
float theta = 0.0;
float rho = 0.0;
int numWaves = 16;
int numParticles = 24;

void setup() {
  size(1280, 720);
  frameRate(50);
  smooth();
  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);
  
  var ymin = height/2 - 400;
  var ymax = height/2 + 400;
  
  for (float y = ymin; y < ymax; y += (ymax - ymin)/numWaves) {
    waves.add(new Wave(y, map(y, ymin, ymax, 24, 48)));
  }

  background(0);
}

class Particle {
  PVector centre;
  float size;
  float yinit;
  float xinit;
  
  Particle(PVector c, float s) {
    centre = c;
    size = s;
    xinit = c.x;
    yinit = c.y;
  }
  
  float height(float amplitude, float theta) {
    return (amplitude * sin(theta)) + (0.5 * sin(2*theta));
  }
  
  void calculate(float a, float t) {
    centre.y = yinit + height(a, t);
  }
  
  void display(float t) {
    pushMatrix();
    noStroke();
    fill(255, 75);
    translate(centre.x, centre.y);
    rect(0, 0, size * sin(t), size * sin(t));
    popMatrix();
  }
}

class Wave {
  float amplitude;
  float period;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  Wave(float ypos, float a) {
    amplitude = a;
    var xmin = (width/2) - 800;
    var xmax = (width/2) + 800;

    for (float x = xmin; x < xmax; x += (xmax - xmin)/numParticles) {
      particles.add(new Particle(new PVector(x, ypos), random(24)));
    }
  }
  
  void calculatePosition(float theta, float r) {
    var t = theta;
    var xdisp = 10 * sin(r);
    
    for (Particle p : particles) {
      p.calculate(amplitude, t);
      p.centre.x = p.xinit + xdisp;
      t += 0.4;
    }
  }
  
  void displayParticle(float t) {
    for (Particle p : particles) {
      p.display(t);
    }
  }
  
  void displayWave() {
    for (int i = 1; i < particles.size(); i ++) {
      strokeWeight(2);
      stroke(255, 100);
      var thisParticle = particles.get(i).centre;
      var lastParticle = particles.get(i - 1).centre;
      line(lastParticle.x, lastParticle.y, thisParticle.x, thisParticle.y);
    }
  }
}

void draw() {
  background(0);
  var r = rho;
  
  for (Wave w : waves) {
    w.calculatePosition(theta, r);
    w.displayParticle(r);
    r += (TWO_PI/numWaves);
  }
  theta += 0.005;
  rho += 0.005;
}
