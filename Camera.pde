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
 int boxScale = 4;
 
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
  
    public Camera(int frame, float[] transform, String name) {
    _transform = FloatBuffer.allocate(16);
    _transform.put(transform);
    _frame = frame;
    _name = name;
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
      fill(0);
      ellipse(xPos, cPos, cDiameter, cDiameter);
      
       if(_isSelectedForPositionInSpace || _isSelectedForPositionInTime) {
         //TODO
         //triangle(xPos, cPos, xPos + 10, cPos, xPos+5, cPos+6); 
        }
    }
    
    if(_isDisplayed) {
      fill(255);
      ellipse(xPos, cPos, cDiameter, cDiameter);
    }
    
    if(_isViolating) {
      stroke(255, 0, 0);
      strokeWeight(2);
      ellipse(xPos, cPos, cDiameter, cDiameter);
      noStroke(); // uncomment to also stroke the camera in the scene
    }

    // reset stroke weight
    strokeWeight(1);
}
  //------------------------------------------------------
  void drawInScene() {
    FloatBuffer fb  = getPosition(); // _transform
    // draw the camera icon depending on its status
    if(_isActive) {
       // draw it
     pushMatrix();
     
      // rotate global cam each time you draw a new camera. inside the push matrix.
      rotateGlobalCamera();
      
      float[] matrix = _transform.array();

      PMatrix3D m=new PMatrix3D();
      
      m.set(matrix);
      m.transpose();
      applyMatrix(m);  
      strokeWeight(1);
      line(0, 0, 0, 0, 0, 15);
      fill(0,80);
      noStroke();
      box(boxScale);
      popMatrix();
    }
    if (_isDisplayed) {
      pushMatrix();  
      // rotate global cam each time you draw a new camera. inside the push matrix.
      rotateGlobalCamera();
      
      float[] matrix = _transform.array();
         PMatrix3D m=new PMatrix3D();
      m.set(matrix);
      m.transpose();
      applyMatrix(m);  
      strokeWeight(1);
      line(0, 0, 0, 0, 0, 5);
      fill(255,80);
      noStroke();
      box(boxScale);
      popMatrix();
    }
    
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
    _isActive = true;
  } 
  //------------------------------------------------------
  public void setDisplayed() {
    _isDisplayed = true;
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
   //------------------------------------------------------
   public float getFOV() {
     return _fov;
   }
   //------------------------------------------------------
    PVector getTranslation() {
    if (_transform == null) {
      println("Transform Matrix is corrupted");
      return null;
    }
    float[] arr = _transform.array();
    if (arr.length != 16) {
      println("Transform Matrix is corrupted");
      return null;
    }
    float[] translation = new float[3];
    return new PVector(arr[12], arr[13], arr[14]);
  }
  
  //------------------------------------------------------
  PVector getZAxis() {
    if (_transform == null) {
      println("Transform Matrix is corrupted");
      return null;
    }
    float[] arr = _transform.array();
    if (arr.length != 16) {
      println("Transform Matrix is corrupted");
      return null;
    }
    return new PVector(arr[8], arr[9], arr[10]);    
  }
  
}
  

