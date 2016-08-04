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
  fill(255);
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
  PVector acceleration;
  float topspeed;

  Mover(PVector _location, float _topspeed) {
    topspeed = _topspeed;
    location = _location;
    velocity = new PVector(topspeed, 0);
  }

  void update() {
    // Compute a vector pointing towards the centre of the canvas
    PVector centre = new PVector(width/2, height/2);
    acceleration = PVector.sub(centre, location);
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
    stroke(0);
    float k = 25 + velocity.mag() * 5;  // Arrow length
    float r = 4.0;  // Arrow size
    
    // Draw an arrow pointing in the direction of travel
    float theta = velocity.heading() + radians(90);
    
    pushMatrix();
    translate(location.x, location.y);
    // Draw ball
    fill(0, 0, 255);
    ellipse(0, 0, 10, 10);
    
    // Draw arrow
    rotate(theta);
    line(0, 0, 0, -k);
    translate(0, -k);
    fill(255, 0, 0);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    
    popMatrix();
    
    k = 25;
    // Draw an arrow pointing in the direction of acceleration
    float alpha = acceleration.heading() + radians(90);
    
    pushMatrix();
    translate(location.x, location.y);
    
    // Draw arrow
    rotate(alpha);
    line(0, 0, 0, -k);
    translate(0, -k);
    fill(255, 255, 0, 128);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    
    popMatrix();
  }
}