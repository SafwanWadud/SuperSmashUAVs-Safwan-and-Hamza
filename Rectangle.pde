//Blueprint for rectangle class
class Rectangle {
  protected float x, y, w, h;//x and y coordinates of top left corner, width, and height of rectangle
  protected float r1, g1, b1, r2, g2, b2; //rgb colors for outline and fill of rectangle
  
  Rectangle(float x, float y, float w, float h, float r1, float g1, float b1, float r2,float g2, float b2){ //Constructor
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    r1 = random(0,255);
    g1 = random(0,255);
    b1 = random(0,255);
    r2 = random(0,255);
    g2 = random(0,255);
    b2 = random(0,255);
  }
  
  void createRect() {
    strokeWeight(2);//Line thickness
    stroke(r1, g1, b1); //color of outline
    fill(r2, g2, b2);//color of shape
    rect(x,y,w,h);
  }
  
}
