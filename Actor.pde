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
  FloatBuffer _currentTransform;
  
  ArrayList<ActorState> _states;
  
 //----------CONSTRUCTORS--------------------------------------------
 public Actor(String name, String label, ArrayList<ActorState> states) {
   
   _states = new ArrayList<ActorState>();
   _name = name;
   _label = label;
   _states = states;
   
 }
 
 public Actor(){
   _states = new ArrayList<ActorState>();
 }
 
 
 public void drawActor() {
  // TODO 
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
   _currentTransform.wrap(transform);
 }
 //------------------------------------------------------
 public FloatBuffer getPosition() {
   return _currentTransform;
 }
 //------------------------------------------------------
 public void addState(int frame, float[] transform) {
    ActorState state = new ActorState(frame, transform);
   _states.add(state);
   println("New state added for " + this.getName() + " at Frame " + frame + " with transform " + transform);
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
     _transform.wrap(transform);
     _frame = frame;
   }
   
   public ActorState() {
   }
   
   //--------------------GETTERS/SETTERS----------------------------------
   public void setPosition(float[] transform) {
     _transform.wrap(transform);
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
