/**
 * Pilot 
 * handles all incoming OSC messages from the Kinect fingerTracker
 */


import oscP5.*;
import netP5.*;

public class Pilot {
  
  Pilot() {
  int port = 31842;
  OscP5 oscP = new OscP5(this, port);
  
  NetAddress interfaceAddr;
  // spoof OSC messages to yourself
  interfaceAddr = new NetAddress("127.0.0.1", port);
    
  }
  
   void oscEvent(OscMessage theOscMessage) {
    
    //println( "OSC EVENT");
    // ADD CAMERA
    if (theOscMessage != null && theOscMessage.checkAddrPattern("/cameraAdded/int/int")) {
      int thisId = theOscMessage.get(0).intValue() + 1; // because Kinect sends array values starting at 0 (and we hardcode the first camera0)
      int thisFrame = theOscMessage.get(1).intValue();
      manager.addCamera(thisId, thisFrame); 
      
      println("Camera Added: camera" + thisId + " starting at frame " + thisFrame); 
    }
   
   // REMOVE CAMERA
   if (theOscMessage != null && theOscMessage.checkAddrPattern("/cameraRemoved")) {
      manager.deleteCamera();  
   }

  // SET PLAYHEAD
   if (theOscMessage != null && theOscMessage.checkAddrPattern("/setPlayheadFrame/int")) {
     //isPositioningCamera = false;  // does not work
     numHandsInFrame = 2;
     int newFrame = theOscMessage.get(0).intValue();
     CURRENTFRAME = newFrame;
       //println("Current Frame: " + CURRENTFRAME);
      //isPositioningCamera = true;  
      println("num hands " + numHandsInFrame);
  }
  if (theOscMessage != null && theOscMessage.checkAddrPattern("/anyBlobs/string")) {
      //isPositioningCamera = false;
      numHandsInFrame = 0;
      //println("no countours in frame"); 
      println("num hands " + numHandsInFrame);
  }
  // SET TRANSFORM MATRIX ON CURRENTLY ACTIVE OBJECT
  if (theOscMessage != null && theOscMessage.checkAddrPattern("/setPropertyForSelected/string/matrix4f")) {
    //isPositioningCamera = true;
    numHandsInFrame = 1;
    float[] matrix = new float[16];
    println("num hands " + numHandsInFrame);
    
    //we do not need to use this in Processing, but let's pop it off the stack anyway
    String propertyName = theOscMessage.get(0).stringValue();

    for (int i=1; i<=16; i++) {
      if (i > 12 && i <= 15) {
        //matrix[i-1] = theOscMessage.get(i).floatValue() * 10;
        matrix[i-1] = theOscMessage.get(i).floatValue(); // No 10x scale
      } 
      else {
        matrix[i-1] = theOscMessage.get(i).floatValue();
      }
    }
    
/*
    matrix[2]=-matrix[2];
    matrix[8]=-matrix[8];
    
    //Friedrich - manual scaling adjustments
    matrix[12]=(700-matrix[12])*2.0;
    matrix[14]=matrix[14] * 1.5;

    FloatBuffer fb = FloatBuffer.allocate(16);
    fb = FloatBuffer.wrap(matrix);
    // TODO(sanjeet): Currently using only camera 5
    // Change this variable based on the data received from OSC
    //    int selectedCamera = 5;
*/

    // NEW CODE
    matrix[12]=matrix[12];
    matrix[14]=matrix[14];
    matrix[2]=-matrix[2];
    matrix[8]=-matrix[8];
   
   /*
    println("----------");
    println(matrix[0]+","+matrix[1]+","+matrix[2]+","+matrix[3]);
    println(matrix[4]+","+matrix[5]+","+matrix[6]+","+matrix[7]);
    println(matrix[8]+","+matrix[9]+","+matrix[10]+","+matrix[11]);
    println(matrix[12]+","+matrix[13]+","+matrix[14]+","+matrix[15]);
     println("----------");

    */
    // END NEW CODE
    FloatBuffer fb = FloatBuffer.allocate(16);
    fb = FloatBuffer.wrap(matrix);
    currentCamera._transform = fb;
  }

 
}
  
}
