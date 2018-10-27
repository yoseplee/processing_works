import ddf.minim.*;
import ddf.minim.spi.AudioRecordingStream;
import ddf.minim.MultiChannelBuffer;

Minim minim;
AudioPlayer sound;
PGraphics pg;
int bufferSize = 3000; //should be modified.
int gWidth = 400;
int gHeight = 400;

void setup() {
  size(gWidth, gHeight);
  pg = createGraphics(gWidth, gHeight);
  minim = new Minim(this);
  sound = minim.loadFile("milyang.mp3", bufferSize);
  int length = sound.length();
  background(255);
  sound.play();
}

float opa = 100.0f;

void draw() {
  
  stroke(0, opa);
 
  float gain = 0.0;
  float x = 0.0;
  while (x < gWidth) {
    gain = 0.0;
    for (int i = 0; i < 1024; i++) {
      gain += sound.mix.get(i) * 50;
      println(gain);
    }
    
//    float crit = 250 * noise(x/100, gain);
//    float crit = gain* 100 * noise(x/100, gain);
    point(x, gHeight/2 + gain);
    x = x+1;
  } 
  

/*
  pg.beginDraw(); 
  pg.stroke(0, opa);
//  pg.strokeWeight(0.0001f);
 
  float gain = 0.0;
  float x = 0.0;
  while (x < gWidth) {
    gain = 0.0;
    for (int i = 0; i < bufferSize - 1; i++) {
      gain += sound.mix.get(i);
    }
    println(gain);
    float crit = gHeight * noise(x/100, gain);
    pg.point(x, crit);
//    pg.line(x,y, x+1, gain);
    x = x+1;
//    y = gain;
  } 
    
//  aStroke(pg);
  pg.endDraw();
  image(pg, 0, 0);
  */
  
}

//void aStroke(PGraphics pg) {
//  float x = 0;
//  while (x < gWidth) {
//    float val = 0.0;
//    //point(value of x, value of y)
//    //point(x, height * noise(x/100, time));
//
//    for (int i=0; i < 1023; i++) {
//      val = sound.mix.get(i)*50;
//      println(val);
//    }
//    //set stroke...
//    //durltj x/100dml 100dmf whwjdgkaus tkstpdml rnfrhrdmf whwjdgkf tn dlTek.
//    float crit = gHeight * noise(x/100, val);
//    //    float crit = val*x*gHeight; //* noise(x/230, val);
//    pg.point(x, crit);
//    x = x+1;
//  }
//}

void mouseClicked() {
  int m = millis();
  sound.pause();
//  pg.save("sansu_export_at_"+m+".png");
}
