class Button extends Rectangle {
  private String label;
  
  Button (String lbl,float x, float y, float w, float h){
   super(x,y,w,h,0,0,0,200,0,0);// (100,0,0)=dark red , (0,0,0) = black
   label = lbl; 
  }
  
  void showButton(){
    createHiddenRect();//creates a rectangle with no fill
    fill(255);
    textAlign(CENTER,CENTER);
    textSize(50);
    text(label, x+w/2, y+h/2);
    
    if (isInside()){
      fill(255,246,0);
    text(label, x+w/2, y+h/2);
    }
  }
  
  boolean isClicked(){
    return (mouseX >= x && mouseX <= (x+w) && mouseY >= y & mouseY <= y+h && mousePressed == true);
  }
  
  boolean isInside(){//Checks to see if mouse x,y coordinates are within the button
    return (mouseX >= x && mouseX <= (x+w) && mouseY >= y & mouseY <= y+h);
  }
  
}
