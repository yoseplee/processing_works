import ddf.minim.*;

//Minim lib instances.
Minim minim;
AudioPlayer sound;

//Canvas size setting.
int gWidth = 2560;
int gHeight = 1440;

//I/O setting.
int bufferSize = 1024; //should be modified.
String path = "src/";
String fileName = "bonjo";
String expander = ".mp3";

//color setting.
float[] bgRGBA = {177.0 , 149.0 , 75.0, 100.0};
float[] strokeRGBA = {0.0 , 0.0 , 0.0, 10.0};

//need experiment... effect on slope of result
int slope = 450;
int sensitivity = 100;

//want to export? then switch iWant = 0 to 1
//to make movie, you need to use "moviemaker" tool with exported files.
int iWant = 1; //export ".ttf"s.

//please don't touch!
void setup() {
  //set canvas size.
  size(gWidth, gHeight);
  
  //sound variable set
  minim = new Minim(this);
  sound = minim.loadFile(path+fileName+expander, bufferSize);
  int length = sound.length();
  
  //177, 149, 75:: r, g, b, alpha(opacity)
//  background(177, 149, 75, 30);
  background(bgRGBA[0] ,bgRGBA[1] ,bgRGBA[2], bgRGBA[3]);
  
  //play the music.
  sound.play();
}

void draw() {
  
  //strokeRGBA[3] is opacity, [1.0, 100.0]
  stroke(strokeRGBA[0], strokeRGBA[1], strokeRGBA[2], strokeRGBA[3]);
 
  float gain = 0.0;
  float x = 0.0;
  while (x < gWidth) {
    gain = 0.0;
    for (int i = 0; i < bufferSize - 1; i++) {
      gain += sound.mix.get(i);
    }
//    println(gain);
    float crit = gHeight/2 + (noise(x/sensitivity, gain)*slope);
    point(x, crit);
    x = x+1;
  } 
  if(iWant == 1) saveFrame("tifOut/"+fileName+"-######.tif");
}

void mouseClicked() {
  int year = year();
  int month = month();
  int day = day();
  int hour = hour();
  int minute = minute();
  int second = second();
  int millis = millis();
  String stamp = year+""+month+""+day+"_"+hour+"_"+minute+"_"+second+"_"+millis;
  save("screenshot/"+ stamp + "_" + fileName +".jpg");
}
