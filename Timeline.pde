/**
* Timeline
* 
* Draws the timeline
* stubbed methods to zoom in and out of the timeline for more granularity
*/

public class Timeline {
  
  // tracks for events and lights
  int numLightTracks = 2;
  int numEventTracks = 4;
  
  float padding = 50;
  
  float x = padding;
  float width = displayWidth - (2*x);
  float xEnd = width + x;  
  
  // trackHeights
  float timelineHeight = 100;
  float trackHeight = 50;
 
  
  // bottom y values for track groups
  float bottomTimeline = displayHeight - padding;
  float bottomTrackGroup1 = (bottomTimeline - timelineHeight) - 20; 
  float bottomTrackGroup2 = 0.0;
  
  // current scale of the timline
  float scale = 1.0f;
  
  
  // constructor ________________________ 
  Timeline () {
    // set bottom of tracks based on the number of tracks included
     // set yValue for track sets dynamically, based on number of tracks
    bottomTrackGroup2 = bottomTrackGroup1 - (numLightTracks * (trackHeight+5));
  }
  
  //------------------------------------------------------
  // draw tracks for even and light timelines
  //------------------------------------------------------
  private void drawTracks() {
    drawTimeline();
    drawLightTracks();
    drawEventTracks();
  }
  
  //------------------------------------------------------
  void drawTimeline() {
    line(x, bottomTimeline - (timelineHeight/2), x + width, bottomTimeline - (timelineHeight/2));
    //endcaps
    line(x, bottomTimeline, x, (bottomTimeline - timelineHeight));
    line(x+width, bottomTimeline, x+width, (bottomTimeline - timelineHeight));
  }
  
  //------------------------------------------------------
  void drawPlayhead(int pos) {
    stroke(255);
    float xPos = map(pos, 0, NUMFRAMES, x, width);
    line(xPos, bottomTimeline, xPos, bottomTrackGroup2 - ((numEventTracks) * (5 + trackHeight)));
    // draw flag
  }
  //------------------------------------------------------
  void drawLightTracks() {
 
    noStroke();
    fill(0, 144, 144, 60);
    
    for(int i=0; i<numLightTracks; i++) {
      rect(
        x, 
        bottomTrackGroup1 - ((i + 1) * (5 + trackHeight)), 
        width, 
        trackHeight);
    }
  }
  
  //------------------------------------------------------
  void drawEventTracks() {
   
    noStroke();
    fill(144,144,144, 60);
    
    for(int i=0; i<numEventTracks; i++) {
      rect(
        x, 
        bottomTrackGroup2 - ((i+1)*(5 + trackHeight)),  
        width, 
        trackHeight);
    }
  }
  
  //------------------------------------------------------
  // zoom into the timeline 
  private void setScale(float multiplier) {
    scale *= multiplier; // adjust the timeline display by a multiplier of scale
  }
  
  //------------------------------------------------------
  public float getScale() {
    return scale;
  }
  //------------------------------------------------------
  public void setWidth(float newWidth) {
    width = newWidth;
  }
  //------------------------------------------------------
 public float getWidth() {
   return width;
 }
 //------------------------------------------------------
 public float getTrackHeight() {
   return trackHeight;
 }
   //------------------------------------------------------
   public void setX(float newX) {
    x = newX;
  }
  //------------------------------------------------------
 public float getXStart() {
   return x;
 }
   //------------------------------------------------------
 public float getXEnd() {
   return xEnd;
 }

 //------------------------------------------------------
 public float getBottomTimeline() {
   return bottomTimeline;
 } 
 //------------------------------------------------------
 public float getBottomTrackGroup1() {
   return bottomTrackGroup1;
 }
 //------------------------------------------------------
  public float getBottomTrackGroup2() {
   return bottomTrackGroup2;
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
  
