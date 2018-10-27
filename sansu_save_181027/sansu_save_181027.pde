import ddf.minim.*;

//Minim lib instances.
Minim minim;
AudioPlayer sound;
PGraphics pg;


/****************************/
/***********SETTING**********/
/****************************/

//Canvas size setting.
int gWidth = 2560;
int gHeight = 1440;

//I/O setting.
int bufferSize = 1024 - 1; //should be modified.
String path = "src/";
String fileName = "jindo";
String expander = ".mp3";
int fileNo = 0; /* don't touch */

//color setting.
float[] bgRGBA = {177.0 , 149.0 , 75.0, 100.0};
float[] strokeRGBA = {1.0 , 1.0 , 1.0, 10.0};

//need experiment... effect on slope of result
int slope = 450;
int sensitivity = 100;
float interval = 1.0; //interval betw x and next x

//want to export? then switch iWant = 0 to 2
//to make movie, you need to use "moviemaker" tool with exported files.
//0-> don't do, 1-> tif mode, 2->png mode
int iWant = 0;

/****************************/
/****************************/


//please don't touch!
void setup() {
  
  //set canvas size.
  size(gWidth, gHeight, P2D);
  pg = createGraphics(gWidth, gHeight);
  
  //sound variable set
  minim = new Minim(this);
  sound = minim.loadFile(path+fileName+expander, bufferSize);
  int length = sound.length();
  
  //177, 149, 75:: r, g, b, alpha(opacity)
//  background(177, 149, 75, 30);
//  background(bgRGBA[0] ,bgRGBA[1] ,bgRGBA[2], bgRGBA[3]);
  background(255);

  //play the music.
  sound.play();
}


void draw() {
  stroke(strokeRGBA[0], strokeRGBA[1], strokeRGBA[2], strokeRGBA[3]);
  pg.beginDraw();
  //strokeRGBA[3] is opacity, [1.0, 100.0]
  pg.stroke(strokeRGBA[0], strokeRGBA[1], strokeRGBA[2], strokeRGBA[3]);
  aStroke();
  pg.endDraw();
  SelectSequenceOutFormatMode();
}

void aStroke() {
  float gain = 0.0;
  float x = 0.0;
  while (x < gWidth) {
    gain = 0.0;
    for (int i = 0; i < bufferSize; i++) {
      gain += sound.mix.get(i);
    }
    float crit = gHeight/2 + (noise(x/sensitivity, gain)*slope);
    pg.point(x, crit);
    point(x, crit);
//    pg.point(x, gHeight + gain*10 - 100);
    x = x+interval;
  }
}

void SelectSequenceOutFormatMode() {
  switch(iWant) {
    case 1:
      saveFrame("tifOut/"+fileName+"-######.tif");
      break;
    case 2:
      pg.save("pngOut/"+fileName+"-"+fileNo++ +".png");
      break;
    default:
      break;
  }
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
//  save("screenshot/"+ stamp + "_" + fileName +".jpg");
  pg.save("screenshot/"+ stamp + "_" + fileName +".png");
}
