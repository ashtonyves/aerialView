/**
 *  SceneManager
 * 
 * responsible for adding, deleteing cameras,
 * sorting camera array to set active and adjacent camera
 * and initializing objects from XML data when the program loads.
 * 
 * Does not draw to convas on its own, but 
 * calls the object classes to draw actual objects from all elements 
 * in the camera, actors, lights and events arrays
 *  
 * All draw functions in the main draw() function should be run through SceneManager first.
 *  
*/

public class SceneManager {
 
  String SCENEFILE = "guiscenedata.xml"; 
  
   //----------CONSTRUCTOR-------------------------------------------- 
  SceneManager() {
   initScene();
  }
  
  
  //------------------------------------------------------
  // populate variables from XML
  //------------------------------------------------------
  void initScene() {   
  
   // load the XML file
  XML xml =loadXML(SCENEFILE);
      
   // feed initalization functions the XML[] from file
   initActors(xml.getChild("actors").getChildren("node"));
   initEvents(xml.getChild("events").getChildren("node"));
   initLights(xml.getChild("lights").getChildren("node"));
   initCameras(xml.getChild("cameras").getChildren("node"));
  }
  
   /*****************************************************************
   ----------------- LOAD OBJECTS FROM XML DATA ----------------- 
  *****************************************************************/
  
  void initActors(XML[] data) {
   // populate arrayList of all Actors from XML
   actors = new ArrayList<Actor>();
     
    // for each Actor in the array
    for ( int i=0; i < data.length; i ++) {
      XML node = data[i];
      
      // create a new Event object
      Actor a = new Actor();
   
     // add attributes to object
      a.setName(node.getChild("name").getContent());
      a.setLabel(node.getChild("label").getContent());
      
      for(int j=0; j < node.getChildren("state").length; j ++) {
        XML[] stateNode = node.getChildren("state");
        
        // get start frame
        int frame = stateNode[j].getInt("frame");
        // get position matrix
        String stringPosition = stateNode[j].getChild("pos").getContent(); 
        float[] transform = toFloatArray(stringPosition);
        // create a new state and add it to the Actor
         a.addState(frame, transform);
      }
      
      // Add Actor to actors array
      actors.add(a);
      
      // TESTING
      println(" ");
      println("---------------ACTOR ADDED------------------");
      println(a.getName());
      ArrayList testStates = a.getStates();
      for(int p =0; p < testStates.size(); p++) {
         println("State added at FRAME "  + a.getFrameForState(p) + " at POSITION " + bufferToString(a.getPositionForState(p)) );
       // println("State added at frame "  + testStates.get(p).getFrame() + " with transform " + testStates.get(p).getPosition() );
      }
      
    }
  }
  
  //------------------------------------------------------
  void initEvents(XML[] data) { 
    // populate the arrayList of all Events from XML
    events = new ArrayList<Event>();
    
     // for each Event in the array
    for ( int i=0; i < data.length; i ++) {
      XML node = data[i];
      
      // create a new Event object
      Event e = new Event();
      
      // add attributes to object
      e.setStartFrame(node.getChild("duration").getInt("start"));
      e.setEndFrame(node.getChild("duration").getInt("end"));
      e.setRelevence(int(node.getChild("relevence").getContent()));
      e.setLabel(node.getChild("label").getContent());
       for(int j=0; j < node.getChildren("actors").length; j ++) {
        XML[] actorsNode = node.getChildren("actors");
        // store actor name in temp var
        String actorName = actorsNode[j].getContent();
        // add the string to the Event's actors array
        e.setActor(actorName);
       }
       
      // add Event to events array
      events.add(e);
      
     // TESTING 
      println(" ");
      println("---------------EVENT ADDED------------------");
      println(e.getLabel());
      ArrayList<String> testActors = e.getActors();
      for(int p =0; p < testActors.size(); p++) {
        println("Involving ACTORS:"  + testActors.get(p));
      }
      
    }   
  }
  
//------------------------------------------------------
  void initLights(XML[] data) {
    // populate the arraylist of all Lights from XML
    lights = new ArrayList<Light>();
    
     // for each Actor in the array
    for ( int i=0; i < data.length; i ++) {
      XML node = data[i];
      
      // create a new Event object
      Light l = new Light();
   
     // add attributes to object
      l.setName(node.getChild("name").getContent());
      l.setLabel(node.getChild("label").getContent());
      
      for(int j=0; j < node.getChildren("state").length; j ++) {
        XML[] stateNode = node.getChildren("state");
        
        // get start frame
        int frame = stateNode[j].getInt("frame");
        // get on/off
        String on = stateNode[j].getString("on");
        // get position matrix
        String stringPosition = stateNode[j].getChild("pos").getContent(); 
        float[] transform = toFloatArray(stringPosition);
        // create a new state and add it to the Actor
         l.addState(frame, transform, on);
      }
      // add the light to the lights array
      lights.add(l);
      
      // TESTING
      println(" ");
      println("---------------LIGHT ADDED------------------");
      println(l.getName());
      ArrayList testStates = l.getStates();
      for(int p =0; p < testStates.size(); p++) {
         println("State added at FRAME "  + l.getFrameForState(p) + " at POSITION " + bufferToString(l.getPositionForState(p)) + " Is it on? " + l.getOnForState(p) );
       // println("State added at frame "  + testStates.get(p).getFrame() + " with transform " + testStates.get(p).getPosition() );
      }
    }
  }
  

