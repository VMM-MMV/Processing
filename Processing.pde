PVector location;

void setup() {
  size(640, 360);
  location = new PVector(width/2, height/2);
  background(255);
}

void draw() {
  int choice = int(random(4));

  if (choice == 0) {
    location.x++;
  } else if (choice == 1) {
    location.x--;
  } else if (choice == 2) {
    location.y++;
  } else {
    location.y--;
  }

  stroke(0);
  point(location.x, location.y);
}
