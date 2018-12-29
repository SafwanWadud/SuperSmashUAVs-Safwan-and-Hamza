/* Names: Safwan Wadud & Hamza Osman
 Course: ICS4U
 Date: Dec 27, 2018
 Brief Description: This program is the main class for a single player/ multiplayer game where the user(s) will control a character and attempt to reach the end of mazes while
 avoiding obstacles and enemies, in the least amount of time. Player scores are kept track of on a leader board.
 */

//Import Libraries
import ddf.minim.*;
import processing.sound.*;
import java.util.*;

//Declaring variables
Minim minim;//minim environment; credit: 
AudioPlayer menuBM, startBM;//background music
SoundFile sConfirm, sDeny, sStart;//sound effects
PImage background1, background2;//Background images
int screen;//variable to represent the different screens/menus
String [][] sbParts;//2d array to hold parts of the scoreboard (names and scores)
Button startB, scoreboardB, optionsB, creditsB, quitB, backB, yesB, noB;//buttons
Switch musicON, musicOFF, soundON, soundOFF;//switches
Rectangle strip;//white strip for menu design

void setup() {
  size(1000, 700);

  //Initializing variables
  screen = 1;//initialized to 1 representing the first screen (startscreen)
  sbParts = new String[2][50];

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
  scoreboardB = new Button("SCOREBOARD", 40, 50, height-300, textWidth("SCOREBOARD"), 40);
  optionsB = new Button("OPTIONS", 40, 50, height-250, textWidth("OPTIONS"), 40);
  creditsB = new Button("CREDITS", 40, 50, height-200, textWidth("CREDITS"), 40);
  quitB = new Button("QUIT", 40, 50, height-150, textWidth("QUIT"), 40);
  yesB = new Button("YES", 40, width/2-(textWidth("YES")/2), (height/2)+25, textWidth("YES"), 40 );
  noB = new Button("NO", 40, width/2-(textWidth("NO")/2), (height/2)+100, textWidth("NO"), 40 );
  textSize(30);
  backB = new Button("BACK", 30, 10, height-40, textWidth("BACK"), 30);

  //Switches
  musicON = new Switch("ON", true, 500, 230);
  musicOFF = new Switch("OFF", false, 560, 230);
  soundON = new Switch("ON", true, 500, 330);
  soundOFF = new Switch("OFF", false, 560, 330);

  strip = new Rectangle(0, 100, width, 3);

  //import all images
  background1 = loadImage("master-chief-halo-5-guardians-768x432.jpg"); //background for startscreen
  background1.resize(width, height);
  background2 = loadImage("b7f4b38132e6b9d8eba5af82c8156a98.jpg");//background for amin menu
  background2.resize(width, height);

  createScoreboard();//If there is no existing scoreboard, a new one is created
}

