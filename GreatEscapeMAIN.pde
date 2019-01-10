/**
 * Author: Hamza and Safwan
 * Date: December 17, 2018
 * File Name: GreatEscape
 * Description: 
 **/
PImage img;
PImage[] playerImg = new PImage[5];
Player player;
float counter;

void setup() {
  size(1000, 800);
  background(0);
  img = loadImage("Player.png");

  for (int i = 1; i <= playerImg.length; i++)
    playerImg[i-1] = loadImage("Right" + i + ".png");

  player = new Player(0, height-50, 50, img); //(x,y,width,image)
  counter = 0;
}

void draw() {
  background(0);
  frameRate(60);
  player.update();

  if (player.xVelocity < 0 && !player.inAir) {
    player.img = img;
  } else if (player.xVelocity > 0 && !player.inAir) {
    if (counter >= 5)
      counter = 0;

    if (counter%1 == 0)
      player.img = playerImg[(int)counter];

    counter = counter + 0.5;
  }
}

void keyPressed() {
  if (keyCode == 'W') {
    while (player.inAir == false)
    {
      player.img = img;
      player.inAir = true;
      player.setyVelocity(-30);
    }
  } else if (keyCode == 'D') {
    player.setxVelocity(6);
    player.moving = true;
  } else if (keyCode == 'A') {
    player.moving = true;
    player.setxVelocity(-6);
  }
}

void keyReleased() {
  if (keyCode == 'D') {
    player.img = img;
    player.setxVelocity(0);
    player.moving = false;
  } else if (keyCode == 'A') {
    player.img = img;
    player.setxVelocity(0);
    player.moving = false;
  }
}
