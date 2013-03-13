/**
* Event
* 
* draws Events to timeline for the mapped duration
* actors listed by name in XML linked to Actor objects
* 
* Getters and setters to edit, retrieve values
* 
**/

public class Event {
 
  String _label;
  int _startFrame;
  int _endFrame;
  int _relevence;
  ArrayList<String> _actors;
  
   //---------------------CONSTRUCTORS---------------------------------
 public Event(String label, int start, int end, int rel, ArrayList<String> actors) {
  
    _actors = new ArrayList<String>();
   _label = label;
   _startFrame = start;
   _endFrame = end;
   _relevence = rel;
   _actors = actors;
 }
 
 public Event() {
   _actors = new ArrayList<String>();

 }
 
 
 //------------------------------------------------------
 public void draw(int x, int y, int width, int height) {
   // put text in rectangle
   fill(240,240,39);
   rect(x, y, width, height);
 }
 
 
 
  //-----------------GETTERS/ SETTERS-------------------------------------
 public int getStartFrame() {
   return _startFrame;
 }
  //------------------------------------------------------
 public void setStartFrame(int start) {
   _startFrame = start;
 }
  //------------------------------------------------------
  public int getEndFrame() {
   return _startFrame;
 }
  //------------------------------------------------------
 public void setEndFrame(int end) {
   _endFrame = end;
 }
  //------------------------------------------------------
 public int getRelevence() {
   return _relevence;
 }
  //------------------------------------------------------
 public void setRelevence(int rel) {
   _relevence = rel;
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
 public void setActor(String name) {
       _actors.add(name);
      // println("Actor added to Event " + _label + ": " + _actors.get(_actors.size()-1)); 
   
 }
 
 //------------------------------------------------------
 public ArrayList<String> getActors() {
   if(_actors.size() > 0) {
      return _actors;
   }
   return null;
 }
 
 
}
