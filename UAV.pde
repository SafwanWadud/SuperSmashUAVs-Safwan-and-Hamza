//Name: Safwan 
//Brief Description: Blueprint for the UAV class
class UAV extends Rectangle {
  protected PImage img;
  protected float speed;//speed of uav

  //Constructor Method that initialises fields of object
  //Pre: Assumes x,y,w,h are all float values; assumes image is of a valid type for processing
  //Post: none
  UAV(float x, float y, float w, float h, PImage img) {
    super(x, y, w, h);
    this.img = img;
    speed = -4;
  }

  //Procedure to update the position of the uav
  //Pre: none
  //Post: sets a new x location to the uav and changes the direction of the uav if it hits a wall
  void update() {
    x+=speed;
    if ((speed > 0 && x>=width-w)|| (speed <0 && x<=0) ) { 
      speed *=-1;
    }
  }

  //Boolean function to compare the coordinates of a uav to another object that inherits from a rectangle
  //Pre: Assumes object inherits from the rectangle class
  //Post: returns true if the objects intersect, false otherwise
  boolean equals (Object o) {
    Rectangle b = (Rectangle)o;
    return (x+w>=b.x && x<=b.x+b.w && y+h>=b.y&& y<=b.y+b.h);
  }

  void show() {
    image(img, x, y);
  }

  //Procedure to change whats held inside the variable speed
  //Pre: Assumes parameter is a float
  //Post: sets speed equal to the value of the float variable passed on
  void setSpeed(float speed) 
  {
    this.speed = speed;
  }

  //Procedure to change whats held inside the variable img
  //Pre: Assumes parameter is a valid image type for processing
  //Post: sets img equal to the value of the PImage variable passed on
  void setImg(PImage img) {
    this.img=img;
  }

  //Float function to return the value of the variable speed
  //Pre: none
  //Post: returns value of speed
  float getSpeed() {
    return speed;
  }
}
