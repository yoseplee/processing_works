import processing.video.*;
//global variables for plotting x,y value
//
//float x;
//float y;


Particle[] particles;
//variable to hold onto Capture object.
Capture video;

void setup() {
  size(640, 480);
  background(255);
  //start x and y in the center...
  //constant width, height is top of the canvas, I think.
//  x = width/2;
//  y = height/2;
  //start the capture process
  video = new Capture(this, width, height, 60);
  video.start();
  
  particles = new Particle[10];
  for(int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(video);
  }
}

void captureEvent(Capture video) {
  //Read image from the camera
  video.read();
}

void draw() {
  for(int i = 0 ; i < particles.length; i++) {
    particles[i].Draw();
    particles[i].Move();
  }
}

class Particle {
  float x;
  float y;
  float newx;
  float newy;
  Capture video;

  public Particle() {
    x = width/2;
    y = height/2;
    newx = 0.0;
    newy = 0.0;
  }

  public Particle(Capture c) {
    x = width/2;
    y = height/2;
    video = c;
  }

  public void Draw() {
    //set for the point to move. [-20, 20]
    newx = constrain(x + random(-20, 20), 0, width);
    newy = constrain(y + random(-20, 20), 0, height-1);

    //find the mid-point out of the line
    int midx = int((newx + x) / 2);
    int midy = int((newy + y) / 2);

    //pick the color from the video.
    color c = video.pixels[(width-1-midx) + midy*video.width]; //??

    //stroke setting before draw something
    stroke(c, 90);
    strokeWeight(0.7);
    noFill();
    //Draw a line from (x, y) to (newx, newy)
    line(x, y, newx, newy);

    //Draw a curve from (x, y) to (newx, newy)
    float mostDifferent = (x * x) - (newx * newx);
    float yD = (y * y) - (newy * newy);
    float bPointX1 = 0.0;
    float bPointY1 = 0.0;
    float bPointX2 = 0.0;
    float bPointY2 = 0.0;
    if (mostDifferent < yD) mostDifferent = yD;

    //if two points are too close.
    //condition of classification: mostDifferent is the difference betw x^2 or y^2.
    if (mostDifferent * mostDifferent > 10000) {
      //set for sharp curve,
      bPointX1 = random(x-10, x+10);
      bPointY1= random(y-3000, y+3000);
      bPointX2 = random(newx-10, newx+10);
      bPointY2= random(newy-3000, newy+3000);
    }
    //else, set just curve.
    bPointX1 = random(x-10, x+10);
    bPointY1= random(y-300, y+300);
    bPointX2 = random(newx-10, newx+10);
    bPointY2= random(newy-300, newy+300);
    //draw curve
    curve(bPointX1, bPointY1, x, y, newx, newy, bPointX2, bPointY2);
  }

  public void Move() {
    //save (newx,newy) in x,y
    x = newx;
    y = newy;
  }
}

