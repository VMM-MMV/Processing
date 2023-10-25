class Segment {
  PVector position;
  float offset;

  Segment(float x, float y, float offset) {
    position = new PVector(x, y);
    this.offset = offset;
  }

  void update(float x, float y) {
    position.set(x, y);
  }

  void display(float diameter) {
    fill(139, 69, 19);  // Green color
    ellipse(position.x, position.y, diameter, diameter);  // Drawing each segment as a circle
  }
}

Segment[] snake = new Segment[20];
float headX, headY;
float noiseOffset = 0;

int numGrass = 5000; // Number of grass blades to draw
Grass[] grasses = new Grass[numGrass];

void setup() {
  size(800, 600);
  background(50, 150, 50); // Green background representing the lawn

  randomSeed(10);
  noiseSeed(99);

  for (int i = 0; i < numGrass; i++) {
    grasses[i] = new Grass(random(width), random(height));
  }

  headX = 0;
  headY = height / 2;
  for (int i = 0; i < snake.length; i++) {
    snake[i] = new Segment(headX - i * 10, headY, i * 0.5);
  }
}

void draw() {
  background(50, 150, 50);

  for (int i = 0; i < numGrass; i++) {
    grasses[i].display();
    grasses[i].update();
  }

  headX += 2;

  if (headX > width) {
    headX = 0;
    noiseOffset = 0;
  }

  if (headY > height) {
    headY = 0;
  }

  for (int i = 0; i < snake.length; i++) {
    float x = headX - i * 10;
    float y = headY + sin(radians(i * 20 + frameCount * 2)) * 10;

    snake[i].update(x, y);
  }

  for (int i = 1; i < snake.length; i++) {
    snake[i].display(10);
  }

  snake[0].display(20);
}

class Grass {
  float x, y;
  float height;
  float sway;
  float swaySpeed;
  float noiseOffsetX, noiseOffsetY;

  Grass(float x_, float y_) {
    x = x_;
    y = y_;
    height = random(10, 20);
    sway = 0;
    swaySpeed = random(0.01, 0.03);
    noiseOffsetX = random(0, 1000);
    noiseOffsetY = random(0, 1000);
  }

  void update() {
    sway = map(noise(noiseOffsetX, noiseOffsetY), 0, 1, -5, 5);
    noiseOffsetX += swaySpeed;
    noiseOffsetY += swaySpeed;
  }

  void display() {
    float baseGreen = map(noise(noiseOffsetX), 0, 1, 100, 255);
    float r = randomGaussian() * 10;
    float g = baseGreen + r;
    float b = r * 0.5;
    stroke(r, g, b);
    line(x, y, x + sway, y - height);
  }
}
