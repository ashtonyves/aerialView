import oscP5.*;
import proxml.*;

import java.util.Arrays;

OscP5 osc;
int port = 31842;
Timeline timeline;
SceneManager manager;

// background color
color bg = color(70,70,70);
int padding = 50;

  // hold all data from XML
  ArrayList<Camera> cameras;
  ArrayList<Actor> actors;
  ArrayList<Light> lights;
  ArrayList<Event> events;
  
// length of the scripted scene
int FPS = 30;
int NUMFRAMES = 300;
int CURRENTFRAME = 0;

boolean isPlaying;


  //------------------------------------------------------
void setup() {
  
  frameRate(FPS);
  
  // draw environment
  background(bg);
  size(displayWidth, displayHeight);
  
  //create the SceneManager
  manager = new SceneManager();
  timeline = new Timeline();
  
  isPlaying = false;

}

  //------------------------------------------------------
void draw() {
  background(bg);
  // TODO: UPDATE PLAYHEAD
  
  timeline.drawTracks();
  timeline.drawPlayhead(CURRENTFRAME);

  manager.drawScene();
  
  if(isPlaying ) {
    CURRENTFRAME++;
  } else {
    CURRENTFRAME = CURRENTFRAME;
  }
  
  
}


//**********************************************************
// dummy OSC messages
//**********************************************************



void keyPressed() {
 //println(keyCode);
 
 // SPACEBAR
 // toggles isPlaying
 if (keyCode == 32) {
  isPlaying = !isPlaying; 
 }
 
 if(key== 'a') {
  cameras.get(0).getState(0).setActive();
 }
}
