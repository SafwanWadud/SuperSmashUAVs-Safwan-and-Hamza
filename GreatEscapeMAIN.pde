/* Names: Safwan Wadud & Hamza Osman
   Course: ICS4U
   Date: Dec 18, 2018
   Brief Description: This program is the main class for a single player/ multiplayer game where the user(s) will control a character and attempt to reach the end of mazes while
   avoiding obstacles and enemies, in the least amount of time. Player scores are kept track of on a leader board.
*/ 

//initialize variables

void setup(){
size(1000,800);
//import all images
}

int startScreen(){
 background(0); 
// fractal();
  int choice = 0; 
  if(mouseX>=25 && mouseX<=75 && mouseY>=25 && mouseX<=75 && mousePressed == true){
    fill(0);
    choice =1;
  }
  else{
  fill(255);
  }
  rect(25, 25, 50, 50); 
  
  return choice; 
}

void fractal(){
  //create fractal design
}

void draw(){
  startScreen();
  
}

/*   call mainmenu method
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
