class Player {
  private PImage img;
  private float x;
  private float y;
  private float w;
  boolean inAir;
  float gravity;

  Player(float x, float y, float w, PImage img) {
    // this template for the current Frog object
    this.img = img;
    this.x = x;
    this.y = y;
    this.w = w;
    inAir = false;
    gravity = 10;
  }

  void show() {
    image(img, x, y, w, w);
  }

  void move(float xdir) {
    x+= xdir;

    if (x>(width-w))
      x=width-w;

    if (x<0)
      x=0;
  }

  void jump(float ydir) 
  {
    //loop that ends whrn y+= ydir
    //each loop it jumps a few seconds
    y+= ydir;
    if (y>(height-w)) 
      y=height-w;

    if (y<0)
      y=0;
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
