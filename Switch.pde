//Blueprint for Switch class
class Switch extends Button {
  private boolean active; 

  Switch (String lbl, boolean active, float x, float y) {
    super(lbl, 20, x, y, 50, 50);
    this.active = active;
  }

  void setActive(boolean b) {
    active = b;
  }

  boolean getActive() {
    return active;
  }

  void showSwitch() {
    if (active) {
      setColor(255,255,255);
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
      setColor(255,246,0);
      colorRect2();
      fill(255, 246, 0);//changes color to yellow
      text(label, x+(w/2), y+(h/2)-5);
    }
  }
}
