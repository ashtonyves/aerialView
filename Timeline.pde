/**
* Timeline
* 
* Draws the timeline
* stubbed methods to zoom in and out of the timeline for more granularity
*/

public class Timeline {
   
  final int _margin = 40;
  final int _x = _margin;
  final int _y = displayHeight - 100;
  final int _width = displayWidth - 2*(_margin);
  
   // environment dimensions
  int trackHeight = 50;
  int trackXPos = 40;
  int trackYPos = 450;
  
  // tracks for events and lights
  int numLightTracks = 2;
  int numEventTracks = 4;
  
  // current scale of the timline
  float _scale = 1.0f;
  
  
  // constructor ________________________ 
  Timeline () {
  }
  

  
  //------------------------------------------------------
  // draw tracks for even and light timelines
  //------------------------------------------------------
  private void drawTracks() {
    
        //timeline
    line(_x, _y, _x + _width, _y);
    
    //endcaps
    line(_x, _y-10, _x, _y +10);
    line(_x+_width, _y-10, _x+_width, _y +10);
    
    
     // draw EVENT area
    for(int i=0; i<numEventTracks; i++) {
      fill(144,144,144, 60);
      
      noStroke();
      rect(
        trackXPos, 
        (displayHeight - trackYPos) + (i*(5+ trackHeight)) ,  
        displayWidth - (2*trackXPos), 
        trackHeight);
        
    }

    // draw LIGHTS area
    fill(0,144,144, 60);
    for(int i=0; i<numLightTracks; i++) {
      rect(
        trackXPos, 
        (displayHeight - trackYPos) + (i*(5+trackHeight))  + (numEventTracks * (trackHeight+5)), 
        displayWidth - (2*trackXPos), 
        trackHeight);
    }
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
    return _width;
  }
  //------------------------------------------------------
  public void setLength(int length) {
    length = _width;
  }
 //------------------------------------------------------
 public int getTrackHeight() {
   return trackHeight;
 }
   //------------------------------------------------------
   public int getTrackXPos() {
    return trackXPos;
  }
  //------------------------------------------------------
  public int getTrackYPos() {
    return trackYPos;
  }
  //------------------------------------------------------
  
 public int getWidth() {
   return _width;
 }
  //------------------------------------------------------
 public int getX() {
   return _x;
 }
   //------------------------------------------------------
 public int getY() {
   return _y;
 }
 //------------------------------------------------------
 public int getNumEventTracks() {
   return numEventTracks;
 }
 //------------------------------------------------------
 public int getNumLightTracks() {
   return numLightTracks;
 }
}
  
