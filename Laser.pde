//Name: Hamza Osman
//Brief Description: Blueprint for the Player class

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

  int intersection(Object o, Object o2) { 
    Rectangle b = (Rectangle)o;
    Rectangle p = (Rectangle)o2;
    if (x>0 && x<width) {
      if (right && x+w>=b.x && p.x+p.w<b.x && y+h<=b.y+b.h && y>=b.y)
        return 1;
      else if (!right && x<=b.x+b.w && p.x>b.x+b.w && y+h<=b.y+b.h && y>=b.y)
        return 2;
    }
    return 3;
  }

  void setX(float x) {
    this.x =x;
  }

  void setShot(boolean b) {
    shot = b;
  }
}
