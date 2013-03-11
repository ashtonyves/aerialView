/**
* Light
* 
* draws Lights on the timeline
* 
* Getters and setters to edit, retrieve values
* 
**/

public class Light {
 
  String _name;
  String _label;
  ArrayList<LightState> _states;
  
   //-----------------CONSTRUCTOR-------------------------------------
 public Light(String name, String label, ArrayList<LightState> states) {
   _name = name;
   _label = label;
   _states = new ArrayList<LightState>();
   _states = states;
 }
 
 public Light() {
   _states = new ArrayList<LightState>();
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
 public void addState(int frame, float[] transform, String on) {
    LightState state = new LightState(frame, transform, on);
   _states.add(state);
 }
 //------------------------------------------------------
 public ArrayList<LightState> getStates() {
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
  //------------------------------------------------------
public String getOnForState(int i) {
   return _states.get(i).getOn();
} 

  /*****************************************************************
    INNER CLASS TO MANAGE STATE CHANGES (position at frames) 
  *****************************************************************/
 public class LightState{
   
   int _frame;
   String _on;
   FloatBuffer _transform;
  
  //--------------------CONSTRUCTOR ----------------------------------
   public LightState(int frame, float[] transform, String on) {
     
     _transform = FloatBuffer.allocate(16);
     _transform.put(transform);
     
     _on = on;
     
     _frame = frame;
   }
   
   public LightState() {
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
   public String getOn() {
     return _on;
   }
   //------------------------------------------------------
   public void setOn(String on) {
    _on = on; 
   }
 
 }
 
}


