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
  player = new Player(0, height-80, 80, playerImg);
}

void draw() {
  background(0);
  player.show();
  frameRate(60);
}

void keyPressed() {
  if (keyCode == UP) {
    player.move(0, -5);
  } else if (keyCode == DOWN) {
    player.move(0, 5);
  } else if (keyCode == RIGHT) {
    player.move(5, 0);
  } else if (keyCode == LEFT) {
    player.move(-5, 0);
  }
}
