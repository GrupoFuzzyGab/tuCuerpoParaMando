import SimpleOpenNI.*;
SimpleOpenNI kinect;

int smallPoint, largePoint;

void setup() {
  size(640*2, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  
  //img = loadImage("PImage rgbImage");
  
  smallPoint = 4;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  background(255);
}


void draw() {
  
  PImage depthImage = kinect.depthImage();
PImage rgbImage = kinect.rgbImage();
kinect.update();

image(depthImage, 0, 0);
image(rgbImage, 640, 0);

  float pointillize = map(mouseX, 0, width, smallPoint, largePoint);
  int x = int(random(rgbImage.width));
  int y = int(random(rgbImage.height));
  color pix = rgbImage.get(x, y);
  fill(pix, 128);
  ellipse(x, y, pointillize, pointillize);
}  

