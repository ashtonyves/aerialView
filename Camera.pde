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
  float _fov = 45;
  
  boolean _isSelectedForPositionInSpace;
  boolean _isSelectedForPositionInTime;
  boolean _isActive;
  boolean _isViolating;
  boolean _isDisplayed; // the cameras active before and after the currently active camera
  
  // these should not be loaded every time. Just once. Put in main class
  PImage iconDefault;
  PShape iconSelectedTime;
  PShape icondSelectedPos;
  
  //----------CONSTRUCTOR--------------------------------------------
  public Camera(int frame, float[] transform) {
    _transform = FloatBuffer.allocate(16);
    _transform.put(transform);
    _frame = frame;
  }
  
  public Camera() {
    _transform = FloatBuffer.allocate(16);
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
    float cDiameter = 15;
    float cPos = (timeline.topTimeline)-(cDiameter/2);

    // DEAFULT CAMERA STYLE
    stroke(1);
    strokeWeight(1);
    // draw line
    line(xPos, timeline.topTimeline, xPos, (timeline.topTimeline+(timeline.timelineHeight)/2 ) );
    strokeWeight(0); 
    // default camera icon
    strokeWeight(2);
    noFill();
    ellipse(xPos, cPos, cDiameter, cDiameter);
    strokeWeight(0);   
      
    if(_isActive) {
      // ACTIVE CAMERA STYLE
      fill(255);
      ellipse(xPos, cPos, cDiameter, cDiameter);
      
       if(_isSelectedForPositionInSpace || _isSelectedForPositionInTime) {
         //TODO
         //triangle(xPos, cPos, xPos + 10, cPos, xPos+5, cPos+6); 
        }
        
         
      
       
    }
    
    if(_isViolating) {
      fill(255, 0, 0, 50);
      ellipse(xPos, cPos, cDiameter, cDiameter);
    }
    
   
    
    // reset stroke weight
    strokeWeight(1);
}
  //------------------------------------------------------
  // TODO (see Cam.display())
  void drawInScene() {
    FloatBuffer fb  = getPosition(); // _transform
    // draw the camera icon depending on its status
    
    
    // and transform it using position matrix
   
   if(_isSelectedForPositionInSpace) {
     // display it as selecte
   }
    
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
    this._isActive = true;
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
   
   public float getFOV() {
     return _fov;
   }
  
}
  

