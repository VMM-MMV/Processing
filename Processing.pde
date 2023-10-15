ArrayList<PVector> cubes = new ArrayList<PVector>();
ArrayList<PVector> spheres = new ArrayList<PVector>();
ArrayList<PVector> bullets = new ArrayList<PVector>();

ArrayList<PVector> cubeRotations = new ArrayList<PVector>();
ArrayList<PVector> sphereRotations = new ArrayList<PVector>();

ArrayList<PVector> cubeCurrentRotations = new ArrayList<PVector>();
ArrayList<PVector> sphereCurrentRotations = new ArrayList<PVector>();

int bulletAmount = 100;
int enemiesAmount = 0;
String gameState = "menu";
int difficulty = 1;
int minutes;
int seconds;

int startTime;
int elapsedTime;
float quarterOfScreen = width / 4;

void setup() {
  size(800, 600, P3D);
}

void displayMenu() {
  float quarterOfScreen = width / 4;
  textSize(48);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  
  text("EASY", quarterOfScreen * 0.5, height / 2);
  text("MEDIUM", quarterOfScreen * 1.5, height / 2);
  text("HARD", quarterOfScreen * 2.5, height / 2);
  text("HELL", quarterOfScreen * 3.5, height / 2);
}

void checkGameOver() {
  if (bulletAmount <= 0 || (cubes.size() + spheres.size()) >= 30) {
    gameState = "end";
    bulletAmount = 1;
  }
}

void displayGameOver() {
  textSize(48);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("YOU LOSE" + "\nYOUR TIME: " + minutes + ":" + seconds + "\n" + "RESTART" , width / 2, height / 2);
}

int probabilisticFunction() {
  if (random(1) < 0.5) {
    return 2;
  } else {
    return 1;
  }
}

void bullet_collisions(PVector bullet, ArrayList<PVector> objects, ArrayList<PVector> rotations, ArrayList<PVector> currentRotations) {
    for (int j = objects.size() - 1; j >= 0; j--) {
        PVector obj = objects.get(j);
        if (dist(bullet.x, bullet.y, bullet.z, obj.x, obj.y, obj.z) < 50) {
            objects.remove(j);
            rotations.remove(j);
            currentRotations.remove(j);
            bullets.remove(bullet);
            bulletAmount += probabilisticFunction();
            break;
        }
    }
}

void spawnCubes() {
    if (random(100) < difficulty) {
        cubes.add(new PVector(random(100, width-100), random(100, height-100), random(-300, -100)));
        cubeRotations.add(new PVector(random(-0.1, 0.1), random(-0.1, 0.1), random(-0.1, 0.1)));
        cubeCurrentRotations.add(new PVector(0, 0, 0));
    }
    renderCubes();
}

void spawnSpheres() {
    if (random(100) < difficulty) {
        spheres.add(new PVector(random(100, width-100), random(100, height-100), random(-300, -100)));
        sphereRotations.add(new PVector(random(-0.1, 0.1), random(-0.1, 0.1), random(-0.1, 0.1)));
        sphereCurrentRotations.add(new PVector(0, 0, 0));
    }
    renderSpheres();
}

void renderCubes() {
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

void renderSpheres() {
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

void bulletText() {
  textSize(24);
  fill(0);
  textAlign(RIGHT, TOP);
  text("Bullets: " + bulletAmount, width - 10, 10);
}

void enemiesText() {
  textSize(24);
  fill(0);
  textAlign(LEFT, TOP);
  text("Enemies: " + int(cubes.size() + spheres.size()), 10, 10);
}

void displayElapsedTime() {
  elapsedTime = (millis() - startTime) / 1000;
  minutes = elapsedTime / 60;
  seconds = elapsedTime % 60;
  
  textSize(24);
  fill(0);
  textAlign(RIGHT, BOTTOM);
  text("Time: " + nf(minutes, 2) + ":" + nf(seconds, 2), width - 10, height - 10);
}


void draw() {
  background(200);
  lights();
  checkGameOver();
  if (gameState.equals("menu")) {
    displayMenu();
  } else if (gameState.equals("play")) {
    bulletText();
    enemiesText();
    displayElapsedTime();

      fill(255);
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
        if (bullet.z < -500) {
          bullets.remove(bullet);
        } 
      }
  } else if (gameState.equals("end")) {
    displayGameOver();
  }
}

void menu() {
  float halfOfScreen = width / 2;

  if (mouseX < halfOfScreen * 0.5) {
    difficulty = 1;
    bulletAmount = 100;
  } else if (mouseX <  halfOfScreen) {
    difficulty = 2;
    bulletAmount = 50;
  } else if (mouseX < halfOfScreen * 1.5) {
    difficulty = 3;
    bulletAmount = 25;
  } else {
    difficulty = 4;
    bulletAmount = 10;
  }
  startTime = millis();
  gameState = "play";
}

void mousePressed() {
  if (gameState.equals("menu")) {
    menu();
  } else if (gameState.equals("play") && mouseButton == LEFT && bulletAmount > 0) {
    bullets.add(new PVector(mouseX, mouseY, 0));
    bulletAmount -= 1;
  } else if (gameState.equals("end")){
    if ((mouseX < (width / 2 + 100))) {
      cubes.clear();
      spheres.clear();
      bullets.clear();
      cubeRotations.clear();
      sphereRotations.clear();
      cubeCurrentRotations.clear();
      sphereCurrentRotations.clear();
      gameState = "menu";
    }
  }
}