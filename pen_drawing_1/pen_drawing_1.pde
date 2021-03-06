import processing.video.*;
//global variables for plotting x,y value

float x;
float y;

//variable to hold onto Capture object.
Capture video;

void setup() {
  size(640, 480);
  background(255);
  //start x and y in the center...
  //constant width, height is top of the canvas, I think.
  x = width/2;
  y = height/2;
  //start the capture process
  video = new Capture(this, width, height, 60);
  video.start();
}

void captureEvent(Capture video) {
  //Read image from the camera
  video.read();
}

void draw() {
  video.loadPixels();
  //constrain(amt, low, high).. Constrains a value to not exceed a maximum and minimum value.
  float newx = constrain(x + random(-20, 20), 0, width);
  float newy = constrain(y + random(-20, 20), 0, height-1);

  //find the mid-point of the line
  int midx = int((newx + x) / 2);
  int midy = int((newy + y) / 2);

  //pick the color from the video, reversing x
  color c = video.pixels[(width-1-midx) + midy*video.width]; //??

  //Stroke Settring before draw something 
  stroke(c, 90);
  strokeWeight(0.7); //same as the weight of big ballpen.
  noFill();

  //Draw a line from (x,y) to (newx, newy)
  line(x, y, newx, newy);


  //Draw a curve from (x,y) to (newx, newy), if they are too close, its slope be expntly
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

  /*
  //Draw [3, 8] random ellpise which center point is (midx, midy)
   int rIter = int(random(4, 8));
   float rNoise1 = random(-100, 100);
   float rNoise2 = random(-100, 100);
   int dLen = 50;
   for (int i = 0; i < rIter; i++) {
   ellipse(midx, midy, dLen+rNoise1, dLen+rNoise2);
   }
   */


  //save (newx,newy) in x,y
  x = newx;
  y = newy;
}

