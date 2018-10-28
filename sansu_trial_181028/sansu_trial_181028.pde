import ddf.minim.*; //
Minim minim; 
AudioSample sound; 

int gWidth = 600;
int gHeight = 600;
float [] samplesVal;
int i = 0;

void setup() {
  minim = new Minim(this);
  sound = minim.loadSample("testFile.mp3");
  size(gWidth, gHeight);
  background(255);

  float[] leftSamples = sound.getChannel(AudioSample.LEFT);
  float[] rightSamples = sound.getChannel(AudioSample.RIGHT);
  samplesVal = new float[rightSamples.length];
  for (int i=0; i <rightSamples.length; i++) {
    samplesVal[i] = leftSamples[i]+ rightSamples[i];
  }
  i = 0;
}

void draw() {
  float gain = 0.0;
  float x = 0;
  while(x < gWidth) {
    gain = 0.0;
    for(; i < samplesVal.length - 1; i++) {
      gain += samplesVal[i];
    }
    println(i + "::"+gain);
    float crit = gHeight/2 + noise(x/100, gain)*300;
    point(x, crit);
    if(i == samplesVal.length) break;
    x += 1;
  }
}