  //-----------------------------------------------------
  void initCameras(XML[] data) {
   // populate arrayList of all Actors from XML
   cameras = new ArrayList<Camera>();
    // for each Event in the array
    for ( int i=0; i < data.length; i ++) {
      XML node = data[i];
      
      Camera c = new Camera();
      
      // add attributes to object
      c.setName(node.getChild("name").getContent());
      // get start frame
      c.setFrame(node.getChild("frame").getInt("start"));
      // get position matrix
      String stringPosition = node.getChild("pos").getContent(); 
      float[] transform = toFloatArray(stringPosition);
      c.setPosition(transform);

      //println(Arrays.toString(transform));

      // add the camera to the cameras array
      cameras.add(c);
      
       // TESTING
      println(" ");
      println("---------------CAMERA ADDED------------------");
      println(c.getName());
      println("Camera added at FRAME "  + c.getFrame() + " at POSITION " + bufferToString(c.getPosition()) );
      
    }
    
    sortCameras();
  }
  
 
  
  
  
  /*****************************************************************
   --------------------------- DRAW TO THE SCENE ----------------- 
  *****************************************************************/
  public void drawScene() {

    if(showTracks) {
    // for each event in the array 
      // draw event on the timeline
      for (int i = 0; i < events.size(); i++ ) {
        Event e = events.get(i);
        e.draw();
      };
    
    // for each light in the array 
      // draw light on the timeline
    }
    
   // for each actor in the array
     // draw it to the stage
   for (int i = 0; i < actors.size(); i++) {
     // draw it on the timeline and in the scene
     Actor a = actors.get(i);
     a.draw();
   }

  if(showTimeline) {
   // for each camera in the array
   for (int i = 0; i < cameras.size(); i++) {
     // draw it on the timeline and in the scene
     Camera c = cameras.get(i);
     c.draw();
   }
  }
     
  
  }
  
  
  /******************************************
   ----------------- CAMERAS ----------------- 
  ******************************************/
    //------------------------------------------------------
  void sortCameras() {
     Collections.sort(cameras, new CustomComparator());
  }
  
  //-----------------------------------------------------
  void drawCameras() {
    
    // IMPORTANT -- CAMERAS MUST BE SORTED BEFORE RUNNING THIS FUNCTION
    
     // first set all cameras to inactive and notdisplayed
    for (int i = 0; i < cameras.size(); i++) {
      Camera c = cameras.get(i);
      c._isActive = false;
      c._isDisplayed = false;
    }
    // then reset active and adjacent cameras
    setActiveCamera();
    setAdjacentCameras(); // this MUST come after setActiveCamera();
  }
  
