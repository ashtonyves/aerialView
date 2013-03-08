import oscP5.*;
import proxml.*;

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
  
  // draw the scene
  manager.drawScene();
}

  //------------------------------------------------------
void draw() {
 
  
      // first camera hardcoded for now
    float[] startPos = {0.7f, 0.0f, 0.7f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.7f, 0.0f, -0.7f, 0.0f, 100.0f, 000.0f, -100.0f, 1f};
    int startFrame = 0;
    manager.addCamera(startPos, startFrame);
  
}
