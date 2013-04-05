import oscP5.*;
import netP5.*;
import java.util.Arrays;

OscP5 oscP5;
int port = 31842;
NetAddress interfaceAddr;

Timeline timeline;
SceneManager manager;

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

// length of the scripted scene
int FPS = 30;
int NUMFRAMES = 300;
int CURRENTFRAME = 0; // start at 0

boolean isPlaying = false;
boolean isPositioningCamera = false;

// show timeline and tracks to start
boolean showTimeline = true;
boolean showTracks = true;



  //------------------------------------------------------
void setup() {
  
  font = loadFont("AbadiMT-CondensedLight-24.vlw");
  textFont(font);
  
  frameRate(FPS);
  
  // draw environment
  background(bg);
  size(displayWidth, displayHeight, P3D);
  smooth();
  
  //create the SceneManager
  manager = new SceneManager();
  timeline = new Timeline();
  
  oscP5 = new OscP5(this, port);
  // spoof OSC messages to yourself
  interfaceAddr = new NetAddress("127.0.0.1", port);

}

  //------------------------------------------------------
void draw() {
  background(bg);

  manager.drawCameras();
  
  
  
  timeline.drawTracks();
  timeline.drawPlayhead(CURRENTFRAME);

  manager.drawScene();
  
  if(isPlaying) {
    if(CURRENTFRAME < NUMFRAMES) {
      CURRENTFRAME++;
    } 
  } else {
    CURRENTFRAME = CURRENTFRAME;
    isPlaying = false;
  }

}


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
 
  
 
}
