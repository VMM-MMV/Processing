PVector location;
PVector velocity;

void setup() {
  size(640, 640, P3D);
  location = new PVector(width/2, height/2, -50);
  velocity = new PVector(5, 6, -7);
}

void draw() {
  background(255);
  lights();

  location.add(velocity);

  if ((location.x > width-200) || (location.x < 100)) {
    velocity.x = velocity.x * -1;
  }
  if ((location.y > height-200) || (location.y < 100)) {
    velocity.y = velocity.y * -1;
  }
  if ((location.z > -100) || (location.z < 0)) {
    velocity.z = velocity.z * -1;
  }

  stroke(0);
  fill(175);
  pushMatrix(); // Start a new drawing state
  translate(location.x, location.y, location.z); // Move to the location of the sphere
  sphere(16); // Draw a sphere
  popMatrix(); // Restore original state
}
