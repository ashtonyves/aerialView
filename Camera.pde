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
  FloatBuffer  _transform;   //http://docs.oracle.com/javase/1.5.0/docs/api/java/nio/FloatBuffer.html
  int          _startFrame;
  
  boolean _isSelectedForPositionInSpace;
  boolean _isSelectedForPositionInTime;
  boolean _isActive;
  boolean _isViolating;
  
  //----------CONSTRUCTOR--------------------------------------------
  public Camera(float[] transform, int startFrame) {
    
    // pass in the raw matrix to the camera object
    _transform = FloatBuffer.allocate(16);
    _transform.wrap(transform);
    
    // set the startFrame
    _startFrame = startFrame;
    
    //draw the camera to the scene
    drawCamera(_transform, _startFrame);
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
   public int getStartFrame() {
     return _startFrame;
   }
  //------------------------------------------------------
  public void setStartFrame(int start) {
    _startFrame = start;
  }
 //------------------------------------------------------
  public void setPosition(float[] transform) {
   _transform.wrap(transform);
  }
 //------------------------------------------------------
  public FloatBuffer getPosition() {
   return _transform;
  }
}
