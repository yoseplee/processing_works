import SimpleOpenNI.*;
SimpleOpenNI kinect;

void Setup()
{
  size(640*2, 480);
  kinect = new SimpleOpenNI(this);
  
  kinect.enableDepth();
  kinect.enableRGB();
}

void Draw()
{
  kinect.update();
  
  image(kinect.depthImage(), 0, 0);
  image(kinect.rgbImage(), 640, 0);
}

