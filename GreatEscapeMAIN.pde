/**
 * Author: Hamza and Safwan
 * Date: December 17, 2018
 * File Name: GreatEscape
 * Description: 
 **/
PImage playerImg;
Player player;

void setup() {
  size(1000, 800);

  playerImg = loadImage("Player.png");
  player = new Player(0, height-50, 50, playerImg); //(x,y,width,image)
}

void draw() {
  background(0);
  player.show();
  frameRate(120);

  if (player.inAir)
  {
    float y = player.getY();
    y += 5;
    player.setY(y);
  }
}

void keyPressed() {
  if (keyCode == UP) {
    if (player.inAir == false)
    player.jump(-200);
    player.inAir = true;
  } else if (keyCode == RIGHT) {
    player.move(20);
  } else if (keyCode == LEFT) {
    player.move(-20);
  }
}
