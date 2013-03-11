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
 
public class Camera {
  String       _name;       // MSB name (may be superfluous here)
  ArrayList<CameraState> _states;
  
  boolean _isSelectedForPositionInSpace;
  boolean _isSelectedForPositionInTime;
  boolean _isActive;
  boolean _isViolating;
  
  //----------CONSTRUCTOR--------------------------------------------
  public Camera(ArrayList<CameraState> states) {
    _states = new ArrayList<CameraState>();
    _states = states;
  }
  
  public Camera() {
    _states = new ArrayList<CameraState>();
  }
  
  // TODO: call drawCamera for those three cameras in draw() function;
  //------------------------------------------------------
  void drawCamera(FloatBuffer transform, int frame) {
    
    // icon on the timeline
    drawCameraOnTimeline(frame);
    // object in the schematic
    drawCameraInScene(transform);
  }
  
  //------------------------------------------------------
  void drawCameraOnTimeline(int frame) {
    
    // map the frame to the length of the timeline
    //  Probably better ways to do this using the Timeline object
    float xPos = map((float)frame, 0, maxFrames, 40, displayWidth - 2*40); 
    
    // draw line
    
    line(xPos, displayHeight - 140, xPos, displayHeight-60);
}
  //------------------------------------------------------
  void drawCameraInScene(FloatBuffer transform) {
    
    // select the SVG depending on its status
    
    // and transform it
  }
  
  // Change the appearance of the icon based on its status
  //------------------------------------------------------
  public void setSelectedForPositionChange(boolean val) {
 
  }
  //------------------------------------------------------
  public void setSelectedForTimeChange() {
    
  }
  //------------------------------------------------------
  public void setActive() {
    
  } 
  //------------------------------------------------------
  public void setViolated() {
    
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
  public void addState(int frame, float[] transform) {
    CameraState state = new CameraState(frame, transform);
   _states.add(state);
 }
 //------------------------------------------------------
 public ArrayList<CameraState> getStates() {
   return _states;
 }
 
 //------------------------------------------------------
 public int getFrameForState(int i) {
   return _states.get(i).getFrame();
 }
 //------------------------------------------------------
public FloatBuffer getPositionForState(int i) { 
  return _states.get(i).getPosition();
   
} 
  
  
   /*****************************************************************
    INNER CLASS TO MANAGE STATE CHANGES (position at frames) 
  *****************************************************************/
 public class CameraState{
   
   int _frame;
   FloatBuffer _transform;
  
  //--------------------CONSTRUCTOR ----------------------------------
   public CameraState(int frame, float[] transform) {
     
     _transform = FloatBuffer.allocate(16);
     _transform.put(transform);
     
     _frame = frame;
   }
   
   public CameraState() {
   }
   
   //--------------------GETTERS/SETTERS----------------------------------
   public void setPosition(float[] transform) {
     _transform.put(transform);
   }
   //------------------------------------------------------
   public FloatBuffer getPosition() {
     return _transform;
   }
   //------------------------------------------------------
   public int getFrame() {
     return _frame;
   }
   //------------------------------------------------------
   public void setFrame(int frame) {
    _frame = frame; 
   }
 
 }
 
 
}
