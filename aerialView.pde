import oscP5.*;
import proxml.*;

import java.util.Arrays;

OscP5 osc;
int port = 31842;
Timeline timeline;
SceneManager manager;

// background color
color bg = color(70,70,70);

// length of the scripted scene
public final int maxFrames = 3000;

  //------------------------------------------------------
void setup() {

  // draw environment
  background(bg);
  size(displayWidth, displayHeight);
  
  //create the SceneManager
  manager = new SceneManager();
  
  // draw the timeline
  timeline = new Timeline();
  
  
}

  //------------------------------------------------------
void draw() {
 // draw the scene from SceneManager data
  manager.drawScene();
  
}
