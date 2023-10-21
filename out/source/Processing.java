/* autogenerated by Processing revision 1293 on 2023-10-21 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class Processing extends PApplet {

class Segment {
  PVector position;
  float offset;

  Segment(float x, float y, float offset) {
    position = new PVector(x, y);
    this.offset = offset;
  }

  public void update(float x, float y) {
    position.set(x, y);
  }

  public void display(float diameter) {
      fill(100, 200, 100);  // Green color
      ellipse(position.x, position.y, diameter, diameter);  // Drawing each segment as a circle
    }
}

Segment[] snake = new Segment[20];  // Snake with 20 segments
float headX, headY;
float noiseOffset = 0;

public void setup() {
  /* size commented out by preprocessor */;
  headX = 0;
  headY = height / 2;
  for (int i = 0; i < snake.length; i++) {
    snake[i] = new Segment(headX - i * 10, headY, i * 0.5f);
  }
}

public void draw() {
  background(255);

  headX += 2;

  if (headX > width) {
    headX = 0;
    noiseOffset = 0;
  }

  if (headY > height) {
    headY = 0;
  }

  // Update segments
  for (int i = 0; i < snake.length; i++) {
    float x = headX - i * 10;
    float y = headY + sin(radians(i * 20 + frameCount * 2)) * 10; 

    snake[i].update(x, y);
  }
  
  // Display segments from 1 to length - 1
  for (int i = 1; i < snake.length; i++) {
    snake[i].display(10);  // Default size for the other segments
  }

  // Display head segment last, so it's drawn on top
  snake[0].display(20);  // Larger size for the first segment
}


  public void settings() { size(800, 600); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
