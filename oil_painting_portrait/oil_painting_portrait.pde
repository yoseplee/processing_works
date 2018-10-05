import processing.video.*;

Particle[] particles;
Capture frog;
void setup() {
  size(640, 480);
  frog = new Capture(this, 640, 480);
  frog.start();
  particles = new Particle [2500];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
  background(0);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  for (int i = 0; i < particles.length; i++) {
    particles[i].display();
    particles[i].move();
  }
}

class Particle {
  float x;
  float y;
  
  float vx;
  float vy;

  Particle() {
    x = width/2;
    y = height/2;
    float a = random(TWO_PI);
    float speed = random(1,2);
//    float speed = random(1,50);
    vx = cos(a)*speed;
    vy = sin(a)*speed;
  }

  void display() {
    noStroke();
    color c = frog.get(int(x),int(y));
//    fill(c,25);
    fill(c,50); // -> latter parameter is opacity.
//    ellipse(x, y, 12, 12);
    triangle(x, y, x+12, y-24, x+12+12, y);
//    triangle(x, y, 12, 12, 12, 12);
//    ellipse(x, y, 14, 14); //-> manage the size of single dots
  }

  void move() {
    x = x + vx;//random(-5, 5);
//    x = x + random(-5, 5);
    y = y + vy;//random(-5, 5);
//    y = y + random(-5, 5);
    if (y < 0) {
      y = height;
    } 

    if (y > height) {
      y = 0;
    }
    if (x < 0) {
      x = width;
    } 

    if (x > width) {
      x = 0;
    }
  }
}
