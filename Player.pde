/*Player Class
Hamza Osman

*/

class Player {
  private PImage img;
  private float x;
  private float y;
  private float w;
  boolean inAir;
  private float gravity;
  private float yVelocity;

  Player(float x, float y, float w, PImage img) {
    // this template for the current Frog object
    this.img = img;
    this.x = x;
    this.y = y;
    this.w = w;
    inAir = false;
    gravity = 1.0;
    yVelocity = 0;
  }

  void show() {
    image(img, x, y, w, w);
  }

  void update() {
    if (inAir && y < height) {
      yVelocity += gravity;
      y+= yVelocity;
    } 
    
    if (y > height-w)
    {
      inAir = false;
      yVelocity = 0;
      y = height-w;
    }
    
    image(img, x, y, w, w);
  }

  void move(float xdir) {
    x+= xdir;

    if (x>(width-w))
      x=width-w;

    if (x<0)
      x=0;
  }

  void jump(float yVelocity) 
  {
    this.yVelocity = yVelocity;
    
    //Probably trash
    //float max = y - yVelocity;

    //do
    //{
    //  y = y - 20;
    //}
    //while (y > max);

    //if (y>(height-w)) 
    //  y=height-w;

    //if (y<0)
    //  y=0;
  }

  float getY()
  {
    return y;
  }

  void setY(float y)
  {
    if (y < height-w)
      this.y = y;
    else 
    inAir = false;
  }
}
