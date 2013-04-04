/**
* Camera
* 
* holds position, start time
* Methods to draw timeline icons and aerial displays based on flags.
* 
* Getters, setters to retrieve, edit values
* 
**/
import java.nio.FloatBuffer;
import java.util.Collections;
import java.util.Comparator;

 
public class Camera  {
  String  _name;       // MSB name (may be superfluous here) - use to identify selected cams with Kinect data
  int     _frame;
  FloatBuffer _transform;
   
  boolean _isSelectedForPositionInSpace;
  boolean _isSelectedForPositionInTime;
  boolean _isActive;
  boolean _isViolating;
  
  // these should not be loaded every time. Just once. Put in main class
  PImage iconDefault;
  PShape iconSelectedTime;
  PShape icondSelectedPos;
  
  //----------CONSTRUCTOR--------------------------------------------
  public Camera(int frame, float[] transform) {
    _transform = FloatBuffer.allocate(16);
    _transform.put(transform);
     
     _frame = frame;
    // put in main class
    loadShapes();
  }
  
  public Camera() {
    _transform = FloatBuffer.allocate(16);
    // put in main class
    loadShapes();
  }
  
  //------------------------------------------------------
  void loadShapes() {     
    iconDefault = loadImage("camera_neutral.png");
  }
 
 
      
 

  /*****************************************************************
    VISUALIZE OBJECT ON SCREEN 
  *****************************************************************/
  void draw() {
      drawOnTimeline();   // always
      drawInScene();      // only if its one of the three cameras
  }
  
  //------------------------------------------------------
  void drawOnTimeline() {
    
    // map the camera frame to the length of the timeline
    float xPos = map((float)_frame, 0, NUMFRAMES, timeline.getXStart(), timeline.getXEnd()); 
    float cDiameter = 45;
    float cPos = (timeline.getBottomTimeline()-timeline.timelineHeight)-15;
    
    fill(255);
    stroke(1);
    strokeWeight(3);
    // draw line
    line(xPos, timeline.getBottomTimeline(), xPos, (timeline.getBottomTimeline()-timeline.timelineHeight) );
    
    strokeWeight(0);    
    
    if(_isActive) {
       if(_isSelectedForPositionInSpace) {
          // nothing, because you don't see the timline when you are positioning the camera  
        }
        if (_isSelectedForPositionInTime) {
          fill(255,50);
          //TODO
         //triangle(xPos, cPos, xPos + 10, cPos, xPos+5, cPos+6);
      }
       ellipse(xPos, cPos, cDiameter, cDiameter);
    }
    
    if(_isViolating) {
      fill(255, 0, 0, 50);
      ellipse(xPos, cPos, cDiameter, cDiameter);
    }
    
    // always draw the camera icon
    image(iconDefault, xPos-25, (timeline.getBottomTimeline()-timeline.timelineHeight -40));
    
    // reset stroke weight
    strokeWeight(1);
}
  //------------------------------------------------------
  // TODO (see Cam.display())
  void drawInScene() {
    FloatBuffer fb  = getPosition();
    // draw the camera icon depending on its status
    
    
    // and transform it using position matrix
    
  }
 
  
  // SET THE STATE OF THE CAMERA
   //------------------------------------------------------
  public void setSelectedForPositionInSpace() {
   _isSelectedForPositionInSpace = true;
  }
  //------------------------------------------------------
  public void setSelectedForPositionInTime() {
    _isSelectedForPositionInTime = true;
  }
  //------------------------------------------------------
  public void deselect() {
    _isSelectedForPositionInSpace = false;
    _isSelectedForPositionInTime = false;
  }
  //------------------------------------------------------
  public void setActive() {
    //first set all cameras to inactive?
    _isActive = true;
  } 
  //------------------------------------------------------
  public void setViolating() {
    _isViolating = true;
  }
   
   
   
  //-----------------GETTERS/ SETTERS-------------------------------------
   public String getName() {
     return _name;
   }
  //------------------------------------------------------
  public void setName(String name) {
    _name = name;
  }
 //------------------------------------------------------
   public int getFrame() {
     return _frame;
   }
   //------------------------------------------------------
   public void setFrame(int frame) {
    _frame = frame; 
   }
  //------------------------------------------------------
   public void setPosition(float[] transform) {
     _transform.put(transform);
   }
   //------------------------------------------------------
   public FloatBuffer getPosition() {
     return _transform;
   }
   
  
}
  

