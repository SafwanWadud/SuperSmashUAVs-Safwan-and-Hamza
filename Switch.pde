//Name: Safwan Wadud
//Brief Description: Blueprint for Switch class
class Switch extends Button {
  private boolean active;//determines if the switch is activated

  //Constructor Method that initialises fields of object
  //Pre: Assumes x,y,w,h are all float values
  //Post: none
  Switch (String lbl, boolean active, float x, float y, float w, float h) {
    super(lbl, 20, x, y, w, h);
    this.active = active;
  }

  //Procedure to change whats held inside the variable active
  //Pre: Assumes parameter is a boolean
  //Post: sets active equal to the value of the boolean variable passed on
  void setActive(boolean b) {
    active = b;
  }

  //Boolean function to return the value of the variable active
  //Pre: none
  //Post: returns a boolean
  boolean getActive() {
    return active;
  }

  //Procedure to display a switch
  //Pre: none
  //Post: creates and shows a switch
  void showSwitch() {
    if (active) {
      setColor(255, 255, 255);
      colorRect2();
      fill(255);
    } else {
      setColor(130, 130, 130);//grey color
      colorRect2();
      fill(130);
    }
    textAlign(CENTER, CENTER);
    textSize(txtSize);
    text(label, x+(w/2), y+(h/2)-5);

    if (isInside()) {
      setColor(255, 246, 0);
      colorRect2();
      fill(255, 246, 0);//changes color to yellow
      text(label, x+(w/2), y+(h/2)-5);
    }
  }
}