void draw() {
  switch (screen) {
  case 1://Start screen
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
  case 2://main menu screen
    startBM.rewind();
    startBM.pause();
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    mainMenu();
    if (scoreboardB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen =3;
      scoreboardB.setClick(false);
    } else if (optionsB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=4;
      optionsB.setClick(false);
    } else if (creditsB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=5;
      creditsB.setClick(false);
    } else if (quitB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen = 6;
      quitB.setClick(false);
    } else if (backB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=1;
      backB.setClick(false);
    }
    break;
  case 3://scoreboard screen
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    scoreboardMenu();
    if (backB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=2;
      backB.setClick(false);
    }
    break;
  case 4://options menu screen
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
  case 5://credits screen
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
  case 6:// quit screen
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
  else if (backB.isInside() && (screen ==2 || screen ==3 || screen == 4 || screen == 5))
    backB.setClick(true);
  else if (scoreboardB.isInside() && screen ==2)
    scoreboardB.setClick(true);
  else if (optionsB.isInside() && screen ==2)
    optionsB.setClick(true);
  else if (creditsB.isInside() && screen ==2)
    creditsB.setClick(true);
  else if (quitB.isInside() && screen ==2)
    quitB.setClick(true);
  else if (musicON.isInside() && screen==4) {
    musicON.setClick(true);
    musicON.setActive(true);
    musicOFF.setActive(false);
  } else if (musicOFF.isInside() && screen==4) {
    musicOFF.setClick(true);
    musicOFF.setActive(true);
    musicON.setActive(false);
  } else if (soundON.isInside() && screen==4) {
    soundON.setClick(true);
    soundON.setActive(true);
    soundOFF.setActive(false);
  } else if (soundOFF.isInside() && screen==4) {
    soundOFF.setActive(true);
    soundON.setActive(false);
  } else if (yesB.isInside() && screen==6)
    yesB.setClick(true);
  else if (noB.isInside() && screen==6)
    noB.setClick(true);
}

void createScoreboard() {
  try {//Tries to read from a file which checks to see if the file exists or not
    BufferedReader br = createReader("scoreboardGE.txt");
    br.close();
  }
  catch (Exception err) {//Creates new file and initializes all scores
    try {
      PrintWriter pw = createWriter("scoreboardGE.txt");//Creates new file called "scoreboardGE"

      for (int i = 0; i<50; i++) {
        pw.print(i+1);//prints rank to the file
        if (i+1 == 11 || i+1 == 12 || i+1 == 13) {//Prints sufixes for rank numbers 
          pw.print("th");
        } else if ((i+1)%10 == 1) {
          pw.print("st");
        } else if ((i+1)%10 == 2) {
          pw.print("nd");
        } else if ((i+1)%10 == 3) {
          pw.print("rd");
        } else {
          pw.print("th");
        }
        pw.println("                          XXX                          " + 0); //prints default names and score
      }
      pw.close();
    } 
    catch (Exception e) {
    }
  }
}

void readScoreboard() {
  try {
    BufferedReader br = createReader("scoreboardGE.txt");
    String line;

    for (int i = 0; i<sbParts[0].length; i++) { //Reads through the next 50 lines of the text file 
      line = trimLine(br.readLine());//reads text file and calls trimLine method
      sbParts[0][i] =  line.substring(0, line.indexOf('\t')); //holds player names extracted from text file
      sbParts[1][i] =  trimLine(line); //holds player scores extracted from text file
    }
    br.close();
  }
  catch (Exception e) {
  }
}

String trimLine (String l) {//String method to return the trimmed substring of a line which starts from the first tab   
  return l.substring(l.indexOf('\t')).trim();
}

void modScoreboard(String score) {
  Scanner sc = new Scanner(System.in);
  String cScore, sHolder1, sHolder2; //variables to hold current player's score, and 2 temp score holders 
  String cName, nHolder1, nHolder2; //variables to hold lines read from the text file, current player's name, and 2 temp name holders
  boolean nameValid = false, sPlaced = false;//variables to check if the user has entered a valid name, and to check if current player's score has been placed into the top 50

  cScore = score;

  for (int i = 0; i<sbParts[1].length; i++) {//Goes through the scoreboard to check if current player's score has made top 100
    if (Integer.parseInt(cScore)>Integer.parseInt(sbParts[1][i]) && !sPlaced) {//Modifies scoreboard if current player's score is greater than the score currently held AND player's score has not already been placed in a higher position 
      sPlaced = true;
      sHolder1 = cScore;//Sets 1st temp score holder equal to the player's current score
      println("Congratulations! Your score has made the top 50 \nEnter your initials (max 3 letters): ");

      do {//loops until user has entered a valid name
        cName = sc.nextLine().trim().toUpperCase();
        if (cName.length() == 0) {//Sets player's name to *** if they were to press enter without inputing a name
          cName = "***";
          nameValid = true;
        } else if (cName.length()<=3) {
          nameValid = true;
          for (int j = 0; j<cName.length(); j++) {//loops through a certain number of times depending on the length of the name (1,2, or 3)
            if (!(cName.charAt(j) >= 'A' && cName.charAt(j) <= 'Z')) {//Checks to see if all characters in the name are letters
              System.out.println("Invalid entry. Up to 3 letters between A-Z can only be used.");
              nameValid = false;
              break;//breaks from the for loop once there is a character that is not a letter
            }
          }
        } else {
          System.out.println("Invalid entry. Max 3 letters allowed");
        }
      } while (!nameValid);
      sc.close();
      nHolder1 = cName;//Sets 1st temp name holder equal to the player's current name

      for (int j = i; j<sbParts[1].length; j++) {//Goes through the scoreboard starting from the position the current player's score is to be held to the end of the array
        sHolder2 = sbParts[1][j];//Sets 2nd temp score holder equal to the value of the score array at index j
        sbParts[1][j] = sHolder1;//Sets the value of the score array at index j equal to the value currently held in the 1st temp score holder
        sHolder1 = sHolder2;//Sets the first temp score holder equal to the value of the value held in the 2nd temp score holder
        nHolder2 = sbParts[0][j];//Same process to modify the names as the scores
        sbParts[0][j] = nHolder1; 
        nHolder1 = nHolder2;
      }

      PrintWriter pw = createWriter("scoreboardGE.txt");
      for (int j = 0; j<sbParts[0].length; j++) {
        pw.print(j+1);//prints rank to the file
        if (j+1 == 11 || j+1 == 12 || j+1 == 13) {//Prints sufixes of rank numbers 
          pw.print("th");
        } else if ((j+1)%10 == 1) {
          pw.print("st");
        } else if ((j+1)%10 == 2) {
          pw.print("nd");
        } else if ((j+1)%10 == 3) {
          pw.print("rd");
        } else {
          pw.print("th");
        }
        pw.println("\t" + sbParts[0][j] + "\t" + sbParts[1][j]); //prints names and scores
      }
      pw.close();
    }
  }
}

void scoreboardMenu() {
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("SCOREBOARD", 225, 50);
  textSize(45);
  text("Rank                  Name                  Score", width/2, 150);
  textSize(40);
  try {
    BufferedReader br = createReader("scoreboardGE.txt");
    for (int i = 1; i<=10; i++) { //Reads through the first 10 lines of the text file
      text(br.readLine(), (width/2)+10, 180+(i*40));
    }
    br.close();
  }
  catch (Exception e) {
  }
  strip.colorRect1();
  backB.showButton();
}

void bubbleSort (String[][] list)//Need to make an array to hold ranks
{
  boolean sorted = false;
  for (int top = list[0].length-1; top > 0; top--)
  {
    sorted = true;
    for (int i = 0; i < top; i++)
    {
      if (list[0][i].compareTo(list[0][i+1]) > 0)
      {
        sorted = false;
        String temp = list[0][i];
        list[0][i] = list[0][i+1];
        list[0][i+1] = temp;
        
        String temp2 = list[1][i];
        list[1][i] = list[1][i+1];
        list[1][i+1] = temp2;
      }
    }
  }
}

void mainMenu() {
  image(background2, 0, 0);
  textSize(60);
  fill(255);
  text("MAIN MENU", 200, 50);
  strip.colorRect1();
  scoreboardB.showButton();
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
  image(background2, 0, 0);
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
  image(background2, 0, 0);
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
  image(background2, 0, 0);
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