  //-----------------------------------------------------
  void setActiveCamera() {
     // loop through all cameras. COUNT DOWN!
     for (int i = cameras.size()-1; i>=0; i--) {
          Camera c = cameras.get(i);
          // if the playhead is on the first or last frame
          // then no comparison is necessary. Active came is the first/last camera in the array
          if(CURRENTFRAME == 0) {
             currentCamera = cameras.get(0);
           }
           else if(CURRENTFRAME == NUMFRAMES) {
             currentCamera = cameras.get(cameras.size()-1);
           }
           // Otherwise, 
           // compare value of CURRENTFRAME to all startFrames in cameras array.
          else if(c.getFrame() <= CURRENTFRAME) {
            // if the camera's start frame is greater than the current frame, 
            // then the camera before that must be currently active.
             currentCamera = cameras.get(i);
             break;
          }
          
      }
    //println(currentCamera._name);
    
    // set the current camera as active
    currentCamera.setActive();
   }
   
 //-----------------------------------------------------  
   void setAdjacentCameras() {
     
     if(cameras.size() <= 1) { // there are no previous or next cameras
       previousCamera = null;
       nextCamera = null; 
       
       // then get out.
       return; 
       
     } else { // there is more than one camera
       for (int i = 0; i < cameras.size(); i++) { // loop through them all.
         Camera c = cameras.get(i);
         if(c._isActive) { // find the active camera
            if(i == 0)  { // if we are on the first camera
              // so there are no cameras before it
               previousCamera = null;
             } else {
               previousCamera = cameras.get(i-1);
               previousCamera.setDisplayed();
             }
             if(i == cameras.size()-1) { // we are on the last camera
               // so there are no cameras after it;
               nextCamera = null;
             } else {
               nextCamera = cameras.get(i+1);
               nextCamera.setDisplayed();
             }
              return;
           }
       }
     }
   }
   
   //-----------------------------------------------------
   private void deleteCamera() {
     
     int pos = getActiveCameraKey();
     if(pos != 0) {
         cameras.remove(pos);
     } else {
       // TODO: make this a notification on the UI
       
       println("you cannot delete the first camera");
       return;
     }
     
     currentCamera = null;  
     sortCameras();
   }
   
      //-----------------------------------------------------
   private void addCamera() {
     
     Camera c = getActiveCamera();
    
     // add a camera at the currentFrame, with a transform matrix copied from the camera before it
     Camera newCam = new Camera(CURRENTFRAME, (c.getPosition()).array()); 
     cameras.add(newCam);  
     
     sortCameras();
       // TESTING
      println(" ");
      println("---------------CAMERA ADDED------------------");
      println(newCam.getName()); 
      println("Camera added at FRAME "  + newCam.getFrame() + " at POSITION " + bufferToString(newCam.getPosition()) );
   }
   
   
 //-----------------------------------------------------
  private Camera getActiveCamera() {
    Camera currentCamera = null; 
    // loop through all cameras
     for (int i = 0; i < cameras.size(); i++) {
       Camera c = cameras.get(i);
         if(c._isActive) {
           currentCamera = c;
         }
     }
     return currentCamera;
  }
 
  //-----------------------------------------------------
  private int getActiveCameraKey() {
    int k = -1;
     for (int i = 0; i < cameras.size(); i++) {
       Camera c = cameras.get(i);
         if(c._isActive) {
            k = i;
            break;
         }
     }
     return k;
  }
  
  /******************************************
   ----------------- helpers ----------------- 
  ******************************************/
  
  //--------------------------------------------  --------
  // convert a string from XML into a float array
  //-----------------------------------------------------
  float[] toFloatArray(String string) {
    String[] s = string.split(" ");
    //println(Arrays.toString(string));
   
    float[] transform = new float[s.length];
    
    for (int k=0; k < s.length; k++) {
      transform[k] = Float.parseFloat(s[k]);
    }
   
    return transform;
  }
  
  //-----------------------------------------------------
  // print the FloatBuffer as a string
  //-----------------------------------------------------
  String bufferToString(FloatBuffer fb) {
    return Arrays.toString(fb.array()); 
  } 
  
    /*****************************************************************
    INNER CLASS TO IMPLEMENT COMPARATOR 
    http://stackoverflow.com/questions/2784514/sort-arraylist-of-custom-objects-by-property
  *****************************************************************/
  public class CustomComparator implements Comparator<Camera> {
    @Override
    public int compare(Camera c1, Camera c2) {
        Integer i1 = new Integer(c1.getFrame());
        Integer i2 = new Integer(c2.getFrame());
        
        return i1.compareTo(i2);
    }
  }
  

  
  
}
