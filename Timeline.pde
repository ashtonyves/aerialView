/**
* Timeline
* 
* Draws the timeline
* stubbed methods to zoom in and out of the timeline for more granularity
*/

public class Timeline {
   
  final float _x = padding;
  final float _y = displayHeight - 100;
  final float _width = displayWidth - (2*_x);
  
   // environment dimensions
  float trackHeight = 50;
  float trackXPos = 40;
  float trackYPos = 450;
  
  // tracks for events and lights
  //int numLightTracks = 2;
  int numLightTracks = 0;
  int numEventTracks = 4;
  
  // current scale of the timline
  float _scale = 1.0f;
  
  
  // constructor ________________________ 
  Timeline () {
    drawTracks();
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
  public void setWidth(float length) {
    length = _width;
  }
 //------------------------------------------------------
 public float getTrackHeight() {
   return trackHeight;
 }
   //------------------------------------------------------
   public float getTrackXPos() {
    return trackXPos;
  }
  //------------------------------------------------------
  public float getTrackYPos() {
    return trackYPos;
  }
  //------------------------------------------------------
  
 public float getWidth() {
   return _width;
 }
  //------------------------------------------------------
 public float getX() {
   return _x;
 }
   //------------------------------------------------------
 public float getY() {
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
  
