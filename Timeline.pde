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
  
  float padding = 50;
  float labelWidth = 50;
  
  float x = padding + labelWidth;
  float width = displayWidth - (2*padding) - labelWidth;
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
    if(showTimeline) {
      line(x, bottomTimeline - (timelineHeight/2), x + width, bottomTimeline - (timelineHeight/2));
      //endcaps
      line(x, bottomTimeline, x, (bottomTimeline - timelineHeight));
      line(x+width, bottomTimeline, x+width, (bottomTimeline - timelineHeight));
    }
  }
  
  //------------------------------------------------------
  void drawPlayhead(int pos) {
    if(showTimeline) {
      stroke(255);
      float xPos = map(pos, 0, NUMFRAMES, x, x+width);
      line(xPos, bottomTimeline, xPos, bottomTrackGroup2 - ((numEventTracks) * (5 + trackHeight)));
    }
  }
  //------------------------------------------------------
  void drawLightTracks() {
   if(showTracks) {
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
  }
  
  //------------------------------------------------------
  void drawEventTracks() {
   if(showTracks) {
      noStroke();
      
      textSize(24);
      pushMatrix();
      translate(padding, bottomTrackGroup2);
      rotate(-PI/2);
      rect(0, 0, (numEventTracks)*(5 + trackHeight), padding);
      translate((numEventTracks*(5 + trackHeight))/2, 0);
      textAlign(CENTER,CENTER);
      fill(255);
      text("EVENTS", 0, 0);
      noFill();
      translate(-padding, -bottomTrackGroup2);
      
      popMatrix();
    
    for(int i=numEventTracks; i>0; i--) {
      // draw tracks
      fill(144,144,144, 60+(i*20));
      rect(
        x, 
        bottomTrackGroup2 - ((i)*(5 + trackHeight)),  
        width, 
        trackHeight);
      
      // draw labels
      fill(255,255,255, 30);
      /*ellipse(
        padding + (labelWidth/2),
        bottomTrackGroup2 - ((i)*(5 + trackHeight)) + ((5+trackHeight - 15)/2),
        trackHeight - 15,
        trackHeight - 15
      );
      */
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(24);
      text(i, (padding + labelWidth/2), bottomTrackGroup2 - (((numEventTracks+1)-i)*(5 + trackHeight)) + ((5+trackHeight - 15)/2));
     }
     noFill();
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
  
