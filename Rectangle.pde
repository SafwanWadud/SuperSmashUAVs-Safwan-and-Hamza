//Name: Safwan Wadud & Hamza
//Brief Description: Blueprint for rectangle class
class Rectangle {
  protected float x, y, w, h;//x and y coordinates of top left corner, width, and height of rectangle
  protected float r, g, b; //rgb colors for outline and fill of rectangle

  Rectangle(float x, float y, float w, float h, float r, float g, float b) { //Constructor
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    this.r = r;
    this.g = g;
    this.b = b;
  }

  Rectangle(float x, float y, float w, float h) {//Constructor
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    r = 255;
    g = 255;
    b = 255;
  }

  boolean isInside() {//Checks to see if mouse x,y coordinates are within the rectangle
    return (mouseX >= x && mouseX <= (x+w) && mouseY >= y & mouseY <= y+h);
  }

  void invisibleRect() {
    noStroke();
    noFill();
    rect(x, y, w, h);
  }

  void colorRect1() {
    noStroke();
    fill(r, g, b);
    rect(x, y, w, h);
  }

  void colorRect2() {
    stroke(r, g, b);
    strokeWeight(4);
    noFill();
    rect(x, y, w, h);
  }

  void colorRect3() {
    stroke(r, g, b);
    strokeWeight(4);
    fill(130);
    rect(x, y, w, h);
  }

  void setColor(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
  } 

  int intersection(Rectangle b)
  { 
    if (x + w > b.x && x < b.x + b.w && y + h >= b.y - 20 && y + h <= b.y + b.h + 20)
      return 1;
    else if (x + w > b.x && x < b.x + b.w && y > b.y + b.h && y + h < b.y + b.h + h + 20)
      return 2;
    //else if (x + w > b.x && x < b.x + b.w)
    //  return 3;

    return 4;
  }
}
