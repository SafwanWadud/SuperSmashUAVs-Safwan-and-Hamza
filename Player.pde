//Name: Hamza Osman
//Brief Description: Blueprint for the player class

class Player extends Rectangle {
  PImage img;
  boolean inAir; 
  boolean moving; //L or Right
  boolean right;
  private float gravity;
  private float yVelocity;
  private float xVelocity;

  Player(float x, float y, float w, float h, PImage img) {
    super(x, y, w, h);
    this.img = img;
    inAir = false;
    gravity = 2.0;
    yVelocity = 0;
    xVelocity = 0;
    right = true;
  }

  void update() {
    if (inAir) {
      yVelocity += gravity;
      y+= yVelocity;

      if (y >= height-h)
      {
        inAir = false;
        yVelocity = 0;
        y = height-h;
      }

      if (y < 0)
      {
        yVelocity = 0;
        y = 0;
      }

      image(img, x, y, w, h);
    } 

    if (moving && xVelocity != 0) {
      x+= xVelocity;

      if (x>(width-w))
        x=width-w;

      if (x<0)
        x=0;

      if (!inAir)
        image(img, x, y, w, h);
    }

    if (!(inAir || moving))
    {
      image(img, x, y, w, h);
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

  float getxVelocity() {
    return xVelocity;
  }
}
