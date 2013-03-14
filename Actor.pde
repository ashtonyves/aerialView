/**
* Actor
* 
* draws Actors to scene
* 
* 
* Getters and setters to edit, retrieve values
* 
**/

public class Actor {
 
  String _name;
  String _label;
  FloatBuffer _currentPosition;
  
  ArrayList<ActorState> _states;
  
  float fov = 45;
  
  PShape icon;
  
  
 //----------CONSTRUCTORS--------------------------------------------
 public Actor(String name, String label, ArrayList<ActorState> states) {
   
   _states = new ArrayList<ActorState>();
   _name = name;
   _label = label;
   _states = states;
   
   icon  = loadShape("actor.svg");
   
 }
 
 public Actor(){
   _states = new ArrayList<ActorState>();
   icon  = loadShape("actor.svg");
 }
 
 // call after you update CURRENTFRAME
 public void draw() {
   
   ActorState currentState = null; 
   // loop through all _states.
   for (int i = 0; i < _states.size(); i ++) {
    ActorState s = _states.get(i);
     // compare each frame value to current frame
    if (s.getFrame() < CURRENTFRAME) {
      // if it is less that the current frame, save it to the current state
       currentState = s;
    } else {
      if(CURRENTFRAME == 0) {
        currentState = _states.get(0);
      }
      // we have the right state saved to currentState from the previous iteration
      // so draw the character from this state
      FloatBuffer fb = currentState.getPosition();
      float[] thisMatrix = fb.array();
      
      float xPos = thisMatrix[12];
      float yPos = thisMatrix[14];
      
      
      //TODO: rotation?!
      
      //println("actor's current state. FRAME: " + currentState.getFrame() + " POSITION: (x=" + xPos + ", y=" + -yPos + ")");
      //pushMatrix();
      //rotateY(acos(thisMatrix[0])); // WEIRD! WAY TO ROTATE....
      shape(icon, xPos, -yPos);
      //popMatrix();
      break;
    }
    
    
   }
   
   
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
 public String getLabel() {
    return _label;
 }
 //------------------------------------------------------
  public void setLabel(String label) {
    _label = label;
 }
 //------------------------------------------------------
 public void setPosition(float[] transform) {
   _currentPosition.wrap(transform);
 }
 //------------------------------------------------------
 public FloatBuffer getPosition() {
   return _currentPosition;
 }
 //------------------------------------------------------
 public void addState(int frame, float[] transform) {
    ActorState state = new ActorState(frame, transform);
   _states.add(state);
 }
 //------------------------------------------------------
 public ArrayList<ActorState> getStates() {
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
 public class ActorState{
   
   int _frame;
   FloatBuffer _transform;
  
  //--------------------CONSTRUCTOR ----------------------------------
   public ActorState(int frame, float[] transform) {
     
     _transform = FloatBuffer.allocate(16);
     _transform.put(transform);
     
     _frame = frame;
   }
   
   public ActorState() {
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
