/* Names: Safwan Wadud & Hamza Osman
 Course: ICS4U
 Date: Dec 25, 2018
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
Button startB, optionsB, creditsB, quitB, backB, yesB, noB;
Switch musicON, musicOFF, soundON, soundOFF;
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
  startB = new Button("START", 40, width/2-(textWidth("START")/2), height/2-20, textWidth("START"), 40);
  optionsB = new Button("OPTIONS", 40, 50, height-250, textWidth("OPTIONS"), 40);
  creditsB = new Button("CREDITS", 40, 50, height-200, textWidth("CREDITS"), 40);
  quitB = new Button("QUIT", 40, 50, height-150, textWidth("QUIT"), 40);
  yesB = new Button("YES", 40, width/2-(textWidth("YES")/2), (height/2)+25, textWidth("YES"), 40 );
  noB = new Button("NO", 40, width/2-(textWidth("NO")/2), (height/2)+100, textWidth("NO"), 40 );
  textSize(30);
  backB = new Button("BACK", 30, 10, height-40, textWidth("BACK"), 30);

  //Switches
  musicON = new Switch("ON", true, 500, 180);
  musicOFF = new Switch("OFF", false, 560, 180);
  soundON = new Switch("ON", true, 500, 280);
  soundOFF = new Switch("OFF", false, 560, 280);

  strip = new Rectangle(0, 100, width, 3);

  //import all images
  background1 = loadImage("master-chief-halo-5-guardians-768x432.jpg"); //background for startscreen
  background1.resize(width, height);
  background2 = loadImage("b7f4b38132e6b9d8eba5af82c8156a98.jpg");//background for amin menu
  background2.resize(width, height);
}

void draw() {
  switch (screen) {
  case 1:
    menuBM.rewind();
    if (!startBM.isPlaying()) {
      startBM.rewind();
    }
    if (musicON.getActive()) {
      startBM.play();
    }
    startScreen();
    if (startB.getClick()) {
      if (soundON.getActive()) {
        sStart.play();
      }
      screen=2;
      startB.setClick(false);
    }
    break;
  case 2:
    startBM.rewind();
    startBM.pause();
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    mainMenu();
    if (optionsB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=3;
      optionsB.setClick(false);
    } else if (creditsB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=4;
      creditsB.setClick(false);
    } else if (quitB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen = 5;
      quitB.setClick(false);
    } else if (backB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=1;
      backB.setClick(false);
    }
    break;
  case 3:
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    options();
    if (soundON.getClick()) {
      sConfirm.play();
      soundON.setClick(false);
    } 
    if (musicON.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      menuBM.play();
      musicON.setClick(false);
    } 
    if (musicOFF.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      menuBM.pause();
      musicOFF.setClick(false);
    } 
    if (backB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=2;
      backB.setClick(false);
    }
    break;
  case 4:
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    credits();
    if (backB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=2;
      backB.setClick(false);
    }
    break;
  case 5:
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    quitGame();
    if (yesB.getClick()) {
      exit();
    } else if (noB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen =2;
      noB.setClick(false);
    }
    break;
  }
}

void mousePressed() {
  if (startB.isInside() && screen==1)
    startB.setClick(true); 
  else if (backB.isInside() && (screen ==2 || screen ==3 || screen == 4))
    backB.setClick(true);
  else if (optionsB.isInside() && screen ==2)
    optionsB.setClick(true);
  else if (creditsB.isInside() && screen ==2)
    creditsB.setClick(true);
  else if (quitB.isInside() && screen ==2)
    quitB.setClick(true);
  else if (musicON.isInside() && screen==3) {
    musicON.setClick(true);
    musicON.setActive(true);
    musicOFF.setActive(false);
  } else if (musicOFF.isInside() && screen==3) {
    musicOFF.setClick(true);
    musicOFF.setActive(true);
    musicON.setActive(false);
  } else if (soundON.isInside() && screen==3) {
    soundON.setClick(true);
    soundON.setActive(true);
    soundOFF.setActive(false);
  } else if (soundOFF.isInside() && screen==3) {
    soundOFF.setActive(true);
    soundON.setActive(false);
  } else if (yesB.isInside() && screen==5)
    yesB.setClick(true);
  else if (noB.isInside() && screen==5)
    noB.setClick(true);
}

void mainMenu() {
  image(background2, 0, 0);
  textSize(60);
  fill(255);
  text("MAIN MENU", 200, 50);
  strip.colorRect1();
  optionsB.showButton();
  creditsB.showButton();
  quitB.showButton();
  backB.showButton();
}

void startScreen() {
  image(background1, 0, 0);
  fill(255);  
  textSize(60);
  text("CUE'S GREAT ESCAPE", width/2, 100);
  startB.showButton();
}

void options() {
  background(0);
  fill(255);
  textSize(60);
  text("OPTIONS", 150, 50);
  textSize(30);
  text("MUSIC:", width/2-textWidth("MUSIC"), height/2-100);
  text("SOUND:", width/2-textWidth("SOUND"), height/2);
  strip.colorRect1();
  musicON.showSwitch();
  musicOFF.showSwitch();
  soundON.showSwitch();
  soundOFF.showSwitch();
  backB.showButton();
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
  strip.colorRect1();
  backB.showButton();
}

void quitGame() {
  background(0);
  fill(255);
  textSize(60);
  text("QUIT GAME", 200, 50);
  textSize(20);
  text("Are you sure you want to quit the game?", width/2, height/2-50);
  strip.colorRect1();
  yesB.showButton();
  noB.showButton();
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
