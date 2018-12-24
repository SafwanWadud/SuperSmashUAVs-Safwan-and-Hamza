//Blueprint for Button class
class Button extends Rectangle {
  private String label;
  private boolean click;
  private float txtSize;

  Button (String lbl, float ts, float x, float y, float w, float h) {
    super(x, y, w, h);
    label = lbl;
    txtSize = ts;
  }

  void showButton() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(txtSize);
    text(label, x+(w/2), y+(h/2)-5);

    if (isInside()) {
      fill(255, 246, 0);//changes text color to yellow
      text(label, x+(w/2), y+(h/2)-5);
    }
  }

  void setClick(boolean b) {
    click = b;
  }

  boolean getClick() {
    return click;
  }

  boolean isInside() {//Checks to see if mouse x,y coordinates are within the button
    return (mouseX >= x && mouseX <= (x+w) && mouseY >= y & mouseY <= y+h);
  }
}
