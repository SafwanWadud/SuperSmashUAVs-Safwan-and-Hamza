//Name: Safwan Wadud
//Brief Description: Blueprint for Button class
class Button extends Rectangle {
  protected String label;//text of button
  private boolean click;//determines if button was clicked
  protected float txtSize;//text size of label

  //Constructor Method that initialises fields of object
  //Pre: Assumes ts is a valid text size in processing
  //Post: none
  Button (String lbl, float ts, float x, float y, float w, float h) {
    super(x, y, w, h);
    label = lbl;
    txtSize = ts;
    click = false;
  }
  
  //String function to return the string representation of the object (the label of the button)
  //Pre: none
  //Post: returns a string 
  String toString() {
    return label;
  }
  
  //Procedure to display a button
  //Pre: none
  //Post: creates and shows a button
  void showButton() {
    textAlign(CENTER, CENTER);
    textSize(txtSize);
    if (!isInside()) {
      fill(0);
      text(this.toString(), x+(w/2)+2, y+(h/2)-2);//Creates a shadow for the text
      fill(255);
      text(this.toString(), x+(w/2), y+(h/2)-5);
    } else if (isInside()) {
      fill(0);
      text(this.toString(), x+(w/2)+2, y+(h/2)-5);
      fill(255, 246, 0);//changes text color to yellow
      text(this.toString(), x+(w/2), y+(h/2)-8);
    }
  }
  
  //Procedure to change whats held inside the variable click
  //Pre: Assumes parameter is a boolean
  //Post: sets click equal to the value of the boolean variable passed on
  void setClick(boolean b) {
    click = b;
  }
  
  //Boolean function to return the value of the variable click
  //Pre: none
  //Post: returns a boolean
  boolean getClick() {
    return click;
  }
}
