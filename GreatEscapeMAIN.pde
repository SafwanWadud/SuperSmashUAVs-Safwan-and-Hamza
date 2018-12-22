/* Names: Safwan Wadud & Hamza Osman
 Course: ICS4U
 Date: Dec 22, 2018
 Brief Description: This program is the main class for a single player/ multiplayer game where the user(s) will control a character and attempt to reach the end of mazes while
 avoiding obstacles and enemies, in the least amount of time. Player scores are kept track of on a leader board.
 */

//initialize variables
PImage background1, background2;
int screen = 1;//variable to represent the different screens/menus; initialized to 1 representing the first screen (startscreen)
Button start, credits, backB1, backB2;

void setup() {
  size(1000, 600);
  start = new Button("START", 50, height-130, 180, 60);
  backB1 = new Button("BACK", -25, height-75, 180, 60);
  backB2 = new Button("BACK", -25, height-75, 180, 60);
  credits = new Button("CREDITS", 100, height-200, 180, 60);

  //import all images
  background1 = loadImage("master-chief-halo-5-guardians-768x432.jpg"); //background for startscreen
  background2 = loadImage("b7f4b38132e6b9d8eba5af82c8156a98.jpg");//background for amin menu
}

void startScreen() {
  background1.resize(width, height);
  image(background1, 0, 0); 
  start.showButton();
}

void credits() {
  background(0); 
  fill(255);
  textSize(60);
  text("CREDITS", 150, 50);
  Rectangle strip = new Rectangle(0, 100, width, 5);
  strip.colorRect();
  backB2.showButton();
}

void mainMenu() {
  background2.resize(width, height);
  image(background2, 0, 0);
  textSize(60);
  fill(255);
  text("MAIN MENU", 200, 50);
  Rectangle strip = new Rectangle(0, 100, width, 5);
  strip.colorRect();
  credits.showButton();
  backB1.showButton();
}

void mousePressed() {
  if (start.isInside() && screen ==1)
    start.setClick(true); 
  if (backB1.isInside() && screen ==2)
    backB1.setClick(true);
  if (backB2.isInside() && screen ==3)
    backB2.setClick(true);
  if (credits.isInside()&&screen ==2)
    credits.setClick(true);
}

void draw() {
  switch (screen) {
  case 1:
    startScreen();
    if (start.getClick()) {
      screen=2;
      start.setClick(false);
    }
    break;
  case 2:
    mainMenu();
    if (credits.getClick()) {
      screen=3;
      credits.setClick(false);
    }
    if (backB1.getClick()) {
      screen=1;
      backB1.setClick(false);
    }
    break;
  case 3:
    credits();
    if (backB2.getClick())
      screen=2;
    backB2.setClick(false);
    break;
  }
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
