class Button extends Rectangle {
  String label;
  //hoverColor, textColor
  
  Button (String lbl,float x, float y, float w, float h){
   super(x,y,w,h,255,0,0,0,0,0);// (255,0,0)=red , (0,0,0) = black
   label = lbl; 
  }
  
  void showButton(){
    if (isInside()){
      
    }
    createRect();
    text(label,x,y);
  }
  
  boolean isInside(){//Checks to see if mouse x,y coordinates are within the button
    return (mouseX >= x && mouseX <= (x+w) && mouseY >= y & mouseY <= y+h);
  }
  
}
