/**
 * Author: Hamza and Safwan
 * Date: December 17, 2018
 * File Name: GreatEscape
 * Description: 
 **/
PImage imgR;
PImage imgL;
PImage jumpR;
PImage jumpL;
PImage[] playerImgR = new PImage[5];
PImage[] playerImgL = new PImage[5];

Player player;
float counter;

void setup() {
  size(1000, 800);
  background(0);
  imgR = loadImage("PlayerR.png");
  imgL = loadImage("PlayerL.png");
  jumpR = loadImage("JumpR.png");
  jumpL = loadImage("JumpL.png");


  for (int i = 1; i <= playerImgR.length; i++)
    playerImgR[i-1] = loadImage("Right" + i + ".png");

  for (int i = 1; i <= playerImgL.length; i++)
    playerImgL[i-1] = loadImage("Left" + i + ".png");

  player = new Player(0, height-50, 50, imgR); //(x,y,width,image)
  counter = 0;
}

void draw() {
  background(0);
  frameRate(60);
  player.update();

  if (player.xVelocity == 0 && !player.inAir) {
    player.img = imgR;
  } else if (player.xVelocity < 0 && !player.inAir) {
    if (counter >= 5)
      counter = 0;

    if (counter%1 == 0)
      player.img = playerImgL[(int)counter];

    counter = counter + 0.5;
  } else if (player.xVelocity > 0 && !player.inAir) {
    if (counter >= 5)
      counter = 0;

    if (counter%1 == 0)
      player.img = playerImgR[(int)counter];

    counter = counter + 0.5;
  }
}

void keyPressed() {
  if (keyCode == 'W') {
    while (player.inAir == false)
    {
      if (player.xVelocity > 0)
      {
        player.img = jumpR;
      } else if (player.xVelocity < 0)
      {
        player.img = jumpL;
      }
      player.inAir = true;
      player.setyVelocity(-30);
    }
  } else if (keyCode == 'D') {
    player.moving = true;
    player.setxVelocity(6);
  } else if (keyCode == 'A') {
    player.moving = true;
    player.setxVelocity(-6);
  }
}

void keyReleased() {
  if (keyCode == 'D') {
    player.img = imgR;
    player.setxVelocity(0);
    player.moving = false;
  } else if (keyCode == 'A') {
    player.img = imgL;
    player.setxVelocity(0);
    player.moving = false;
  }
}
