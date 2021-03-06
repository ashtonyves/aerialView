/**
* Timeline
* 
* Draws the timeline
* stubbed methods to zoom in and out of the timeline for more granularity
*/

public class Timeline {
  
  // tracks for events and lights
  int numLightTracks = 0; // functionality not built out fully built out. You cannot turn "off" lights in MSB
  int numEventTracks = 5;
  
  float labelWidth = 50;
  
  float x = labelWidth;
  float frameWidth = width - (2*padding) - labelWidth;
  float xEnd = frameWidth + x;  
  
  // trackHeights
  float timelineHeight = 50;
  float trackHeight = 50;
  
  // bottom y values for track groups
  float topTimeline = height-timelineHeight;
  float bottomTrackGroup1 = topTimeline - 30; 
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
    
    if(showTimeline) {
      stroke(1);
      line(x, topTimeline + (timelineHeight/2), x + frameWidth, topTimeline + (timelineHeight/2));
      //endcaps
      line(x, topTimeline, x, height);
      line(x+frameWidth, topTimeline, x+frameWidth, height);
    }
  }
  
  //------------------------------------------------------
  void drawPlayhead(int pos) {
    stroke(255);
    
    if(showTimeline) {

      float xPos = map(pos, 0, NUMFRAMES, x, x+frameWidth);
      
      if(showTracks) {
        line(xPos, height, xPos, bottomTrackGroup2 - ((numEventTracks) * (5 + trackHeight)));
      } else {
        line(xPos, height, xPos,topTimeline);
      }
    }
  }
  //------------------------------------------------------
  void drawLightTracks() {
   noStroke();
    fill(0, 144, 144, 60);
    if(showTracks) {
    
    
    for(int i=0; i<numLightTracks; i++) {
      rect(
        x, 
        bottomTrackGroup1 - ((i + 1) * (5 + trackHeight)), 
        frameWidth, 
        trackHeight);
    }
   }
  }
  
  //------------------------------------------------------
  void drawEventTracks() { // draw the tracks, not the actual events on the tracks themselves.
   noStroke();
   fill(255);
    if(showTracks) {
      textSize(24);
      pushMatrix();
      translate(padding, bottomTrackGroup2);
      rotate(-PI/2);
      translate((numEventTracks*(5 + trackHeight))/2, 0);
      textAlign(CENTER,CENTER);
      text("EVENTS", 0, 0); 
      translate(-padding, -bottomTrackGroup2); 
      popMatrix();
    
    for(int i=numEventTracks; i>0; i--) {
      // draw tracks
      fill(255, 100-(i*10));
      rect(
        x, 
        bottomTrackGroup2 - ((i)*(5 + trackHeight)),  
        frameWidth, 
        trackHeight);

      fill(255, 100);
      textAlign(TOP, LEFT);
      textSize(24);
      text(i, x, bottomTrackGroup2 - (((numEventTracks+1)-i)*(5 + trackHeight)) + ((5+trackHeight - 15)/2));
     }
     
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
    frameWidth = newWidth;
  }
  //------------------------------------------------------
 public float getWidth() {
   return frameWidth;
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
 public float getTopTimeline() {
   return topTimeline;
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
  
