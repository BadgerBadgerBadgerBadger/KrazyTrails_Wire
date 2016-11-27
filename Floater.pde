class Floater {
  PVector location, velocity, acceleration;
  float mass, radius, G;
  color col;
    
  Floater( PVector location, float mass, float radius, color col, float G ) {
    this.location = location.get();
    this.mass = mass;
    this.radius = radius;
    this.col = col;
    this.G = G;
      
    velocity = new PVector( 0, 0 );
    acceleration = new PVector( 0, 0 );
  }
     
  PVector attractionForce( Floater floater ) {
    PVector distVector = PVector.sub( location, floater.location );
    float distance = distVector.mag();
    distance = constrain( distance, 5, 25 );
       
    distVector.normalize();
    float strength = ( G * mass * floater.mass ) / (distance * distance );
    distVector.mult( strength );
       
    return distVector;
  }
     
  void applyForce(PVector force) {
    acceleration.add( force );
  }
     
  void update() {
    velocity.add( acceleration );
    location.add( velocity );
     
    acceleration.mult( 0 );
  }
     
  void render() {
    //noStroke();
    stroke( 255);
    noFill();
    ellipse( location.x, location.y, radius * 2, radius * 2 );
  }
    
 void checkEdges() {
    if (location.x > width - radius ) {
      location.x = width - radius;
      velocity.x *= -1;
    } else if (location.x < radius) {
      velocity.x *= -1;
      location.x = radius;
    }
    
    if (location.y > height - radius ) {
      location.y = height - radius;
      velocity.y *= -1;
    } else if (location.y < radius) {
      velocity.y *= -1;
      location.y = radius;
    }
  }
}