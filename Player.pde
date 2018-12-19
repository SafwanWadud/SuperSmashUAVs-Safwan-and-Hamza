class Player {
  PImage img;
  int x;
  int y;
  int w;

  Player(int x, int y, int w, PImage img) {
    // this template for the current Frog object
    this.img = img;
    this.x = x;
    this.y = y;
    this.w = w;
  }

  void show() {
    image(img, x, y, w, w);
  }

  void move(int xdir, int ydir) {
    x+= xdir;
    y+= ydir;
    
    if(x>(width-w)){
      x=width-w;
    }
    if(y>(height-w)){
      y=height-w;
    }
    if(x<0){
      x=0;
    }
    if(y<0){
      y=0;
    }
  }
}
