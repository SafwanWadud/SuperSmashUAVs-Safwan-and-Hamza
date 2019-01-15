//Name: Hamza Osman
//Brief Description: Blueprint for the Player class

class Player extends Rectangle {
  PImage img;
  boolean inAir; 
  boolean moving; //L or Right
  boolean right;
  private float gravity;
  private float yVelocity;
  private float xVelocity;

  Player(float x, float y, float w, PImage img) {
    super(x, y, w, w);
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

  float getxVelocity() {
    return xVelocity;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getW() {
    return w;
  }
}
