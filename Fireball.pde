//Name: Hamza Osman
//Brief Description: Blueprint for the fireball class
class Fireball extends UAV {

  Fireball(float x, float y, float w, float h, PImage img) {
    super(x, y, w, h, img);
    speed = 2;
  }

  void update() {
    x+=speed;
    if(x > width) {
    x = -w;
    speed = random(2,4);
    }
  }
}
