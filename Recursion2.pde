//Name: Hamza Osman
//Brief Description: Blueprint for recursion2 class
class Recursion2 {
  private float r, g, b;
  float d;

  Recursion2() {
    r = 0;
    g = 0;
    b = 0;
    d = 55;
  }

  void drawCircle(float x, float y, float d) {
    r = random(0, 255);//random colour for fill
    g = random(0, 255);
    b = random(0, 255);
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, d, d);

    if (d > 15) {
      drawCircle(x+d, y, d-5);
      drawCircle(x, y-d, d-5);
    }
  }

  void drawCircle2(float x, float y, float d) {
    r = random(0, 255);//random colour for fill
    g = random(0, 255);
    b = random(0, 255);
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, d, d);

    if (d > 15) {
      drawCircle2(x-d, y, d-5);
      drawCircle2(x, y-d, d-5);
    }
  }

  void drawCircle3(float x, float y, float d) {
    r = random(0, 255);//random colour for fill
    g = random(0, 255);
    b = random(0, 255);
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, d, d);

    if (d > 15) {
      drawCircle3(x-d, y, d-5);
      drawCircle3(x, y+d, d-5);
    }
  }

  void drawCircle4(float x, float y, float d) {
    r = random(0, 255);//random colour for fill
    g = random(0, 255);
    b = random(0, 255);
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, d, d);

    if (d > 15) {
      drawCircle4(x+d, y, d-5);
      drawCircle4(x, y+d, d-5);
    }
  }


  void showFractal() {  
    background(0);//black background
    //drawCircle(x,y,diameter)
    drawCircle(width/2, height/2, d);
    drawCircle2(width/2, height/2, d);
    drawCircle3(width/2, height/2, d);
    drawCircle4(width/2, height/2, d);
  }
}
