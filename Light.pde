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
  FloatBuffer _transform;
  boolean _bOn;
  
   //-----------------CONSTRUCTOR-------------------------------------
 public Light(String name, String label, float[] transform, boolean on) {
   
   _transform = FloatBuffer.allocate(16);
   _transform.wrap(transform);
   
   _name = name;
   _label = label;
   _bOn = on;
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
 
 // a little different...
 //------------------------------------------------------
 public void turnOn() {
   _bOn = true;
 }
 //------------------------------------------------------
 public void turnOff() {
   _bOn = false;
 }
}


