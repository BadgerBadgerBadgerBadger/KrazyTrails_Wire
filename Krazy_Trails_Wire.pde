Floater[] floaters = new Floater[100];
float GRAV, DRAGG, G, MOUSE_ATTR;

void setup() {
  size( 700, 500 );
  smooth();
  background( 0);
   
  frameRate(70);
  GRAV = 0.70;
  DRAGG = 0.77;
  MOUSE_ATTR = 0.00;

  for( int i = 0; i < floaters.length; i++ ) {
    floaters[i] = new Floater( 
      new PVector( random( 100, width ), random( 100, height )), 
      random( 1, 4 ), 
      random( 7, 7 ), 
      color( random( 100, 255 ), random( 100, 255 ), random( 100, 255 ) ), 
      GRAV 
    );
  }
}

void draw() {
  
  fill( 0, 31 );
  rect( 0, 0, width, height );
     
  fill( random(255), random(255), random(255) );
  
  for( int i = 0; i < floaters.length; i++ ) {
    run(i);
  }
}

void run(int i) {
  PVector drag = floaters[i].velocity.get();
    drag.normalize();
    drag.mult( -DRAGG );
    floaters[i].applyForce( drag );
       
    PVector toMouse = PVector.sub( new PVector( mouseX, mouseY ), floaters[i].location );
    toMouse.normalize();
    toMouse.mult( -MOUSE_ATTR );
    floaters[i].applyForce( toMouse );
    
    for( int j = 0; j < floaters.length; j++ ) {
      if( i != j ) {
        PVector f = floaters[j].attractionForce( floaters[i] );
        f.mult( 1 );
        floaters[i].applyForce( f );
      }
    }
       
    floaters[i].update();
    floaters[i].checkEdges();
    
    floaters[i].render();
}

void mouseClicked() {
  
  for( int i = 0; i < floaters.length; i++ ) {
    
    PVector mouse = new PVector( mouseX, mouseY );
    PVector force = PVector.sub( floaters[i].location, mouse );
    
    force.normalize();
    force.mult(7);
    
    floaters[i].applyForce( force );
  }
}