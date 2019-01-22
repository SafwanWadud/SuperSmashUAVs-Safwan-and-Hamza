//Name: Hamza Osman && Safwan Wadud
//Brief Description: Blueprint for the laser class

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

  boolean equals (Object o, Object o2) { 
    Rectangle b = (Rectangle)o;
    Rectangle p = (Rectangle)o2;
    return ( x>0 && x<width && (right && x+w>=b.x && p.x+p.w<b.x+b.w && y+h<=b.y+b.h && y>=b.y) || (!right && x<=b.x+b.w && p.x+p.w>b.x+b.w && y+h<=b.y+b.h && y>=b.y));
  }

  boolean getShot() {
    return shot;
  }

  void setShot(boolean b) {
    shot = b;
  }
}
