class Button extends Rectangle {
  private String label;
  
  Button (String lbl,float x, float y, float w, float h){
   super(x,y,w,h,0,0,0,200,0,0);// (100,0,0)=dark red , (0,0,0) = black
   label = lbl; 
  }
  
  void showButton(){
    if (isInside()){
      r2 = 255;//CHanges to light red
    }
    createRect();
    fill(0);
    textSize(60);
    text(label, x+ w/3, y + w/3);
  }
  
  boolean isInside(){//Checks to see if mouse x,y coordinates are within the button
    return (mouseX >= x && mouseX <= (x+w) && mouseY >= y & mouseY <= y+h);
  }
  
}
