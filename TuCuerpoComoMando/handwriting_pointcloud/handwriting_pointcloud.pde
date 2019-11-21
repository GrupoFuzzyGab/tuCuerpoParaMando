// proyecto para 'la piel in/out'


import SimpleOpenNI.*;
import processing.opengl.*;


SimpleOpenNI kinect;
float rotation = 0;


ArrayList<PVector> handPositions;
PVector currentHand;
PVector previousHand;


void setup() {
  size(1024, 768, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  //enable depthMap generation
  kinect.enableDepth();
  // enable hands + gesture generation 
  kinect.enableGesture();
  kinect.enableHands();
  kinect.addGesture("RaiseHand"); 
  
    handPositions = new ArrayList(); 
  stroke(255, 0, 0);
  strokeWeight(2);
}
void draw() {
    background(0);
  kinect.update();
  /*
  
  //image(kinect.depthImage(), 0, 0);
  
    translate(width/2, height/2, -1000);
  // flip the point cloud vertically:
  rotateX(radians(180));
  // move the center of rotation
  // to inside the point cloud
  translate(0, 0, 1000);
  // rotate about the y-axis and bump the rotation
  rotateY(radians(rotation));
  rotation++;
  
  */
  
  
  stroke(255);
  PVector[] depthPoints = kinect.depthMapRealWorld();
  // notice: "i+=10"
  // only draw every 10th point to make things faster
  for (int i = 0; i < depthPoints.length; i+=10) {
    PVector currentPoint = depthPoints[i];
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }
  
  for (int i = 1; i < handPositions.size (); i++) { 
    
      currentHand = handPositions.get(i);
    previousHand = handPositions.get(i-1);
    line(previousHand.x, previousHand.y, currentHand.x, currentHand.y);
  }
}
// -----------------------------------------------------------------
// hand events 
void onCreateHands(int handId, PVector position, float time) {
  kinect.convertRealWorldToProjective(position, position);
  handPositions.add(position);
}

void onUpdateHands(int handId, PVector position, float time) {
  kinect.convertRealWorldToProjective(position, position);
  handPositions.add(position);
}
void onDestroyHands(int handId, float time) {
  handPositions.clear();
  kinect.addGesture("RaiseHand");
}
// -----------------------------------------------------------------
// gesture events 
void onRecognizeGesture(String strGesture, 
PVector idPosition, 
PVector endPosition)
{
  kinect.startTrackingHands(endPosition);
  kinect.removeGesture("RaiseHand");
}

