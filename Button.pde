//Blueprint for Button class
class Button extends Rectangle {
  protected String label;
  private boolean click;
  protected float txtSize;

  Button (String lbl, float ts, float x, float y, float w, float h) {
    super(x, y, w, h);
    label = lbl;
    txtSize = ts;
    click = false;
  }

  void showButton() {
    textAlign(CENTER, CENTER);
    textSize(txtSize);
    if (!isInside()) {
      fill(0);
      text(label, x+(w/2)+2, y+(h/2)-2);//Creates a shadow for the text
      fill(255);
      text(label, x+(w/2), y+(h/2)-5);
    } else if (isInside()) {
      fill(0);
      text(label, x+(w/2)+2, y+(h/2)-5);
      fill(255, 246, 0);//changes text color to yellow
      text(label, x+(w/2), y+(h/2)-8);
    }
  }

  void setClick(boolean b) {
    click = b;
  }

  boolean getClick() {
    return click;
  }
}
