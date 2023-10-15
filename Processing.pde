Mover mover;

void setup() {
  size(640, 360);
  mover = new Mover();
}

void draw() {
  background(255);
  mover.update();
  mover.checkEdges();
  mover.display();
}

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;

  // Initialize Perlin noise offsets
  float xoff = 0;
  float yoff = 1000; // Arbitrary value to make it different from xoff

  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    topspeed = 5;
  }

  void update() {
    // Use Perlin noise to get a smooth random value between 0 and 1
    float ax = noise(xoff);
    float ay = noise(yoff);

    // Map the values to desired acceleration range, for example -0.1 to 0.1
    ax = map(ax, 0, 1, -0.1, 0.1);
    ay = map(ay, 0, 1, -0.1, 0.1);

    acceleration.set(ax, ay);

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);

    // Increment the offsets to move through the Perlin noise space
    xoff += 0.01;
    yoff += 0.01;
  }

  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
