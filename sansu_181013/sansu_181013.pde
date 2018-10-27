import ddf.minim.*;

Minim minim;
AudioInput in;
AudioRecorder recoder;
PGraphics pg;

float time = 0;
//set the size of sansuhwa.
//tkstnghkrk rmfuwlf vhrrhk sjqlfmf tjfwjdgksek.
int gWidth = 2560;
int gHeight = 300;
int bufSize;
void setup() {
  //for 32inch monitor with QHD.
  size(2560, 1600, P2D);
  //for saving png image with transparent background
  //use PGraphic.
  pg = createGraphics(gWidth, gHeight);
  
  background(255);
  minim = new Minim(this);
  //create an instant of autdi input
  in = minim.getLineIn();
  bufSize = in.bufferSize() - 1;
}

void draw() {
  pg.beginDraw(); 
  pg.stroke(0, 1); //stroke(int rgb, float alpha: opacity of the stroke)
  //gksqjsdp rmflf ghlr tnfmf wjdgksek. 5sms gksqjsdp 5qjs rmflseksms Emt.
  //gksqjsdp rmfuwlsms ghlrdl aksgdmftnfhr ej Qkffl rmfuwlamfh dlwjsdml smRladl sksek.
  for(int i = 0; i < 100; i++) {
    aStroke(pg);
    //spin()dms wldustlzlsms wjdehfmf whwjdgkf tn dlTek.
    spin(1000);
  }
  pg.endDraw();
  //tkstnghk rmfladml dnlclfmf whwjdgksek. 0rhk 550dms rkrrkr 'x','y'dml rlwnswja.
  image(pg, 0, 550);
}

void aStroke(PGraphics pg) {
  float x = 0;
  while (x < gWidth) {
    float val = 0.0;
    //point(value of x, value of y)
    //point(x, height * noise(x/100, time));
    
    for (int i=0; i < bufSize; i++) {
      val = in.left.get(i)*50;
    }
    //set stroke...
    //durltj x/100dml 100dmf whwjdgkaus tkstpdml rnfrhrdmf whwjdgkf tn dlTek.
    float crit = gHeight * noise(x/100, val);
//    float crit = val*x*gHeight; //* noise(x/230, val);
    pg.point(x, crit);
    println(x + "::" + crit);
    x = x+1;
  }
}

void mouseClicked() {
  int m = millis();
  pg.save("sansu_export_at_"+m+".png");
}

void spin(int nu) {
  int obj = nu*10;
  int temp = 0;
  println("new line!");
  for (int i=0; i<obj; i++) {
    temp += 1;
    print(temp);
  }
}

