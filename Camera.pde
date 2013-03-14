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
  String       _name;       // MSB name (may be superfluous here)
  ArrayList<CameraState> _states;
  
  boolean _isSelectedForPositionInSpace;
  boolean _isSelectedForPositionInTime;
  boolean _isActive;
  boolean _isViolating;
  
  PShape iconDefault;
  PShape iconActive;
  PShape iconSelectedTime;
  PShape icondSelectedPos;
  
  //----------CONSTRUCTOR--------------------------------------------
  public Camera(ArrayList<CameraState> states) {
    _states = new ArrayList<CameraState>();
    _states = states;
    loadShapes();
  }
  
  public Camera() {
    _states = new ArrayList<CameraState>();
    loadShapes();
  }
  
  //------------------------------------------------------
  void loadShapes() {
     
    iconDefault = loadShape("camera_neutral.svg");
    iconActive = loadShape("camera_active.svg");
  }
   //------------------------------------------------------
    void sortCameraStates() {
     Collections.sort(_states, new CustomComparator());
  }
      
  

  /*****************************************************************
    VISUALIZE OBJECT ON SCREEN 
  *****************************************************************/
  //------------------------------------------------------
  void draw() {
    
    for( int i = 0; i< this.getStates().size(); i++) {
      
      drawCameraOnTimeline(getFrameForState(i)); // always
      drawCameraInScene(getPositionForState(i)); // only if its one of the three cameras
      
    }
    
     for (CameraState state : _states) {
      // TEST 
       println(state.getFrame());
    } 
  }
  
  //------------------------------------------------------
  void drawCameraOnTimeline(int frame) {
    
    // map the camera frame to the length of the timeline
    float xPos = map((float)frame, 0, NUMFRAMES, timeline.getXStart(), timeline.getXEnd()); // refactor so that all this does is draw -- all frame mapping should be between SceneManager and Timeline
    
    fill(255);
    stroke(1);
    strokeWeight(3);
    // draw line
    line(xPos, timeline.getBottomTimeline(), xPos, (timeline.getBottomTimeline()-timeline.timelineHeight) );
    strokeWeight(1);
    shape(iconDefault, xPos-25, (timeline.getBottomTimeline()-timeline.timelineHeight -40));
    // TODO
    // loadCameraIcon based on its state
}
  //------------------------------------------------------
  void drawCameraInScene(FloatBuffer pos) {
    
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
   sortCameraStates();
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
    INNER CLASS TO IMPLEMENT COMPARATOR 
  *****************************************************************/
  public class CustomComparator implements Comparator<CameraState> {
    @Override
    public int compare(CameraState s1, CameraState s2) {
        Integer i1 = new Integer(s1.getFrame());
        Integer i2 = new Integer(s2.getFrame());
        
        return i1.compareTo(i2);
    }
}
  
   /*****************************************************************
    INNER CLASS TO MANAGE STATE CHANGES (position at frames) 
  *****************************************************************/
 public class CameraState  {
   
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
