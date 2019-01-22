//Name: Hamza Osman && Safwan Wadud
//Brief Description: Blueprint for the laser class

class Laser extends Rectangle {
  PImage img; 
  boolean shot; //Boolean if laser has been shot
  boolean right; //Boolean if shot in right direction

  //Constructor Method that initialises fields of object
  //Pre: none
  //Post: none
  Laser(PImage img)
  {
    super(0, 0, 40, 10);
    this.img = img;
    shot = false;
    right = true;
  }

  //Instance Method that displays on the screen
  //Pre: none
  //Post: laser object displayed on screen
  void show()
  {
    image(img, x, y, w, h);
  }

  //Instance Method that displays on the screen and checks if off screen
  //Pre: none
  //Post: laser moves in direction the player is facing and dissapears off screen
  void move() {
    if (right)
      x+= 10;
    else
      x-= 10;

    if (x > width || x+w < 0)
      shot = false;
  }

  //Boolean function to compare the coordinates of a laser to another object that inherits from a rectangle
  //Pre: Assumes object inherits from the rectangle class
  //Post: returns true if the objects intersect, false otherwise
  boolean equals (Object o, Object o2) { 
    Rectangle b = (Rectangle)o;
    Rectangle p = (Rectangle)o2;
    return ( x>0 && x<width && (right && x+w>=b.x && p.x+p.w<b.x+b.w && y+h<=b.y+b.h && y>=b.y) || (!right && x<=b.x+b.w && p.x+p.w>b.x+b.w && y+h<=b.y+b.h && y>=b.y));
  }

  //Accessor method to access private shot variable
  //Pre: none
  //Post: returns shot
  boolean getShot() {
    return shot;
  }

  //Mutator method
  //Pre: none
  //Post: changes the value of the shot boolean
  void setShot(boolean b) {
    shot = b;
  }
}
