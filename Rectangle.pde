//Blueprint for rectangle class
class Rectangle {
  protected float x, y, w, h;//x and y coordinates of top left corner, width, and height of rectangle
  protected float r, g, b; //rgb colors for outline and fill of rectangle
  
  Rectangle(float x, float y, float w, float h, float r, float g, float b){ //Constructor
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  Rectangle(float x, float y, float w, float h){//Constructor
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    r = 255;
    g = 255;
    b = 255;
  }
  
  void invisibleRect(){
     noStroke();
     noFill();
     rect(x,y,w,h);
  }
  
  void colorRect() {
    fill(r, g, b);//color of shape
    rect(x,y,w,h);
  }
  
}
