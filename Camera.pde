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
  String    _name;       // MSB name (may be superfluous here)
  ArrayList<CameraState> _states;
  
 
  
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
      
      CameraState s = getStates().get(i);
      
      drawStateOnTimeline(s);   // always
      drawStateInScene(s);     // only if its one of the three cameras
      
    }
    
    // TEST 
     for (CameraState state : _states) {
       println(state.getFrame());
    } 
  }
  
  //------------------------------------------------------
  void drawStateOnTimeline(CameraState s) {
    
    int frame = s.getFrame();
    
    // map the camera frame to the length of the timeline
    float xPos = map((float)frame, 0, NUMFRAMES, timeline.getXStart(), timeline.getXEnd()); // refactor so that all this does is draw -- all frame mapping should be between SceneManager and Timeline
    
    fill(255);
    stroke(1);
    strokeWeight(3);
    // draw line
    line(xPos, timeline.getBottomTimeline(), xPos, (timeline.getBottomTimeline()-timeline.timelineHeight) );
    strokeWeight(1);
    
    // loadCameraIcon based on its state
    if(s._isActive) {
      ellipse(xPos-25, (timeline.getBottomTimeline()-timeline.timelineHeight -40), 80, 80);
    }
    if(s._isViolating) {
      
    }
    if(s._isSelectedForPositionInSpace) {
    
    }else if (s._isSelectedForPositionInTime) {
       
    }
    shape(iconDefault, xPos-25, (timeline.getBottomTimeline()-timeline.timelineHeight -40));
    
}
  //------------------------------------------------------
  void drawStateInScene(CameraState s) {
    FloatBuffer fb  = s.getPosition();
    // select the SVG depending on its status
    
    // and transform it
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
 public CameraState getState(int i) {
   return _states.get(i);
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
    http://stackoverflow.com/questions/2784514/sort-arraylist-of-custom-objects-by-property
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
   
  boolean _isSelectedForPositionInSpace;
  boolean _isSelectedForPositionInTime;
  boolean _isActive;
  boolean _isViolating;
  
  //--------------------CONSTRUCTOR ----------------------------------
   public CameraState(int frame, float[] transform) {
     
     _transform = FloatBuffer.allocate(16);
     _transform.put(transform);
     
     _frame = frame;
   }
   
   public CameraState() {
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
    // maybe first set all cameras to inactive?
    _isActive = true;
  } 
  //------------------------------------------------------
  public void setViolated() {
    _isViolating = true;
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
   //------------------------------------------------------
  public CameraState getState() {
   return this;
  }   
  
 }
 
}
