//Name: Safwan Wadud & Hamza Osman
//Brief Description: Blueprint for rectangle class
class Rectangle {
  protected float x, y, w, h;//x and y coordinates of top left corner, width, and height of rectangle
  protected float r, g, b; //rgb colors for outline and fill of rectangle

  //Constructor Method that initialises fields of object
  //Pre: none
  //Post: none
  Rectangle(float x, float y, float w, float h, float r, float g, float b) { //Constructor
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    this.r = r;
    this.g = g;
    this.b = b;
  }

  //Constructor Method that initialises fields of object
  //Pre: none
  //Post: none
  Rectangle(float x, float y, float w, float h) {//Constructor
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    r = 255;
    g = 255;
    b = 255;
  }

  /*Instance Method checks if mouse x,y coordinates are within the rectangle
   * Pre: None
   * Post: Returns true if mouse x,y coordinates are within rectangle
   */
  boolean isInside() {//Checks to see if mouse x,y coordinates are within the rectangle
    return (mouseX >= x && mouseX <= (x+w) && mouseY >= y & mouseY <= y+h);
  }

  /*Instance Method that creates an invisible rectangle
   * Pre: None
   * Post: Creates the rectangle on screen
   */
  void invisibleRect() {
    noStroke();
    noFill();
    rect(x, y, w, h);
  }

  /*Instance Method that creates a filled rectangle based on rgb values 
   * Pre: None
   * Post: Creates the rectangle on screen
   */
  void colorRect1() {
    noStroke();
    fill(r, g, b);
    rect(x, y, w, h);
  }

  /*Instance Method that creates a stroke around rectangle based on rgb values 
   * Pre: None
   * Post: Creates the rectangle on screen
   */
  void colorRect2() {
    stroke(r, g, b);
    strokeWeight(4);
    noFill();
    rect(x, y, w, h);
  }

  /*Instance Method that creates a stroke around rectangle based on rgb values and a grey fill
   * Pre: None
   * Post: Creates the rectangle on screen
   */
  void colorRect3() {
    stroke(r, g, b);
    strokeWeight(4);
    fill(130);
    rect(x, y, w, h);
  }

  //Mutator method
  //Pre: none
  //Post: changes the r,g,b values(the 3 colors) 
  void setColor(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
  } 

  /*Instance Method looks for intersections
   * Pre: Object is a rectangle object
   * Post: returns an int based on the type of intersection
   */
  int intersection(Object o)
  { 
    Rectangle b = (Rectangle)o;
    if (x + w > b.x && x < b.x + b.w && y + h >= b.y - 20 && y + h <= b.y + b.h + 20) //Intersection not from bottom
      return 1;
    else if (x + w > b.x && x < b.x + b.w && y > b.y + b.h && y < b.y + b.h + 20) //Intersection from bottom
      return 2;

    return 3;
  }

  //Mutator method
  //Pre: none
  //Post: changes the x field 
  void setX(float x) {
    this.x=x;
  }

  //Accessor method to access protected x variable
  //Pre: none
  //Post: returns x
  float getX() {
    return x;
  }

  //Accessor method to access protected y variable
  //Pre: none
  //Post: returns y
  float getY() {
    return y;
  }

  //Accessor method to access protected width variable
  //Pre: none
  //Post: returns width
  float getW() {
    return w;
  }

  //Accessor method to access protected height variable
  //Pre: none
  //Post: returns height
  float getH() {
    return h;
  }
}
