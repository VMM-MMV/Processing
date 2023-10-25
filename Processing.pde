class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed = 4;

  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
  }

  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);
    float distance = dir.mag();
    
    // Normalize and scale by a factor inversely proportional to distance
    dir.normalize();
    float strength = map(distance, 0, width, 5, 0); // Assuming max distance is width of canvas
    dir.mult(strength);
    
    acceleration = dir;
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
    fill(127);
    stroke(0);
    ellipse(location.x, location.y, 32, 32);
  }
}

Mover m;

void setup() {
  size(640, 360);
  m = new Mover();
}

void draw() {
  background(255);
  m.update();
  m.display();
}
