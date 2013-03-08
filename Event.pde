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
  ArrayList<Actor> _actors;
  
   //---------------------CONSTRUCTORS---------------------------------
 public Event(String label, int start, int end, int rel, ArrayList<Actor> actors) {
   _label = label;
   _startFrame = start;
   _endFrame = end;
   _relevence = rel;
   _actors = actors;
 }
 
 public Event() {}
 
 
 //------------------------------------------------------
 public void drawEvent() {
   //TODO
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
 public void setActor(Actor actor) {
   _actors.add(actor);
 }
 
 //------------------------------------------------------
 public Actor getActor(Actor actor) {
   for (int i = 0; i < _actors.size(); i++) {
    if(_actors.get(i).getName() == actor.getName()) {
       return _actors.get(i);
    }
   }
   return null;
 }
 
 
}
