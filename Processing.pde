ArrayList<PVector> cubes = new ArrayList<PVector>();
ArrayList<PVector> spheres = new ArrayList<PVector>();
ArrayList<PVector> bullets = new ArrayList<PVector>();

void setup() {
  size(800, 600, P3D);
}

void bullet_collisions(PVector bullet, ArrayList<PVector> objects) {
    for (int j = objects.size() - 1; j >= 0; j--) {
        PVector obj = objects.get(j);
        if (dist(bullet.x, bullet.y, bullet.z, obj.x, obj.y, obj.z) < 50) {
            objects.remove(j);
            bullets.remove(bullet);
            break;
        }
    }
}

void spawnCubes() {
    if (random(100) < 1) {
        cubes.add(new PVector(random(100, width-100), random(100, height-100), random(-300, -100)));
    }
    renderCubes();
}

void spawnSpheres() {
    if (random(100) < 1) {
        spheres.add(new PVector(random(100, width-100), random(100, height-100), random(-300, -100)));
    }
    renderSpheres();
}

void renderCubes() {
    for (PVector cube : cubes) {
        pushMatrix();
        translate(cube.x, cube.y, cube.z);
        box(50);
        popMatrix();
    }
}

void renderSpheres() {
    for (PVector sphere : spheres) {
        pushMatrix();
        translate(sphere.x, sphere.y, sphere.z);
        sphere(30);
        popMatrix();
    }
}

void draw() {
  background(200);
  lights();
  
  spawnCubes();
  spawnSpheres();
  
  // Render bullets and check for collisions
  for (int i = bullets.size() - 1; i >= 0; i--) {
    PVector bullet = bullets.get(i);
    bullet.z -= 10;
    pushMatrix();
    translate(bullet.x, bullet.y, bullet.z);
    sphere(5);
    popMatrix();
    
    bullet_collisions(bullet, cubes);
    bullet_collisions(bullet, spheres);
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    bullets.add(new PVector(mouseX, mouseY, 0));
  }
}
