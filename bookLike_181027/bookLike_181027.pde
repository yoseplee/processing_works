import ddf.minim.*; //
import java.util.ArrayList;
Minim minim; 
AudioSample sound; 

int gWidth = 2560;
int gHeight = 1440;
float [] samplesVal;
FloatList sampleAverage;
ArrayList<Float> data;

void setup() {
  minim = new Minim(this);
  sound = minim.loadSample("testFile.mp3");
  size(2560, 1440);
  background(255);

  data = new ArrayList<Float>();

  float[] leftSamples = sound.getChannel(AudioSample.LEFT);
  float[] rightSamples = sound.getChannel(AudioSample.RIGHT);
  samplesVal = new float[rightSamples.length];
  for (int i=0; i <rightSamples.length; i++) {
    samplesVal[i] = leftSamples[i]+ rightSamples[i];
  }
  
  sampleAverage = new FloatList();
  int crit = 1024; // 2045, 8192, 16384...
  int average=0;
  for (int i = 0; i< samplesVal.length; i+=1) {
    average += abs(samplesVal[i])*1000 ; // sample are low value so *1000
    if ( i % crit == 0 && i!=0) { 
      sampleAverage.append( average / crit);
      average = 0;
    }
  }
}

int i = 0;
void draw() {
  int len = samplesVal.length;
  float x = 0.0;
  stroke(0, 100);
  //strokeWeight(10);
  while(x < gWidth) {
    float gain = samplesVal[i];
    i += 1;
    if(i > len - 1) i = 0;
    point(x, gHeight/2 + gain * 1000);
    //println("drawing...");
    x += 0.0001;
    //if(x > gWidth) x = 0.0;
  }
  
  println("draw once");
  //delay(1000);
}
