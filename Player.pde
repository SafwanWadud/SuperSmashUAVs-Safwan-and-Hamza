/*Player Class
 Hamza Osman
 
 */

class Player {
  PImage img;
  private float x;
  private float y;
  private float w;
  boolean inAir; 
  boolean moving; //L or Right
  private float gravity;
  private float yVelocity;
  float xVelocity;

  Player(float x, float y, float w, PImage img) {
    // this template for the current Frog object
    this.img = img;
    this.x = x;
    this.y = y;
    this.w = w;
    inAir = false;
    gravity = 2.0;
    yVelocity = 0;
    xVelocity = 0;
  }

  void update() {
    if (inAir) {
      yVelocity += gravity;
      y+= yVelocity;

      if (y >= height-w)
      {
        inAir = false;
        yVelocity = 0;
        y = height-w;
      }
      image(img, x, y, w, w);
    } 

    if (moving && xVelocity != 0) {
      x+= xVelocity;

      if (x>(width-w))
        x=width-w;

      if (x<0)
        x=0;

      if (!inAir)
        image(img, x, y, w, w);
    }

    if (!(inAir || moving))
    {
      image(img, x, y, w, w);
    }
  }


  void setyVelocity(float yVelocity) 
  {
    this.yVelocity = yVelocity;
  }

  void setxVelocity(float xVelocity) 
  {
    this.xVelocity = xVelocity;
  }
}
