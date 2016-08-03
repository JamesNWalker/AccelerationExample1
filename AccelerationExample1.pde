// This sketch demonstrates the use of the PVector class to simulate motion.

// For an introduction to the PVector class, see: https://processing.org/tutorials/pvector/

Mover mover;

void setup() {
  background(255);
  size(640,360);
  // Maximum speed, initial position and initial velocity of the Mover
  mover = new Mover(new PVector(width/2, height/2), 5);
  frameRate(25);
}

void draw() {
  noStroke();
  fill(255,25);
  rect(0,0,width,height);
  // Update the location
  mover.update();
  // Display the Mover
  mover.display();
}

class Mover {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  float topspeed;

  Mover(PVector _location, float _topspeed) {
    topspeed = _topspeed;
    location = _location;
    velocity = new PVector(topspeed,0);
  }

  void update() {
    // Compute a vector pointing towards the centre of the canvas
    PVector centre = new PVector(width/2, height/2);
    PVector acceleration = PVector.sub(centre, location);
    // Set magnitude of acceleration
    acceleration.setMag(0.25);
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Location changes by velocity
    location.add(velocity);
    // Velocity is limited by maximum speed
    velocity.limit(topspeed);
  }

  void display() {
    fill(0);
    rectMode(CENTER);
    rect(location.x, location.y, 9, 9);
    rectMode(CORNER);
  }
}