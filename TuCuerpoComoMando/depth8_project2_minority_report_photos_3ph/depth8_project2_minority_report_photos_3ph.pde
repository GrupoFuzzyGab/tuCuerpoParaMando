import SimpleOpenNI.*;
SimpleOpenNI kinect;
int closestValue;
int closestX;
int closestY;
float lastX;
float lastY;
float image1X;
float image1Y;
// declare variables for
// image scale and dimensions
float image1scale;
int image1width = 100;
int image1height = 100;

float image2X;
float image2Y;
float image2scale;
int image2width = 100;
int image2height = 100;
float image3X;
float image3Y;
float image3scale;
int image3width = 100;
int image3height = 100;
// keep track of which image is moving
int currentImage = 1;
// declare variables
// to store the images
PImage image1;
PImage image2;
PImage image3;
void setup()
{
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  // load the images
  image1 = loadImage("image1.png");
  image2 = loadImage("image2.png");
  image3 = loadImage("image3.png");
}
void draw() {
  background(0);
  closestValue = 8000;
  kinect.update();
  int[] depthValues = kinect.depthMap();
  for (int y = 0; y < 480; y++) {
    for (int x = 0; x < 640; x++) {
      int reversedX = 640-x-1;
      int i = reversedX + y * 640;
      int currentDepthValue = depthValues[i];
      if (currentDepthValue > 610 && currentDepthValue < 1525
        && currentDepthValue < closestValue) {
        closestValue = currentDepthValue;
        closestX = x;
        closestY = y;
      }
    }
  }
  float interpolatedX = lerp(lastX, closestX, 0.3);
  float interpolatedY = lerp(lastY, closestY, 0.3);
  // select the current image
  switch(currentImage) { 
    case 1:
    // update its x-y coordinates
    // from the interpolated coordinates
    image1X = interpolatedX; 
      image1Y = interpolatedY;
    // update its scale
    // from closestValue
    // 0 means invisible, 4 means quadruple size
    image1scale = map(closestValue, 610, 1525, 0, 4);
    break;
  case 2:
    image2X = interpolatedX;
    image2Y = interpolatedY;
    image2scale = map(closestValue, 610, 1525, 0, 4);
    break;
  case 3:
    image3X = interpolatedX;
    image3Y = interpolatedY;
    image3scale = map(closestValue, 610, 1525, 0, 4);
    break;
  }
  // draw all the image on the screen
  // use their saved scale variables to set their dimensions
  image(image1, image1X, image1Y, 
  image1width * image1scale, image1height * image1scale); 
    image(image2, image2X, image2Y, 
  image2width * image2scale, image2height * image2scale);
  image(image3, image3X, image3Y, 
  image3width * image3scale, image3height * image3scale);
  lastX = interpolatedX;
  lastY = interpolatedY;
}
void mousePressed() {
  // increase current image
  currentImage++;
  // but bump it back down to 0
  // if it goes above 3
  if (currentImage > 3) {
    currentImage = 1;
  }
  println(currentImage);
}

