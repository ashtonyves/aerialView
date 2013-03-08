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
   // initialize ArrayLists and draw areas to the screen
   initEvents();
   initCharacters();
   initLights();
  }
  
  // draw the areas to the scene
  void drawScene() {
    
    //EVENTS
    // draw event area
    for(int i=0; i<numEventTracks; i++) {
      rect(trackAreaXPos, 
        (displayHeight - trackAreaYPos) + (i*trackHeight) + (numLightTracks * trackHeight),  
        displayWidth - (2*trackAreaXPos), 
        trackHeight);
    }
    
    // for each Event in the array
    // draw event to the scene(timeline)
        
      
      
    // LIGHTS
    // draw lights area
    for(int i=0; i<numLightTracks; i++) {
      rect(trackAreaXPos, 
        (displayHeight - trackAreaYPos) + (i*trackHeight), 
        displayWidth - (2*trackAreaXPos), 
        trackHeight);
    }
      // for each light in the array 
      // draw light to the scene (timeline)
      
      
      
   // ACTORS
   // for each actor in the array
   // draw it to the stage
   
   
   
   // CAMERAS
   // for each camera in the array
   // place it on the timeline
   
    

  }
  
  
  void initEvents() { 
    // populate the arrayList of all Events from XML
    events = new ArrayList<Event>();
  }
  

  void initLights() {
    // populate the arraylist of all Lights from XML
    lights = new ArrayList<Light>();
  }
  

  void initCharacters() {
   // populate arrayList of all Actors from XML
   actors = new ArrayList<Actor>();
  }
  
  void initCameras() {
   // populate arrayList of all Actors from XML
   cameras = new ArrayList<Camera>();
  }
  
  
  
  
  /******************************************
   ----------------- CAMERA ----------------- 
  ******************************************/
  
  void addCamera(float[] transform, int startFrame) {
    
    // create the camera object
    Camera newCam = new Camera(transform, startFrame);
   
    // add the camera to cameras array
    // cameras.add(newCam);
    
    // TODO: order cameras by start time;
    
  }
  
  void deleteCamera(Camera camera) {
    // find camera in cameras array
    // delete camera
    // order cameras by start time
  }
  
  
  
}
