class Laser extends Rectangle {
  PImage img;
  boolean shot;
  boolean right;

  Laser(PImage img)
  {
    super(0, 0, 40, 10);
    this.img = img;
    shot = false;
    right = true;
  }

  void show()
  {
    image(img, x, y, w, h);
  }

  void move() {
    if (right)
      x+= 10;
    else
      x-= 10;
      
    if (x > width || x+w < 0)
    {
      shot = false;
    }
  }
}
