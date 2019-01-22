//Name: Hamza Osman
//Brief Description: Blueprint for recursion2 class
class Recursion2 {
  private float r, g, b; //rgb colors for outline and fill of rectangle
  float d; //diameter of circles

  //Constructor Method that initialises fields of object
  //Pre: none
  //Post: none
  Recursion2() {
    r = 0;
    g = 0;
    b = 0;
    d = 55;
  }

  /*Instance Method that creates fractal design
   * Pre: None
   * Post: Creates a part of the fractal design
   */
  void drawFractal1(float x, float y, float d) {
    r = random(0, 255);//random colour for fill
    g = random(0, 255);
    b = random(0, 255);
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, d, d);

    if (d > 15) {
      drawFractal1(x+d, y, d-5);
      drawFractal1(x, y-d, d-5);
    }
  }

  /*Instance Method that creates fractal design
   * Pre: None
   * Post: Creates a part of the fractal design
   */
  void drawFractal2(float x, float y, float d) {
    r = random(0, 255);//random colour for fill
    g = random(0, 255);
    b = random(0, 255);
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, d, d);

    if (d > 15) {
      drawFractal2(x-d, y, d-5);
      drawFractal2(x, y-d, d-5);
    }
  }

  /*Instance Method that creates fractal design
   * Pre: None
   * Post: Creates a part of the fractal design
   */
  void drawFractal3(float x, float y, float d) {
    r = random(0, 255);//random colour for fill
    g = random(0, 255);
    b = random(0, 255);
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, d, d);

    if (d > 15) {
      drawFractal3(x-d, y, d-5);
      drawFractal3(x, y+d, d-5);
    }
  }

  /*Instance Method that creates fractal design
   * Pre: None
   * Post: Creates a part of the fractal design
   */
  void drawFractal4(float x, float y, float d) {
    r = random(0, 255);//random colour for fill
    g = random(0, 255);
    b = random(0, 255);
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, d, d);

    if (d > 15) {
      drawFractal4(x+d, y, d-5);
      drawFractal4(x, y+d, d-5);
    }
  }

  /*Instance Method that displays the fractal design
   * Pre: None
   * Post: Displays the fractal design
   */
  void showFractal() {  
    background(0);//black background
    //drawCircle(x,y,diameter)
    drawFractal1(width/2, height/2, d);
    drawFractal2(width/2, height/2, d);
    drawFractal3(width/2, height/2, d);
    drawFractal4(width/2, height/2, d);
  }
}
