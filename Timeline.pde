/**
* Timeline
* 
* Draws the timeline
* stubbed methods to zoom in and out of the timeline for more granularity
*/

public class Timeline {
  
  final int _margin = 40;
  final int _y = displayHeight - 100;
  
  int _length;
  float _scale = 1.0f;
  
  // constructor ________________________ 
  Timeline () {
    
    int _x = _margin;
    int _length = displayWidth - 2*(_margin);
    
    //timeline
    line(_x, _y, _x + _length, _y);
    
    //endcaps
    line(_x, _y-10, _x, _y +10);
    line(_x+_length, _y-10, _x+_length, _y +10);
    
  }
  
  //------------------------------------------------------
  // zoom into the timeline 
  private void setScale(float scale) {
    // adjust the timeline display by a multiplier of scale
  }
  
  //------------------------------------------------------
  public float getScale() {
    return _scale;
  }
  //------------------------------------------------------
  public float getLength() {
    return _length;
  }
  //------------------------------------------------------
  public void setLength(int length) {
    length = _length;
  }
  
  //------------------------------------------------------
 public Timeline getTimeline() {
   return this;
 }
}
  
