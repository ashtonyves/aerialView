/**
* Event
* 
* draws Events to timeline for the mapped duration
* actors listed by name in XML linked to Actor objects
* 
* Getters and setters to edit, retrieve values
* 
**/

private class Event {
 
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
 private void draw() {
   
    float start = map((_startFrame), 0, NUMFRAMES, timeline.getTrackXPos(), timeline.getWidth());
    float end   = map((_endFrame), 0, NUMFRAMES, timeline.getTrackXPos(), timeline.getWidth());
    float width = end - start;
    
    float y = (displayHeight - timeline.getTrackYPos()) + ((_relevence - 1)*(5+timeline.getTrackHeight()));
    float height = timeline.getTrackHeight(); 
   
    String s = _label;
  
  
   fill(33,33,33,10);
   rect(start, y, width, height);
   
   fill(255);
   stroke(255);
   line(start, y, start, y + height);
   noStroke();
   
   text(s, (start + 10), (y + (height/2)));
  
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
