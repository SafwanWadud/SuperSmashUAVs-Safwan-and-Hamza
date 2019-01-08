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
  background(0);
  playerImg = loadImage("Player.png");
  player = new Player(0, height-50, 50, playerImg); //(x,y,width,image)
}

void draw() {
  background(0);
  frameRate(90);
  player.show();
  player.update();
}

void keyPressed() {
  if (keyCode == UP) {
    while (player.inAir == false)
    {
      player.inAir = true;
      player.jump(-20);
    }
  } else if (keyCode == RIGHT) {
    player.move(20);
  } else if (keyCode == LEFT) {
    player.move(-20);
  }
}
