public class SceneManager {
 
  ArrayList<Camera> cameras;
  ArrayList<Actor> actors;
  ArrayList<Light> lights;
  ArrayList<Event> events;

  int trackHeight = 30;
  int trackAreaXPos = 40;
  int trackAreaYPos = 350;
  
  int numLightTracks = 2;
  int numEventTracks = 4;
  
  int activeCam = 0; // start active camera as the first one in the array

   //----------CONSTRUCTOR-------------------------------------------- 
  SceneManager() {
   initScene();
  }
  
  // populate the variables from XML
  void initScene() {   
  
   // load the XML file
  XML xml =loadXML("guiscenedata.xml");
  // populate arrays from file
  XML[] xmlEvents = xml.getChild("events").getChildren("node");
  XML[] xmlActors = xml.getChild("actors").getChildren("node");
  XML[] xmlLights = xml.getChild("lights").getChildren("node");
  XML[] xmlCameras = xml.getChild("cameras").getChildren("node");
      
   // initialize ArrayLists and draw areas to the screen
   initActors(xmlActors);
   initEvents(xmlEvents);
   initLights(xmlLights);
   initCameras(xmlCameras);
  }
  
   /*****************************************************************
   ----------------- POPULATE OBJECTS FROM XML DATA ----------------- 
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
        
        // store grame and matrix for this state in temporary variables
        int frame = stateNode[j].getInt("frame");
        String stringPosition = stateNode[j].getChild("pos").getContent(); 
        String[] floatString = stringPosition.split(" ");
        float[] transform = new float[floatString.length];
        // TODO: read in String transform, turn it into a float array and replace this with testFloat
        
        
        // create a new state and add it to the Actor
         a.addState(frame, transform);

      }
    }
       
      
      
  }
  
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
       
      // add Event to array
      events.add(e);
    }   
  }
  

  void initLights(XML[] data) {
    // populate the arraylist of all Lights from XML
    lights = new ArrayList<Light>();
  }
  

  
  
  void initCameras(XML[] data) {
   // populate arrayList of all Actors from XML
   cameras = new ArrayList<Camera>();
  }
  
  
  /*****************************************************************
   --------------------------- DRAW TO THE SCENE ----------------- 
  *****************************************************************/
  void drawScene() {
    
    // draw EVENT area
    for(int i=0; i<numEventTracks; i++) {
      rect(trackAreaXPos, 
        (displayHeight - trackAreaYPos) + (i*trackHeight) + (numLightTracks * trackHeight),  
        displayWidth - (2*trackAreaXPos), 
        trackHeight);
    }

    // draw LIGHTS area
    for(int i=0; i<numLightTracks; i++) {
      rect(trackAreaXPos, 
        (displayHeight - trackAreaYPos) + (i*trackHeight), 
        displayWidth - (2*trackAreaXPos), 
        trackHeight);
    }
    
    // for each event in the array 
      // draw event on the timeline
    
    // for each light in the array 
      // draw light on the timeline
  
   // for each actor in the array
     // draw it to the stage

   // for each camera in the array
     // place it on the timeline

  }
  
  
  
  
  
  
  
  /******************************************
   ----------------- CAMERAS ----------------- 
  ******************************************/
  
  void addCamera(float[] transform, int startFrame) {
    
    // create the camera object
    Camera newCam = new Camera(transform, startFrame);
   
    // add the camera to cameras array
    //cameras.add(newCam);
    
    // TODO: order cameras by start time;
    
  }
  
  void deleteCamera(Camera camera) {
    // find camera in cameras array
    // delete camera
    // order cameras by start time
  }
  
  
  
}
