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
      fill(100, 200, 100);  // Green color
      ellipse(position.x, position.y, diameter, diameter);  // Drawing each segment as a circle
    }
}

Segment[] snake = new Segment[20];
float headX, headY;
float noiseOffset = 0;

void setup() {
  size(800, 600);
  headX = 0;
  headY = height / 2;
  for (int i = 0; i < snake.length; i++) {
    snake[i] = new Segment(headX - i * 10, headY, i * 0.5);
  }
}

void draw() {
  background(255);

  headX += 2;

  if (headX > width) {
    headX = 0;
    noiseOffset = 0;
  }

  if (headY > height) {
    headY = 0;
  }

  // Update segments`
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
