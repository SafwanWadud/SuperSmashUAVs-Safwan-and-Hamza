/* Names: Safwan Wadud & Hamza Osman
 Course: ICS4U
 Date: Jan 02, 2019
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
int screen, score, position, page=0;//variable to represent the different screens/menus; holds user's score; position on scoreboard when checking if user made top 50; represents the page on the scoreboard
String strScore, cName;//holds user score as a string; holds user's current name 
boolean played, tBoxClicked, nameEntered;//determines if the game was played once already;determines if a textbox was clicked on; determines if a name was entered
String [][] sbParts;//2d array to hold parts of the scoreboard (names and scores)
Button startB, playB, controlsB, scoreboardB, optionsB, creditsB, quitB, backB, yesB, noB, returnB, continueB, nextB, previousB;//buttons
Switch musicON, musicOFF, soundON, soundOFF, sortName, sortScore;//switches
Rectangle strip, textBox;//white strip for menu design; textBox to get user's name

void setup() {
  size(1000, 700);

  //Initializing variables
  screen = 1;//initialized to 1 representing the first screen (startscreen)
  sbParts = new String[3][50];

  //Music
  minim = new Minim(this);
  menuBM = minim.loadFile("1-03 Menu 1.mp3");
  startBM = minim.loadFile("Fortnite-Battle-Royale-OST-Season-2_64kbs.mp3");

  //Sound
  sConfirm = new SoundFile(this, "220168__gameaudio__button-spacey-confirm.mp3");
  sDeny = new SoundFile(this, "220167__gameaudio__button-deny-spacey.mp3");
  sStart = new SoundFile(this, "243020__plasterbrain__game-start.mp3");

  //Buttons
  textSize(50);
  playB = new Button("PLAY", 50, 50, 150, textWidth("PLAY"), 50);
  controlsB = new Button("HOW TO PLAY", 50, 50, 210, textWidth("HOW TO PLAY"), 50);
  scoreboardB = new Button("SCOREBOARD", 50, 50, 270, textWidth("SCOREBOARD"), 50);
  optionsB = new Button("OPTIONS", 50, 50, 330, textWidth("OPTIONS"), 50);
  creditsB = new Button("CREDITS", 50, 50, 390, textWidth("CREDITS"), 50);
  quitB = new Button("QUIT", 50, 50, 450, textWidth("QUIT"), 50);
  textSize(40);
  startB = new Button("START", 40, width/2-(textWidth("START")/2), height/2-20, textWidth("START"), 40);
  yesB = new Button("YES", 40, width/2-(textWidth("YES")/2), (height/2)+25, textWidth("YES"), 40 );
  noB = new Button("NO", 40, width/2-(textWidth("NO")/2), (height/2)+100, textWidth("NO"), 40 );
  continueB = new Button("CONTINUE", 40, width/2-(textWidth("CONTINUE")/2), height/2, textWidth("CONTINUE"), 40);
  textSize(30);
  backB = new Button("BACK", 30, 10, height-40, textWidth("BACK"), 30);
  returnB = new Button("RETURN TO MAIN MENU", 30, width/2-(textWidth("RETURN TO MAIN MENU")/2), (height/2)+100, textWidth("RETURN TO MAIN MENU"), 30);
  nextB = new Button("Next >>", 30, width-50-textWidth("Next >>"), height-120, textWidth("Next >>"), 30);
  previousB = new Button("<< Previous", 30, 50, height-120, textWidth("<< Previous"), 30);

  //Switches
  musicON = new Switch("ON", true, 500, 230, 50, 50);
  musicOFF = new Switch("OFF", false, 560, 230, 50, 50);
  soundON = new Switch("ON", true, 500, 330, 50, 50);
  soundOFF = new Switch("OFF", false, 560, 330, 50, 50);
  sortName = new Switch("NAME", false, 800, 120, 70, 30);
  sortScore = new Switch("SCORE", true, 880, 120, 70, 30);

  //Rectangles
  strip = new Rectangle(0, 100, width, 3);
  textBox = new Rectangle((width/2)-100, (height/2)-25, 200, 50);

  //import all images
  background1 = loadImage("master-chief-halo-5-guardians-768x432.jpg"); //background for startscreen
  background1.resize(width, height);//Changes size of image to fit the screen size
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
    if (playB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen = 3;
      playB.setClick(false);
    } else if (controlsB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen =4;
      controlsB.setClick(false);
    } else if (scoreboardB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen =5;
      scoreboardB.setClick(false);
    } else if (optionsB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=6;
      optionsB.setClick(false);
    } else if (creditsB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=7;
      creditsB.setClick(false);
    } else if (quitB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen = 8;
      quitB.setClick(false);
    } else if (backB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=1;
      backB.setClick(false);
    }
    break;
  case 3://play game screen
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    play();
    nameEntered = false;
    cName = "";
    if (continueB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      if (isScoreTop50())
        screen = 9;
      else
        screen = 2;
      continueB.setClick(false);
    }
    break;
  case 4:
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    howToPlay();
    if (backB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=2;
      backB.setClick(false);
    }
    break;
  case 5://scoreboard screen
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    scoreboardMenu(page);
    if (sortName.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      bubbleSort(sbParts);
      sortName.setClick(false);
    } 
    if (sortScore.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      selectSort(sbParts);
      sortScore.setClick(false);
    } 
    if (nextB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      page+=10;//Goes to next page, showing the next 10 scores
      nextB.setClick(false);
    }
    if (previousB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      page-=10;//Goes to previous page,showing the previous 10 scores
      previousB.setClick(false);
    }
    if (backB.getClick()) {
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=2;
      page =0;
      sortName.setActive(false);//Resets scoreboard to original order
      sortScore.setActive(true);
      selectSort(sbParts);
      backB.setClick(false);
    }
    break;
  case 6://options menu screen
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
  case 7://credits screen
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
  case 8:// quit screen
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
  case 9://update scoreboard menu
    promptUser();//gets user's name
    if (returnB.getClick()) {
      modScoreboard();//Updates the scoreboard
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=2;
      returnB.setClick(false);
    }
    played = false;
    break;
  }
}

void mousePressed() {
  if (startB.isInside() && screen==1)
    startB.setClick(true); 
  else if (backB.isInside() && (screen ==2 || screen == 4 || screen == 5 || screen == 6 || screen == 7))
    backB.setClick(true);
  else if (playB.isInside() && screen == 2)
    playB.setClick(true);
  else if (controlsB.isInside() && screen ==2)
    controlsB.setClick(true);
  else if (scoreboardB.isInside() && screen ==2)
    scoreboardB.setClick(true);
  else if (optionsB.isInside() && screen ==2)
    optionsB.setClick(true);
  else if (creditsB.isInside() && screen ==2)
    creditsB.setClick(true);
  else if (quitB.isInside() && screen ==2)
    quitB.setClick(true);
  else if (continueB.isInside() && screen ==3)
    continueB.setClick(true);
  else if (sortName.isInside() && screen==5) {
    sortName.setClick(true);
    sortName.setActive(true);
    sortScore.setActive(false);
  } else if (sortScore.isInside() && screen==5) {
    sortScore.setClick(true);
    sortScore.setActive(true);
    sortName.setActive(false);
  } else if (nextB.isInside() && screen ==5 && page<40)
    nextB.setClick(true);
  else if (previousB.isInside() && screen ==5 && page>0)
    previousB.setClick(true);
  else if (musicON.isInside() && screen==6) {
    musicON.setClick(true);
    musicON.setActive(true);
    musicOFF.setActive(false);
  } else if (musicOFF.isInside() && screen==6) {
    musicOFF.setClick(true);
    musicOFF.setActive(true);
    musicON.setActive(false);
  } else if (soundON.isInside() && screen==6) {
    soundON.setClick(true);
    soundON.setActive(true);
    soundOFF.setActive(false);
  } else if (soundOFF.isInside() && screen==6) {
    soundOFF.setActive(true);
    soundON.setActive(false);
  } else if (yesB.isInside() && screen==8)
    yesB.setClick(true);
  else if (noB.isInside() && screen==8)
    noB.setClick(true);
  else if (textBox.isInside() && screen == 9)
    tBoxClicked = true;
  else if (returnB.isInside() && screen == 9 && nameEntered)
    returnB.setClick(true);
}

void keyPressed() {
  if (screen==9 && tBoxClicked && !nameEntered) {
    if (key>='a'&&key<='z' && cName.length()<6) {
      cName = (cName+key).toUpperCase();
      ;
    } else if (key == BACKSPACE) {
      if (cName.length() > 0) {
        cName = cName.substring(0, cName.length()-1);
      }
    } else if (key==ENTER) {
      if (cName.length()<=6 && cName.length()>=1) {
        nameEntered = true;
      } else {
        cName = "";
      }
    }
  }
}

void scoreboardMenu(int page) {
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("SCOREBOARD", 225, 50);
  textSize(40);
  text("Rank", 100, 175);
  text("Name", width/2, 175);
  text("Score", width-100, 175);
  textSize(30);
  text("Sort by: ", 730, 130);
  for (int i = page; i<10+page; i++) { //Prints 10 scores depending on the page
    text(sbParts[0][i], 100, 225+((i%10)*35));//Prints the rank
    text(sbParts[1][i], width/2, 225+((i%10)*35));//Prints the name
    text(sbParts[2][i], width-100, 225+((i%10)*35));//Prints the score
  }
  strip.colorRect1();
  if (page<40)
    nextB.showButton();
  if (page>0)
    previousB.showButton();
  sortName.showSwitch();
  sortScore.showSwitch();
  backB.showButton();
}

void startScreen() {
  image(background1, 0, 0);
  fill(255);  
  textSize(60);
  text("CUE'S GREAT ESCAPE", width/2, 100);
  startB.showButton();
}

void mainMenu() {
  image(background2, 0, 0);
  textSize(60);
  fill(255);
  text("MAIN MENU", 200, 50);
  strip.colorRect1();
  playB.showButton();
  controlsB.showButton();
  scoreboardB.showButton();
  optionsB.showButton();
  creditsB.showButton();
  quitB.showButton();
  backB.showButton();
}

void play() {
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("PLAY", 100, 50);
  textSize(20);
  if (!played) {
    score = (int)(99999*Math.random()); //Temporary get a random score for the user
    strScore = String.valueOf(score);//converts to string
    played = true;
  }
  text("Your score is " + score, width/2, 200);
  strip.colorRect1();
  continueB.showButton();
}

void howToPlay() {
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("HOW TO PLAY", 230, 50);
  textSize(40);
  text("W", width/2-150, 200);
  text("A", width/2-150, 280);
  text("D", width/2-150, 360);
  text("SPACEBAR", width/2-150, 440);
  text("P", width/2-150, 520);
  text("Jump", width/2+150, 200);
  text("Move Right", width/2+150, 280);
  text("Move Left", width/2+150, 360);
  text("Shoot", width/2+150, 440);
  text("Pause", width/2+150, 520);
  strip.colorRect1();
  backB.showButton();
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

void promptUser() {
  background(0);
  fill(255);
  textBox.colorRect2();
  textSize(30);
  text("Congratulations! Your score has made the top 50 \nEnter your name (max 6 letters): ", width/2, height/3);
  fill(255, 255, 0);
  text(cName, width/2, (height/2)-5);
  if (nameEntered) {
    returnB.showButton();
  } else {
    fill(255);
    textSize(15);
    text("Press the \"ENTER\" key to confirm", width/2, (height/2)+50);
  }
}

boolean isScoreTop50() {
  boolean sPlaced = false;//variable to check if current player's score has been placed into the top 50
  for (int i = 0; i<sbParts[2].length; i++) {//Goes through the scoreboard to check if current player's score has made top 100
    if (Integer.parseInt(strScore)>Integer.parseInt(sbParts[2][i]) && !sPlaced) {//Modifies scoreboard if current player's score is greater than the score currently held AND player's score has not already been placed in a higher position 
      sPlaced = true;
      position = i;
    }
  }
  return sPlaced;
}

void modScoreboard() {
  String sHolder1, sHolder2, nHolder1, nHolder2; //2 temp name holders and 2 temp score holders

  sHolder1 = strScore;//Sets 1st temp score holder equal to the player's current score
  nHolder1 = cName;//Sets 1st temp name holder equal to the player's current name

  for (int i = position; i<sbParts[2].length; i++) {//Goes through the scoreboard starting from the position the current player's score is to be held to the end of the array
    sHolder2 = sbParts[2][i];//Sets 2nd temp score holder equal to the value of the score array at index j
    sbParts[2][i] = sHolder1;//Sets the value of the score array at index j equal to the value currently held in the 1st temp score holder
    sHolder1 = sHolder2;//Sets the first temp score holder equal to the value of the value held in the 2nd temp score holder
    nHolder2 = sbParts[1][i];//Same process to modify the names as the scores
    sbParts[1][i] = nHolder1; 
    nHolder1 = nHolder2;
  }

  try {
    PrintWriter pw = createWriter("scoreboardGE.txt");
    for (int i = 0; i<sbParts[1].length; i++) {
      pw.println(sbParts[0][i] + "                          " + sbParts[1][i] + "                          " + sbParts[2][i]); //prints ranks, names, and scores
    }
    pw.close();
  }
  catch (Exception e) {
  }
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
  try {
    BufferedReader br = createReader("scoreboardGE.txt");
    String line;

    for (int i = 0; i<sbParts[0].length; i++) { //Reads through the next 50 lines of the text file 
      line = br.readLine();
      sbParts[0][i] = line.substring(0, line.indexOf(' '));
      line = trimLine(line);
      sbParts[1][i] =  line.substring(0, line.indexOf(' ')); //holds player names extracted from text file
      sbParts[2][i] =  trimLine(line); //holds player scores extracted from text file
    }
    br.close();
  }
  catch (Exception e) {
  }
}

String trimLine (String l) {//String method to return the trimmed substring of a line which starts from the first tab   
  return l.substring(l.indexOf(' ')).trim();
}

void bubbleSort (String[][] list)//Sorts the scoreboard in alphabetical order
{
  for (int top = list[0].length-1; top > 0; top--)
  {
    for (int i = 0; i < top; i++)
    {
      if (list[1][i].compareTo(list[1][i+1]) > 0)
      {
        //Swap names
        String temp = list[1][i];
        list[1][i] = list[1][i+1];
        list[1][i+1] = temp;

        //Swap corresponding ranks
        String temp2 = list[0][i];
        list[0][i] = list[0][i+1];
        list[0][i+1] = temp2;

        //Swap corresponding scores
        String temp3 = list[2][i];
        list[2][i] = list[2][i+1];
        list[2][i+1] = temp3;
      }
    }
  }
}

void selectSort (String[][] list)
{
  for (int top = list[0].length - 1; top > 0; top--)
  {
    int largeLoc = 0; // location of largest element
    // assume list[0][0] is largest to start
    for (int i = 1; i <= top; i++) // check list[0][1] to list[0][top]
      if (Integer.parseInt(list[0][i].substring(0, (list[0][i].length()-2))) > Integer.parseInt(list[0][largeLoc].substring(0, (list[0][largeLoc].length()-2))))//Gets rid of the prefixes and compares the numbers
        largeLoc = i;

    //Swap ranks
    String temp = list[0][top]; // temporary storage
    list[0][top] = list[0][largeLoc];
    list[0][largeLoc] = temp;

    //Swap corresponding names
    String temp2 = list[1][top];
    list[1][top] = list[1][largeLoc];
    list[1][largeLoc] = temp2;

    //Swap corresponding scores
    String temp3 = list[2][top];
    list[2][top] = list[2][largeLoc];
    list[2][largeLoc] = temp3;
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
