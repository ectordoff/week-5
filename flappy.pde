float[] values;
int index;
int y = 150;
int k = 0;

void setup() {
  size(600, 250);
  background(0);
  frameRate(40);


  values = new float[width/3];
  index = 0;
}

float maybeRandomHeight() {
  if ((k%31)==0) {
    return random(height/3, 2*height/3);
  } else {
    return 0;
  }
}

void draw() {
  background(255);

  values[index] = maybeRandomHeight();
  index = index + 1;
  if (index >= values.length) {
    index = 0;
  }

  for (int i = 0; i < values.length; ++i) {
    int realIndex = index + i;
    if (realIndex >= values.length) {
      realIndex -= values.length;
    }
    if (values[realIndex] > 0) {
      line(i*3, height-values[realIndex], i*3, height);
      line(i*3, 0, i*3, height-values[realIndex]-40);
    }
  }
  ellipse(100, y, 10, 10);
  ellipse(100, y, 5, 5);
  ellipse(108, y, 2, 2);
  y+=2;
  if (keyPressed == true) {
    y = y-5;
  }
  k++;
}
