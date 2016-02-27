final int maxSegments = 100;
int[] xSegments = new int[maxSegments];
int[] ySegments = new int[maxSegments];

final int gridSize = 20;

void setup() {
  size(500, 500);
  for (int i = 0; i < maxSegments; i += 1) {
    xSegments[i] = ySegments[i] = -1;
  }
  xSegments[0] = width/2 / gridSize;
  ySegments[0] = width/2 / gridSize;
  snakeLength = 1;
  foodX = 10;
  foodY = 20;
  foodA = 10;
  foodB = 20;
  ellipseMode(CORNER);
}

int lastMove = 0;
int timeBetweenMoves = 500;

int xSpeed = 1;
int ySpeed = 0;
int snakeLength;

int foodX;
int foodY;
int foodA;
int foodB;

void draw() {
  background(255);
  noStroke();

  fill(0);
  for (int i = 0; i < maxSegments; i += 1) {
    rect(xSegments[i]*gridSize, ySegments[i]*gridSize, gridSize, gridSize);
  }

  fill(255, 0, 0);
  ellipse(foodX * gridSize, foodY * gridSize, gridSize, gridSize);

  if (millis() - lastMove > timeBetweenMoves) {
    lastMove = millis();
    int nextX = xSegments[0] + xSpeed;
    int nextY = ySegments[0] + ySpeed;

    for (int i = snakeLength-1; i > 0; i -= 1) {
      xSegments[i] = xSegments[i-1];
      ySegments[i] = ySegments[i-1];
    }
    if (isThereASegmentAtPosition(nextX, nextY)) {
      // snake hit itself! reset the game!
      setup();
    } else {
      xSegments[0] = nextX;
      ySegments[0] = nextY;
      if (nextX == foodX && nextY == foodY) {
        getFood();
      }
    }
      if (0 > xSegments[0] | xSegments[0] >  499) {
        setup(); //the first part of the if statement constrains the snake on the x and y axis at 0, and resets but i cant figure out how to constrain it at x=500 or y=500
      }
      if (0 > ySegments[0] | ySegments[0] > 499) {
        setup();
    }
    if(nextX == foodX && nextY == foodY){
      background(0);
    }
  }




  fill(0, 255, 0);
  ellipse(foodA * gridSize/2, foodB * gridSize, gridSize, gridSize);


  if (millis() - lastMove > timeBetweenMoves) {
    lastMove = millis();
    int nextA = xSegments[0] + xSpeed;
    int nextB = ySegments[0] + ySpeed;

    for (int i = snakeLength-1; i > 0; i -= 1) {
      xSegments[i] = xSegments[i-1];
      ySegments[i] = ySegments[i-1];
    }
    if (isThereASegmentAtPosition(nextA, nextB)) {
      // snake hit itself! reset the game!
      setup();
    } else {
      xSegments[0] = nextA;
      ySegments[0] = nextB;
      if (nextA == foodA && nextB == foodB) {
        getFood();
        // created new int for second dot so it wouldnt disappear when the first dot is eaten
      }
    }
    }
  }


void getFood() {
  snakeLength += 1;
  lastMove += 10; //to speed up the snake when it eats food

  while (isThereASegmentAtPosition(foodX, foodY)) {
    foodX = floor(random(width/gridSize));
    foodY = floor(random(width/gridSize));
  }
  while (isThereASegmentAtPosition(foodA, foodB)) {
    foodA = floor(random(width/gridSize));
    foodB = floor(random(width/gridSize));
  }
}

boolean isThereASegmentAtPosition(int x, int y) {
  for (int i = 0; i < snakeLength; i += 1) {
    if (xSegments[i] == x && ySegments[i] == y) {
      return true;
    }
  }
  return false;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      ySpeed = -1;
      xSpeed = 0;
    }
    if (keyCode == DOWN) {
      ySpeed = 1;
      xSpeed = 0;
    }
    if (keyCode == RIGHT) {
      ySpeed = 0;
      xSpeed = 1;
    }
    if (keyCode == LEFT) {
      ySpeed = 0;
      xSpeed = -1;
    }
  }
}
