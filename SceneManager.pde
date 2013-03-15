public class SceneManager {
 
  String SCENEFILE = "guiscenedata.xml";

  
  // initialization values
  int activeCam = 0; // start active camera as the first one in the array
  
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
  
  void addCamera(float[] transform, int startFrame) {
    
    // create the camera object
    Camera newCam = new Camera();
   
    // add the camera to cameras array
    //cameras.add(newCam);
    
    // TODO: order cameras by start time;
    
  }
  
  //-----------------------------------------------------
  void deleteCamera(Camera camera) {
    // find camera in cameras array
    // delete camera
    // order cameras by start time
  }
  

      //-----------------------------------------------------
 void setActiveCamera() {
     Camera currentCamera = null; 
     // IMPORTANT -- CAMERAS MUST BE SORTED BEFORE RUNNING THIS FUNCTION
    
     // loop through all cameras
     for (int i = 0; i < cameras.size(); i++) {
          Camera c = cameras.get(i);
           if(CURRENTFRAME == 0) {
             currentCamera = cameras.get(0);
            }
           // compare the value of CURRENTFRAME
           // to all startFrames for states in camera array.
          else if (c.getFrame() < CURRENTFRAME) {
            // if it is less that the current frame, save it to the current state
             currentCamera = c;
          } 
        
         currentCamera.setActive(); 
         
      }
   }
 
  
  /******************************************
   ----------------- helpers ----------------- 
  ******************************************/
  
  //-----------------------------------------------------
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
  
  
}
