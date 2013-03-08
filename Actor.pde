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
  FloatBuffer _transform;
  
  ArrayList<ActorState> _states;
  
 //----------CONSTRUCTOR--------------------------------------------
 public Actor(String name, String label, ArrayList<ActorState> states) {
   _name = name;
   _label = label;
   _states = states;
 }
 
 public Actor(){}
 
 
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
   _transform.wrap(transform);
 }
 //------------------------------------------------------
 public FloatBuffer getPosition() {
   return _transform;
 }
 
    /*****************************************************************
   -------------- INNER CLASS TO MANAGE CHANGES in POSITION ------ 
  *****************************************************************/
 public class ActorState{
   
   int _frame;
   FloatBuffer _transform;

   public ActorState(int frame, float[] transform) {
     _transform = FloatBuffer.allocate(16);
     _transform.wrap(transform);
   }
 
 }
 
 
}
