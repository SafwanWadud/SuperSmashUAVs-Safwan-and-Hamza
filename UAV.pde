//Name: Safwan
//Brief Description: Blueprint for the UAV class

class UAV extends Rectangle {
  private PImage img;
  private float speed;

  UAV(float x, float y, float w, float h, PImage img) {
    super(x, y, w, h);
    this.img = img;
    speed = -4;
  }

  void update() {
    x+=speed;
    if ((speed > 0 && x>=width-w)|| (speed <0 && x<=0) ) { 
      speed *=-1;
    }
  }
  
  boolean intersects(Object o){
   Rectangle b = (Rectangle)o;
   return (x+w>=b.x && x<=b.x+b.w && y+h>=b.y&& y<=b.y+b.h);
    
  }
  
  void show() {
    fill(255);
    colorRect1();
    image(img, x, y);
  }

  void setSpeed(float speed) 
  {
    this.speed = speed;
  }

  void setX(float x) {
    this.x=x;
  }

  float getSpeed() {
    return speed;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getW() {
    return w;
  }

  float getH() {
    return h;
  }
}
