
// Kinect Flow Example by Amnon Owed (15/09/12)

// import libraries
import processing.opengl.*; // opengl
import SimpleOpenNI.*; // kinect
import blobDetection.*; // blobs
import org.openkinect.freenect.*;
import org.openkinect.tests.*;
import org.openkinect.processing.*;
import org.openkinect.freenect2.*;
// this is a regular java import so we can use and extend the polygon class (see PolygonBlob)
import java.awt.Polygon;

// declare SimpleOpenNI object
SimpleOpenNI context;
Kinect2 kinect2;
// declare BlobDetection object
BlobDetection theBlobDetection;
// declare custom PolygonBlob object (see class for more info)
PolygonBlob poly = new PolygonBlob();

// PImage to hold incoming imagery and smaller one for blob detection
PImage cam, blobs;
PGraphics pg;
// the kinect's dimensions to be used later on for calculations
int kinectWidth = 640;
int kinectHeight = 720;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

// background color
color bgColor;
// three color palettes (artifact from me storing many interesting color palettes as strings in an external data file ;-)
String[] palettes = {
  "-1117720,-13683658,-8410437,-9998215,-1849945,-5517090,-4250587,-14178341,-5804972,-3498634", 
  "-67879,-9633503,-8858441,-144382,-4996094,-16604779,-588031", 
  "-16711663,-13888933,-9029017,-5213092,-1787063,-11375744,-2167516,-15713402,-5389468,-2064585"
};

// an array called flow of 2250 Particle objects (see Particle class)
Particle[] flow = new Particle[700];
// global variables to influence the movement of all particles


//Font and Image
PFont aCinemaB;
PFont aCinemaM;
PFont aCinemaMS;
PImage bicLogo;
PImage bicBox;
int baseLineLeft = 40;
int baseLineCenter = height/2;

void setup() {
  // it's possible to customize this, for example 1920x1080
  size(1280, 720, OPENGL);
  pg = createGraphics(kinectWidth, kinectHeight);

  kinect2 = new Kinect2(this);
  kinect2.initVideo();
  kinect2.initDevice();
  // calculate the reScale value
  // currently it's rescaled to fill the complete width (cuts of top-bottom)
  // it's also possible to fill the complete height (leaves empty sides)
  reScale = (float) height / kinectHeight;
  // create a smaller blob image for speed and efficiency
  blobs = createImage(kinectWidth/3, kinectHeight/3, RGB);
  // initialize blob detection object to the blob image dimensions -> chagne to the lib, blobDetection
  theBlobDetection = new BlobDetection(blobs.width, blobs.height);
  theBlobDetection.setThreshold(0.35);
  setupFlowfield();



  //Font and Image
  aCinemaB = createFont("aCinemaB.ttf", 40);
  aCinemaM = createFont("aCinemaM.ttf", 15);
  aCinemaMS = createFont("aCinemaM.ttf", 12);
  bicLogo = loadImage("bicLogo.png");

  bicLogo.resize(bicLogo.width/13, bicLogo.height/13);
  bicBox = loadImage("bicBox.png");
  bicBox.resize(bicBox.width/3, bicBox.height/3);
}

void draw() {
  // fading background
  //  background(240, 238, 226);

  background(240, 238, 226);
  pg.beginDraw();
  pg.noFill();
  pg.background(240, 238, 226);

  cam = kinect2.getVideoImage();
  //  cam.loadPixels();
  // copy the image into the smaller blob image
  blobs.copy(cam, 0, 0, cam.width, cam.height, 0, 0, blobs.width, blobs.height);
  // blur the blob image

  // detect the blobs
  theBlobDetection.computeBlobs(blobs.pixels);
  // clear the polygon (original functionality)
  poly.reset();
  // create the polygon from the blobs (custom functionality, see class)
  poly.createPolygon();
  //  drawFlowfield();
  drawFlowfield2();

  pg.endDraw();

  image(pg, width/2 - kinectWidth/2, height/2 - kinectHeight/2);


  //on left
  textFont(aCinemaM);
  textAlign(LEFT);
  fill(100);
  text("News", baseLineLeft+15, height/2 - 70);

  textFont(aCinemaMS);
  textAlign(LEFT);
  fill(150);
  text("01-wave", baseLineLeft+15, height/2 + 100);
  text("Hello no, I'll static son. you'll see", baseLineLeft+15, height/2 + 120);
  text("it's okay", baseLineLeft+15, height/2 + 140);
  text("BIC ballpen", baseLineLeft+15, 80);

  textFont(aCinemaB);
  textAlign(LEFT);
  fill(0);
  text("Your BIC possibilities,", baseLineLeft, height/2);
  text("start with a ", baseLineLeft, height/2 + 55);

  image(bicLogo, baseLineLeft+225, height/2 + 7);



  //on Right
  image(bicBox, width-300, height/2 - 70);
  textFont(aCinemaMS);
  textAlign(LEFT);
  fill(150);
  text("02-Cacedus", width-300, height/2 + 100);
  text("You know I can't hear none of that", width-300, height/2 + 120);
  text("spend the night shit", width-300, height/2 + 140);
}

void setupFlowfield() {
  // set stroke weight (for particle display) to 2.5
  pg.strokeWeight(0.7);
  // initialize all particles in the flow
  for (int i=0; i<flow.length; i++) {
    flow[i] = new Particle(i/10000.0);
  }
}

void drawFlowfield2() {
  // center and reScale from Kinect to custom dimensions
  //left-right / updown
  //  translate((width/2 - kinectWidth/2), height/2 - kinectHeight/2);
  //  scale(reScale);
  for (Particle p : flow) {
    p.updateAndDisplay();
  }
}

