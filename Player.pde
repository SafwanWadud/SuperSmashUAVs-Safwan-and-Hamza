//Name: Hamza Osman
//Brief Description: Blueprint for the player class

class Player extends Rectangle {
  PImage img; //Image this object displays
  boolean inAir; //Above ground boolean
  boolean moving; //moving left or Right
  boolean right; //Facing right
  private float gravity; //Gravity force on player
  private float yVelocity; //Vertical velocity of player
  private float xVelocity; //Horizontal velocity of player

  //Constructor Method that initialises fields of object
  //Pre: none
  //Post: none
  Player(float x, float y, float w, float h, PImage img) {
    super(x, y, w, h);
    this.img = img;
    inAir = false;
    gravity = 2.0;
    yVelocity = 0;
    xVelocity = 0;
    right = true;
  }

  /*Instance Method that updates the player on screen 
   * Pre: None
   * Post: Displays the character on screen
   */
  void update() {
    if (inAir) {
      yVelocity += gravity; //If above ground adds gravity to vertical speed
      y+= yVelocity; //Speed is added to the y value

      if (y >= height-h) { //Touching ground
        inAir = false;
        yVelocity = 0;
        y = height-h;
      }

      if (y < 0) { //Top of screen
        yVelocity = 0;
        y = 0;
      }
    } 

    if (moving) {
      x+= xVelocity;

      if (x>(width-w)) //Right side of screen
        x=width-w;

      if (x<0) //Left side of screen
        x=0;
    }
    image(img, x, y, w, h);
  }

  //Mutator method
  //Pre: none
  //Post: changes the value of the yVelocity
  void setyVelocity(float yVelocity) 
  {
    this.yVelocity = yVelocity;
  }


  //Mutator method
  //Pre: none
  //Post: changes the value of the xVelocity
  void setxVelocity(float xVelocity) 
  {
    this.xVelocity = xVelocity;
  }

  //Accessor method to access private xvelocity variable
  //Pre: none
  //Post: returns xVelocity
  float getxVelocity() {
    return xVelocity;
  }
}
