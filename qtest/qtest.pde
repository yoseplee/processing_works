import ddf.minim.*;
import ddf.minim.spi.AudioRecordingStream;
import ddf.minim.MultiChannelBuffer;

Minim minim;
AudioRecordingStream sound;
MultiChannelBuffer buf;

float[] samples;
void setup() {
  minim = new Minim(this);
  sound = minim.loadFileStream("milyang.mp3", 100, true);
  int len = sound.getMillisecondLength();
  sound.play();
  println(len);
}

void draw() {
  println(sound.isPlaying());
  float[] samples = sound.read();
  int size = samples.length;
  for(int i = 0; i < size; i++) {
    println(i + " :: " + samples[i]);
  }
  delay(100);
}


