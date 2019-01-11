/* Names: Safwan Wadud & Hamza Osman
 Course: ICS4U
 Date: Jan 10, 2019
 Brief Description: This program is the main class for a single player/ multiplayer game where the user(s) will control a character and attempt to reach the end of mazes while
 avoiding obstacles and enemies, in the least amount of time. Player scores are kept track of on a leader board.
 */

PImage imgR; //Standard position facing right
PImage imgL; //Standard position facing left
PImage jumpR; //Jumping position facing right
PImage jumpL; //Jumping position facing left
PImage[] playerImgR = new PImage[5]; //Moving right array of images
PImage[] playerImgL = new PImage[5]; //Moving right array of images

Player player; //Player object
float counter;

void setup() {
  size(1000, 800);
  background(0);
  imgR = loadImage("PlayerR.png");
  imgL = loadImage("PlayerL.png");
  jumpR = loadImage("JumpR.png");
  jumpL = loadImage("JumpL.png");


  for (int i = 1; i <= playerImgR.length; i++)
    playerImgR[i-1] = loadImage("Right" + i + ".png"); //Initialise each index of array to an image

  for (int i = 1; i <= playerImgL.length; i++)
    playerImgL[i-1] = loadImage("Left" + i + ".png"); //Initialise each index of array to an image

  player = new Player(0, height-50, 50, imgR); //(x,y,width,image)
  counter = 0;
}

void draw() {
  background(0);
  frameRate(60);
  player.update();

  if (player.xVelocity < 0 && !player.inAir) {  //Moving left and not in the air
    if (counter >= 5)
      counter = 0;
    if (counter%1 == 0) //every increment of +1
      player.img = playerImgL[(int)counter]; //Alternate between each image in array every loop

    counter = counter + 0.5; //0.5 increment
  } else if (player.xVelocity > 0 && !player.inAir) { //Moving right and not in the air
    if (counter >= 5)
      counter = 0;
    if (counter%1 == 0)
      player.img = playerImgR[(int)counter]; //Alternate between each image in array every loop

    counter = counter + 0.5;
  } else if (player.right) { //Facing right
    if (player.inAir)
      player.img = jumpR; //jumping image
    else player.img = imgR; //If not in air display standing image
  } else if (player.right == false) { //Facing right
    if (player.inAir)
      player.img = jumpL; // jumping image
    else player.img = imgL; //standing image
  }
}

void keyPressed() {
  if (keyCode == 'W') {
    while (player.inAir == false)
    {
      player.inAir = true;
      player.setyVelocity(-30);
    }
  } else if (keyCode == 'D') {
    player.right = true; 
    player.moving = true;
    player.setxVelocity(6);
  } else if (keyCode == 'A') {
    player.right = false;
    player.moving = true;
    player.setxVelocity(-6);
  }
}

void keyReleased() {
  if (keyCode == 'D') {
    player.setxVelocity(0);
    player.moving = false;
  } else if (keyCode == 'A') {
    player.setxVelocity(0);
    player.moving = false;
  }
}
