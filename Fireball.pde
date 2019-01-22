//Name: Hamza Osman
//Brief Description: Blueprint for the fireball class
class Fireball extends UAV {

  //Constructor Method that initialises fields of object
  //Pre: none
  //Post: none
  Fireball(float x, float y, float w, float h, PImage img) {
    super(x, y, w, h, img);
    speed = 2;
  }

  /*Instance Method that updates the fireball speed, and x
   * Pre: None
   * Post: Changes the x location and speed
   */
  void update() {
    x+=speed;
    if (x > width) {
      x = -w;
      speed = random(2, 4);
    }
  }
}
