PVector location = new PVector(0, 0);
PVector velocity = new PVector(2, 2);

void setup() {
  size(640, 360);
}

void draw() {
  background(255);
  location.add(velocity);
  ellipse(location.x, location.y, 20, 20);

  if ((location.x > width) || (location.x < 0)) {
    velocity.x = velocity.x * -1;
  }
  else if ((location.y > height) || (location.y < 0)) {
    velocity.y = velocity.y * -1;
  }

}