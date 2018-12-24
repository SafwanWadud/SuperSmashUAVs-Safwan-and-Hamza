/* Names: Safwan Wadud & Hamza Osman
 Course: ICS4U
 Date: Dec 24, 2018
 Brief Description: This program is the main class for a single player/ multiplayer game where the user(s) will control a character and attempt to reach the end of mazes while
 avoiding obstacles and enemies, in the least amount of time. Player scores are kept track of on a leader board.
 */

//Import Libraries
import ddf.minim.*;
import processing.sound.*;

//Declaring variables
Minim minim;//minim environment; credit: 
AudioPlayer menuBM, startBM;//background music
SoundFile sConfirm, sDeny, sStart;//sound effects
PImage background1, background2;//Background images
int screen;//variable to represent the different screens/menus
Button start, credits, quit, backB, yesQ, noQ;
Rectangle strip;

void setup() {
  size(1000, 600);

  //Initializing variables
  screen = 1;//initialized to 1 representing the first screen (startscreen)

  //Music
  minim = new Minim(this);
  menuBM = minim.loadFile("1-03 Menu 1.mp3");
  startBM = minim.loadFile("Fortnite-Battle-Royale-OST-Season-2_64kbs.mp3");

  //Sound
  sConfirm = new SoundFile(this, "220168__gameaudio__button-spacey-confirm.mp3");
  sDeny = new SoundFile(this, "220167__gameaudio__button-deny-spacey.mp3");
  sStart = new SoundFile(this, "243020__plasterbrain__game-start.mp3");

  //Buttons
  textSize(40);
  start = new Button("START", 40, width/2-(textWidth("START")/2), height/2-20, textWidth("START"), 40);
  credits = new Button("CREDITS", 40, 50, height-200, textWidth("CREDITS"), 40);
  quit = new Button("QUIT", 40, 50, height-150, textWidth("QUIT"), 40);
  yesQ = new Button("YES", 40, width/2-(textWidth("YES")/2), (height/2)+25, textWidth("YES"), 40 );
  noQ = new Button("NO", 40, width/2-(textWidth("NO")/2), (height/2)+100, textWidth("NO"), 40 );
  textSize(30);
  backB = new Button("BACK", 30, 10, height-40, textWidth("BACK"), 30);

  strip = new Rectangle(0, 100, width, 3);

  //import all images
  background1 = loadImage("master-chief-halo-5-guardians-768x432.jpg"); //background for startscreen
  background2 = loadImage("b7f4b38132e6b9d8eba5af82c8156a98.jpg");//background for amin menu
}

void draw() {
  switch (screen) {
  case 1:
    menuBM.rewind();
    if (startBM.isPlaying() == false) {
      startBM.rewind();
    }
    startBM.play();
    startScreen();
    if (start.getClick()) {
      sStart.play();
      screen=2;
      start.setClick(false);
    }
    break;
  case 2:
    startBM.rewind();
    startBM.pause();
    if (menuBM.isPlaying() == false) {
      menuBM.rewind();
    }
    menuBM.play();
    mainMenu();
    if (credits.getClick()) {
      sConfirm.play();
      screen=3;
      credits.setClick(false);
    } else if (quit.getClick()) {
      sConfirm.play();
      screen = 4;
      quit.setClick(false);
    } else if (backB.getClick()) {
      sDeny.play();
      screen=1;
      backB.setClick(false);
    }
    break;
  case 3:
    credits();
    if (backB.getClick()) {
      sDeny.play();
      screen=2;
      backB.setClick(false);
    }
    break;
  case 4:
    quitGame();
    if (yesQ.getClick()) {
      exit();
    } else if (noQ.getClick()) {
      sDeny.play();
      screen =2;
      noQ.setClick(false);
    }
    break;
  }
}

void mousePressed() {
  if (start.isInside() && screen==1)
    start.setClick(true); 
  else if (backB.isInside() && (screen ==2 || screen ==3))
    backB.setClick(true);
  else if (credits.isInside() && screen ==2)
    credits.setClick(true);
  else if (quit.isInside() && screen ==2)
    quit.setClick(true);
  else if (yesQ.isInside() && screen==4)
    yesQ.setClick(true);
  else if (noQ.isInside() && screen==4)
    noQ.setClick(true);
}

