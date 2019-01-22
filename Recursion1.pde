//Name: Safwan Wadud
//Brief Description: Blueprint for recursion1 class
class Recursion1 {
  private float r, g, b;

  //Constructor Method that initialises fields of object
  //Pre: none
  //Post: none
  Recursion1() {
    r = 0;
    g = 0;
    b = 0;
  }

  //Procedure that forms a horizontal-vertical pattern
  //Pre: Assumes all values coming in are long values
  //Post: none 
  void fractal1(long x, long y, long w, long h) {
    if (w>0) {//Exit condition; recursion ends when w is not greater than 0
      w /=2;//width and height cut in half
      h /=2;
      r = random(0, 255);//random colour for fill
      g = random(0, 255);
      b = random(0, 255);
      fill(r, g, b);

      x-=w;//horizontal translation
      ellipse(x, y, w, h);//creates an ellipse
      fractal1(x, y, w, h); //calls on itself   
      fractal2(x, y, w, h);//calls on second fractal 

      x+=2*w;
      ellipse(x, y, w, h);
      fractal1(x, y, w, h);
      fractal2(x, y, w, h);
    }
  }

  //Procedure that forms a vertical pattern
  //Pre: Assumes all values coming in are long values
  //Post: none
  void fractal2(long x, long y, long w, long h) {
    if (w>0) {
      w /=2;
      h /=2;
      r = random(0, 255);
      g = random(0, 255);
      b = random(0, 255);
      fill(r, g, b);

      y-=h;
      ellipse(x, y, w, h);
      fractal2(x, y, w, h);

      y+=2*h;
      ellipse(x, y, w, h);
      fractal2(x, y, w, h);
    }
  }

  //Procedure that forms a vertical-horizontal pattern
  //Pre: Assumes all values coming in are long values
  //Post: none
  void fractal3(long x, long y, long w, long h) {
    if (w>0) {
      w /=2;
      h /=2;
      r = random(0, 255);
      g = random(0, 255);
      b = random(0, 255);
      fill(r, g, b);

      y-=h;
      ellipse(x, y, w, h);
      fractal2(x, y, w, h);
      fractal1(x, y, w, h);

      y+=2*h;
      ellipse(x, y, w, h);
      fractal2(x, y, w, h);
      fractal1(x, y, w, h);
    }
  }

  //Procedure that creates and shows the recursive design
  //Pre: none
  //Post: creates 2 recursive designs to make a fractal design
  void showFractal() {
    background(0);//black background
    frameRate(5);//refreshes 5 times a second
    fractal1(width/2, height/2, 300, 200);//calls on first and third recursive functions
    fractal3(width/2, height/2, 200, 300);
  }
}
