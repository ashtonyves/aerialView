import oscP5.*;
import netP5.*;
import java.util.Arrays;

Timeline timeline;
SceneManager manager;
Pilot pilot;

// background color
color bg = color(70,70,70);
PFont font;
float padding = 20;

// hold all data from XML
ArrayList<Camera> cameras;
ArrayList<Actor> actors;
ArrayList<Light> lights;
ArrayList<Event> events;

Camera currentCamera = null;
Camera previousCamera = null;
Camera nextCamera = null;


float globalCameraX = 600;
float globalCameraY = 530;//-200;
float globalCameraZ = -336;


// length of the scripted scene
int FPS = 30;
int NUMFRAMES = 300;
int CURRENTFRAME = 0; // start at 0

boolean isPlaying = false;
boolean isPositioningCamera = false;

// show timeline and tracks to start
boolean showTimeline = true;
boolean showTracks = true;
boolean showErrors = false;

PImage ic_alert;

  //------------------------------------------------------
void setup() {
  
  frameRate(FPS);
  
  // draw environment
  background(bg);
  font = loadFont("AbadiMT-CondensedLight-24.vlw");
  textFont(font);
  size(1280, 720, OPENGL);
  noStroke();
  smooth(4);
  
  //create the SceneManager
  manager = new SceneManager();
  timeline = new Timeline();
  pilot = new Pilot();
  
  // move to error class. load once.
  ic_alert = loadImage("ic_alert.png");

}

  //------------------------------------------------------
void draw() {
  resetMatrix();
  camera();



  //rotateX(HALF_PI);
  //translate(globalCameraX, globalCameraY, globalCameraZ);
  background(bg);
  timeline.drawTracks();
  timeline.drawPlayhead(CURRENTFRAME);
  manager.drawCameras();  
  manager.drawScene();
  

  // TODO: put into error class
  drawErrorVisualizations();  
  drawErrorMessage();
   
  if(isPlaying) {
    if(CURRENTFRAME < NUMFRAMES) {
      CURRENTFRAME++;
    } 
  } else {
    CURRENTFRAME = CURRENTFRAME;
    isPlaying = false;
  }

}

/****************************************** refactor into  own class ErrorManager ********************/
void drawErrorVisualizations() {
  // simulate cutting on action
  if(showErrors == true) {
     noStroke();
     fill(color(255,0,0), 40);
     stroke(color(255,0,0));
     
     // should be detected through AI logic, not hardcoded to the star and end frame of a particular event
     float violationFrame1 = events.get(0).getEndFrame(); // frame where overlapping shot 2 begins
     float violationFrame2 = events.get(1).getStartFrame(); // frame where overlapping 1 shots ends
     float intersect1 = map(violationFrame1-15, 0, NUMFRAMES, timeline.x, timeline.x+timeline.frameWidth);
     float intersect2 =  map(violationFrame2-15, 0, NUMFRAMES, timeline.x, timeline.x+timeline.frameWidth);
     float vioWidth = map(30, 0, NUMFRAMES, 0, timeline.frameWidth);
     
     rect(intersect1, height, vioWidth, -400);
     rect(intersect2, height, vioWidth, -400);
  }

}

void drawErrorMessage() {
  if (showErrors == true) {
  // error area in top right corner
  fill(color(255,0,0), 60);
  int errorX = width - 400;
  int errorY = 20;
  int errorHeight = 80;
  int errorWidth = 380; 
  int padding = 5;
  noFill();
  
  fill(255);
  String errorTitle = "Cutting on Action"; // title
  String errorDescription = "Two events with the same actor overlap. Scrub the camera outside the red area to seamlessly cut on action. Or, point the camera away from this character.";
  String errorMessage = errorTitle + "\n" + errorDescription;
  textSize(15);
  text(errorMessage, 
    errorX + padding, 
    errorY + padding, 
    errorWidth - padding, 
    errorHeight - padding);
  image(ic_alert, 
    errorX - 20,
    errorY + 30);
  } 
}
/****************************************** end refactoring ********************/

//**********************************************************
// dummy OSC messages
//*****************************************************

void keyPressed() {
 println("key pressed: " + keyCode);
 
 // SPACEBAR toggles playback
 if (keyCode == 32) {
  if (!isPositioningCamera) {
    // don't allow user to play the scene while positioning a camera
    isPlaying = !isPlaying; 
  }
 }
 
 //BACKSPACE reset playhead
 if (keyCode == 8) {
  isPlaying = false;
  CURRENTFRAME = 0;
 }
 
 // - DELETE CAMERA
 if (keyCode == 45) {
   manager.deleteCamera();  
 }
 
 // + ADD CAMERA
 if (keyCode == 61) {
   manager.addCamera(); 
 }
 
   // default -- no hands in frame. keep all as it was before, but allow playback
  if(key== '0') {
    isPositioningCamera = false;
  }

 // one hand in frame - hide the timeline
  if(key== '1') {
  isPositioningCamera = true;
  //showTimeline = false;
  showTracks = false;
  // and stop the movie from playing, if it's playing
  // NOTE: this might not be the effect you want.
  // you might want to view the ongoing scene while positioning a camera
  if(isPlaying) {
    isPlaying = false;
  }
 }
 
 // two hands in frame - show the timeline
  if(key== '2') {
  isPositioningCamera = false;  
  showTimeline = true;
  showTracks = true;
 }
 
 
 // simulate Cutting on Action Violation
  if(key== 'v') {
  if (showTracks == true) {
    if(showErrors == true) {
      showErrors = !showErrors;
      if(cameras.size() > 3 ) {
       cameras.get(3)._isViolating = false; // Hey Rule Checker, check that this camera is violating on every frame. Else it will remain red.
      } 
    } else {
     showErrors = true;
    if(cameras.size() > 3 ) {
     cameras.get(3).setViolating(); // Hey Rule Checker, check that this camera is violating on every frame. Else it will remain red.
    }  
   } 
  }
  }
 
}