void mainMenu() {
  background2.resize(width, height);
  image(background2, 0, 0);
  textSize(60);
  fill(255);
  text("MAIN MENU", 200, 50);
  strip.colorRect();
  credits.showButton();
  quit.showButton();
  backB.showButton();
}



void startScreen() {
  background1.resize(width, height);
  image(background1, 0, 0);
  fill(255);  
  textSize(60);
  text("CUE'S GREAT ESCAPE", width/2, 100);
  start.showButton();
}

void credits() {
  background(0);
  fill(255);
  textSize(60);
  text("CREDITS", 150, 50);
  textSize(20);
  text("Made by Safwan Wadud & Hamza Osman", width/2, 200);
  text("ICS4U Summative Project", width/2, 250);
  text("Jan 21, 2019", width/2, 300);
  strip.colorRect();
  backB.showButton();
}

void quitGame() {
  background(0);
  fill(255);
  textSize(60);
  text("QUIT GAME", 200, 50);
  textSize(20);
  text("Are you sure you want to quit the game?", width/2, height/2-50);
  strip.colorRect();
  yesQ.showButton();
  noQ.showButton();
}

/*   call mainmenu method (USE SWITCH CASE)
 If user clicks on singleplayer 
 call singleplayer menu method
 depending on selection on menu, call either of the three level methods
 start timer
 if user presses a key to pause
 stop timer
 call pause method
 Check if user made top 50 
 if so, record score onto leaderboard
 If user clicks on multiplayer
 call multiplayer menu method
 depending on selection on menu, call either of the three level methods
 start timer
 if user presses a key to pause
 stop timer
 call pause method
 If user clicsk on tutorial
 call tutorial method
 If user clicks on leaderboards
 call leaderboards method
 IF user clicks on options
 call options method
 IF user clicks on credits
 call credits method
 if user clicks on quit game
 call quitgame method
 
 main menu method
 output background
 output text for the different choices
 if user clicks on an area within the box of text of an option
 The choice that was clicked on will become the choice of the user
 
 Singleplayer menu
 Create a player object
 output background
 output text for the different choices
 get level choice from user
 
 
 Multiplayer menu
 Create two player obects
 output background
 output text for the different choices
 get level choice from user 
 
 leaderboards method
 If there is no existing file to read, 
 create a file
 Else 
 read the textfile containing the leaderboards
 output the leaderboards
 If user clicks on the area within the "search" text box
 use the sequential search to find the specified player's score
 If user clicks on the area within the headers of the leaderboard
 use a sort to organize the leaderboard by that column
 
 options menu
 Output text for the different components
 music on/off
 game audio on/off
 show controls
 
 credits menu
 output text, showing the credits
 
 quit game menu
 IF user clicks on yes
 quit the game
 If user clicks on no,
 go back to main menu
 
 method to create level 1
 make 2d array for size of map
 create platforms/boarders
 create enemies
 
 method to create level 2
 make 2d array for size of map
 create platforms/boarders
 create enemies
 
 method to create level 3
 make 2d array for size of map
 create platforms/boarders
 create enemies
 
 pause method
 Output text for the different options
 If user selects return to main menu
 go back to main menu
 if user selects to restart
 restart level
 if user selects change level
 go back to multiplayer menu
 
 method for keypressed that calls the move method from character  
 keyPressed (W,A,S,D) for movement  
 keyPressed (space) reverse gravity
 */

/* Rectangle Class
 Constructor with length, width, x-coordinate, y-coordinate
 */

/*Character extends rectangle
 move method that is invoked by the keypressd method
 intersection method
 show method
 */

/*Player extends character
 show method
 move method
 shoot method
 die method
 */

/*Enemy extends character
 show method
 move method
 die method
 */

/*UAV extends enemies
 import uav image
 */
