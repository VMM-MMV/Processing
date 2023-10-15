Mover car;

void setup() {
  size(640, 360);
  car = new Mover();
}

void draw() {
  background(255);
  car.update();
  car.checkEdges();
  car.display();
}

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;

  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    topspeed = 100;
  }

  void update() {
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == UP) {
          acceleration.set(0, -0.1);
        } else if (keyCode == DOWN) {
          acceleration.set(0, 0.1);
        }
      }
    } else {
      acceleration.set(0, 0);
    }

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
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
