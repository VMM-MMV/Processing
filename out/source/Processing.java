/* autogenerated by Processing revision 1293 on 2023-10-06 */
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

ArrayList<PVector> cubes = new ArrayList<PVector>();
ArrayList<PVector> spheres = new ArrayList<PVector>();
ArrayList<PVector> bullets = new ArrayList<PVector>();

ArrayList<PVector> cubeRotations = new ArrayList<PVector>();
ArrayList<PVector> sphereRotations = new ArrayList<PVector>();

ArrayList<PVector> cubeCurrentRotations = new ArrayList<PVector>();
ArrayList<PVector> sphereCurrentRotations = new ArrayList<PVector>();

public void setup() {
  /* size commented out by preprocessor */;
}

public void bullet_collisions(PVector bullet, ArrayList<PVector> objects, ArrayList<PVector> rotations, ArrayList<PVector> currentRotations) {
    for (int j = objects.size() - 1; j >= 0; j--) {
        PVector obj = objects.get(j);
        if (dist(bullet.x, bullet.y, bullet.z, obj.x, obj.y, obj.z) < 50) {
            objects.remove(j);
            rotations.remove(j);
            currentRotations.remove(j);
            bullets.remove(bullet);
            break;
        }
    }
}

public void spawnCubes() {
    if (random(100) < 1) {
        cubes.add(new PVector(random(100, width-100), random(100, height-100), random(-300, -100)));
        cubeRotations.add(new PVector(random(-0.1f, 0.1f), random(-0.1f, 0.1f), random(-0.1f, 0.1f)));
        cubeCurrentRotations.add(new PVector(0, 0, 0));
    }
    renderCubes();
}

public void spawnSpheres() {
    if (random(100) < 1) {
        spheres.add(new PVector(random(100, width-100), random(100, height-100), random(-300, -100)));
        sphereRotations.add(new PVector(random(-0.1f, 0.1f), random(-0.1f, 0.1f), random(-0.1f, 0.1f)));
        sphereCurrentRotations.add(new PVector(0, 0, 0));
    }
    renderSpheres();
}

public void renderCubes() {
    for (int i = 0; i < cubes.size(); i++) {
        PVector cube = cubes.get(i);
        PVector rotationSpeed = cubeRotations.get(i);
        PVector currentRotation = cubeCurrentRotations.get(i);
        
        currentRotation.add(rotationSpeed);
        
        pushMatrix();
        translate(cube.x, cube.y, cube.z);
        rotateX(currentRotation.x);
        rotateY(currentRotation.y);
        rotateZ(currentRotation.z);
        box(50);
        popMatrix();
    }
}

public void renderSpheres() {
    for (int i = 0; i < spheres.size(); i++) {
        PVector sphere = spheres.get(i);
        PVector rotationSpeed = sphereRotations.get(i);
        PVector currentRotation = sphereCurrentRotations.get(i);
        
        currentRotation.add(rotationSpeed);
        
        pushMatrix();
        translate(sphere.x, sphere.y, sphere.z);
        rotateX(currentRotation.x);
        rotateY(currentRotation.y);
        rotateZ(currentRotation.z);
        sphere(30);
        popMatrix();
    }
}

public void draw() {
  background(200);
  lights();
  
  spawnCubes();
  spawnSpheres();
  
  for (int i = bullets.size() - 1; i >= 0; i--) {
    PVector bullet = bullets.get(i);
    bullet.z -= 10;
    pushMatrix();
    translate(bullet.x, bullet.y, bullet.z);
    sphere(5);
    popMatrix();
    
    bullet_collisions(bullet, cubes, cubeRotations, cubeCurrentRotations);
    bullet_collisions(bullet, spheres, sphereRotations, sphereCurrentRotations);
  }
}

public void mousePressed() {
  if (mouseButton == LEFT) {
    bullets.add(new PVector(mouseX, mouseY, 0));
  }
}


  public void settings() { size(800, 600, P3D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
