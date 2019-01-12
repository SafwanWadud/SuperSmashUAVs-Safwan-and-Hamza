/* Names: Safwan Wadud & Hamza Osman
 Course: ICS4U
 Date: Jan 11, 2019
 Brief Description: This program is the main class for a single player/ multiplayer game where the user(s) will control a character and attempt to reach the end of mazes while
 avoiding obstacles and enemies, in the least amount of time. Player scores are kept track of on a leader board.
 */

//Import Libraries
import ddf.minim.*;
import processing.sound.*;

//Declaring variables
PImage imgR; //Standard position facing right
PImage imgL; //Standard position facing left
PImage jumpR; //Jumping position facing right
PImage jumpL; //Jumping position facing left
PImage[] playerImgR = new PImage[5]; //Moving right array of images
PImage[] playerImgL = new PImage[5]; //Moving right array of images
Player player; //Player object
float counter;

Minim minim;//Minim object used to create background music; credit: http://code.compartmental.net/minim/audioplayer_class_audioplayer.html
AudioPlayer menuBM, startBM;//background music
SoundFile sConfirm, sDeny, sStart;//sound effects
PFont font;//text font
PImage background1, background2, mCursor1, mCursor2;//Background images; image for mouse cursors
int screen, score, position, page=0;//variable to represent the different screens/menus; holds user's score; position on scoreboard when checking if user made top 50; represents the page on the scoreboard
String strScore, cName, sName;//holds user score as a string; holds user's current name; hold's the name searched by the user in the scoreboard 
boolean played, nameEntered, isSearching, buttonClicked, searchClicked, tBoxClicked;//determines if the game was played once already; determines if a name was entered; determines if the user is searching for a name in the scoreboard
String [][] sbParts;//2d array to hold parts of the scoreboard (names and scores)
Button startB, playB, controlsB, scoreboardB, optionsB, creditsB, quitB, backB, yesB, noB, returnB, continueB, nextB, previousB;//buttons
Switch musicON, musicOFF, soundON, soundOFF, sortName, sortScore;//switches
Rectangle strip, textBox, searchBar;//white strip for menu design; textBox to get user's name; searchBar to get a name entered by user in scoreboard

void setup() {
  size(1000, 700);

  imgR = loadImage("PlayerR.png");
  imgL = loadImage("PlayerL.png");
  jumpR = loadImage("JumpR.png");
  jumpL = loadImage("JumpL.png");

  for (int i = 1; i <= playerImgR.length; i++)
    playerImgR[i-1] = loadImage("Right" + i + ".png"); //Initialise each index of array to an image

  for (int i = 1; i <= playerImgL.length; i++)
    playerImgL[i-1] = loadImage("Left" + i + ".png");  //Initialise each index of array to an image

  player = new Player(0, height-50, 50, imgR); //(x,y,width,image)
  counter = 0;

  //Initializing variables
  screen = 1;//initialized to 1 representing the first screen (startscreen)
  sbParts = new String[3][50];//3 representing the 3 columns: rank, name and score, and the 50 representing 50 scores

  //Music
  //Loads the audio files from the data folder
  minim = new Minim(this);
  menuBM = minim.loadFile("1-03 Menu 1.mp3");//Background music for the main menu
  startBM = minim.loadFile("Fortnite-Battle-Royale-OST-Season-2_64kbs.mp3");//Background music for the start screen

  //Sound
  //Loads the sound files from the data folder
  sConfirm = new SoundFile(this, "220168__gameaudio__button-spacey-confirm.mp3");//Sound effect when a button is pressed
  sDeny = new SoundFile(this, "220167__gameaudio__button-deny-spacey.mp3");
  sStart = new SoundFile(this, "243020__plasterbrain__game-start.mp3");//Sound effect when the start button is pressed

  //Font
  font = createFont("ssbFont.ttf", 32);
  textFont(font);

  //Buttons
  textSize(50);//size of button
  playB = new Button("PLAY", 50, 50, 150, textWidth("PLAY"), 50); //(text to be displayed, text size, x location, y location, width, height)
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
  musicON = new Switch("ON", true, 500, 230, 50, 50);//(text to be displayed, whether the switch is activated or not, x location, y location, width, height)
  musicOFF = new Switch("OFF", false, 554, 230, 50, 50);
  soundON = new Switch("ON", true, 500, 330, 50, 50);
  soundOFF = new Switch("OFF", false, 554, 330, 50, 50);
  sortName = new Switch("NAME", false, 820, 120, 70, 30);
  sortScore = new Switch("SCORE", true, 894, 120, 70, 30);

  //Rectangles
  strip = new Rectangle(0, 100, width, 3);//creates a thin white strip
  textBox = new Rectangle((width/2)-88, (height/2)-20, 195, 40);//creates a small rectangle with a white outline representing a text box
  searchBar = new Rectangle(280, 115, 195, 40);

  //import all images
  background1 = loadImage("master-chief-halo-5-guardians-768x432.jpg"); //background for startscreen
  background1.resize(width, height);//Changes size of image to fit the screen size
  background2 = loadImage("b7f4b38132e6b9d8eba5af82c8156a98.jpg");//background for main menu
  background2.resize(width, height);
  mCursor1 = loadImage("cursor1.png");
  mCursor2 = loadImage("cursor2.png");

  createScoreboard();//If there is no existing scoreboard, a new one is created
}

void draw() {
  if (buttonClicked) {
    frameRate(5);
    cursor(mCursor2);
    buttonClicked = false;
  } else {
    cursor(mCursor1);
    frameRate(60);
  }
  switch (screen) {
  case 1://Start screen
    menuBM.rewind();//rewinds the menu music
    if (!startBM.isPlaying()) {//if the start screen music is not playing, rewind it
      startBM.rewind();
    }
    if (musicON.getActive()) {//If the music on button is activated, play start screen music
      startBM.play();
    }
    startScreen();//Call startScreen() to show the start screen 
    if (startB.getClick()) {//If the start button is clicked
      if (soundON.getActive()) {//if the sound on button is activated, play the 'start' sound effect
        sStart.play();
      }
      screen=2;//set screen to 2 so that it can go to the main menu (case 2)
      startB.setClick(false);//resets the button's click to false
    }
    break;
  case 2://main menu screen
    startBM.rewind();//Rewinds the start screen music
    startBM.pause();//Stops the start screen music 
    if (!menuBM.isPlaying()) {//if the menu music is not playing, rewind it
      menuBM.rewind();
    }
    if (musicON.getActive()) {//If the music on button is activated, play menu music
      menuBM.play();
    }
    mainMenu();//Call mainMenu() to show the main menu 
    if (playB.getClick()) {//IF the play button gets clicked
      if (soundON.getActive()) {//If the sound on button is activated, play the 'confirm' sound effect
        sConfirm.play();
      }
      screen = 3;//set screen to 3 so that it can go to the play game screen (case 3)
      playB.setClick(false);
    } else if (controlsB.getClick()) {//controls button
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen =4;//sets screen to 4 to go to case 4 (how to play menu)
      controlsB.setClick(false);
    } else if (scoreboardB.getClick()) {//scoreboard button
      if (soundON.getActive()) {
        sConfirm.play();
      }
      sName = "";// initializes searched name
      screen =5;//sets screen to 5 (scoreboard menu)
      scoreboardB.setClick(false);
    } else if (optionsB.getClick()) {//options button
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=6;//sets screen to 6 (options menu)
      optionsB.setClick(false);
    } else if (creditsB.getClick()) {//credits button
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=7;//sets screen to 7 (credits screen)
      creditsB.setClick(false);
    } else if (quitB.getClick()) {//quit button
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen = 8;//sets screen to 8 (quit game menu)
      quitB.setClick(false);
    } else if (backB.getClick()) {//back button
      if (soundON.getActive()) {
        sDeny.play();//plays the 'deny' sound effect
      }
      screen=1;//sets screen to 1 to go back to the start screen
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
    break;

    //Leaderboard
   /*play();//calls play() to play the game
     nameEntered = false;//sets nameEntered to false
     cName = "";// initializes current user's name
     if (continueB.getClick()) {//if the continue button is clicked
     if (soundON.getActive()) {
     sConfirm.play();
     }
     if (isScoreTop50())//If current user's score is in the top 50, which is checked by calling isScoreTop50
     screen = 9;//set screen to 9 to go to the update scoreboard menu
     else
     screen = 2;//User did not make top 50 so sets screen to 2 to go back to the main menu
     continueB.setClick(false);
     }
     break;
     */
  case 4://How to play screen
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    howToPlay();//calls howToPlay() to show the controls screen
    if (backB.getClick()) {//goes back to main menu if back is clicked
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
    scoreboardMenu(page);//calls scoreboardMenu() to show the scoreboard and passes on page to let the program know which page of the scoreboard to show 
    if (sortName.getClick()) {//If the sort by name button is clicked
      if (soundON.getActive()) {
        sConfirm.play();
      }
      bubbleSort(sbParts);//sort the 2d array by name using bubble sort
      sortName.setClick(false);
    } 
    if (sortScore.getClick()) {//If the sort by score button is clicked 
      if (soundON.getActive()) {
        sConfirm.play();
      }
      selectSort(sbParts);//sort the 2d array by rank using selection sort
      sortScore.setClick(false);
    } 
    if (nextB.getClick()) {//If "next" button is clicked
      if (soundON.getActive()) {
        sConfirm.play();
      }
      page+=10;//Goes to next page, showing the next 10 scores
      nextB.setClick(false);
    }
    if (previousB.getClick()) {//If "previous" button is clicked
      if (soundON.getActive()) {
        sConfirm.play();
      }
      page-=10;//Goes to previous page,showing the previous 10 scores
      previousB.setClick(false);
    }
    if (backB.getClick()) {//If the back button is clicked
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=2;
      page =0;//sets page to 0, so scoreboard shows the first page
      sortName.setActive(false);//Resets scoreboard to original order (by rank)
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
    options();//calls options() to show the options menu
    if (soundON.getClick()) {// If the sound on button gets clicked, it is activated (see mousePressed method), which means that sound effects are on
      sConfirm.play();
      soundON.setClick(false);
    } 
    if (musicON.getClick()) {// if the music on button gets clicked, it is activated, which means that the music is turned on
      if (soundON.getActive()) {
        sConfirm.play();
      }
      menuBM.play();//Plays the menu music
      musicON.setClick(false);
    } 
    if (musicOFF.getClick()) {//If the music off button gets clicked, it is activated, which means that the music is turned off
      if (soundON.getActive()) {
        sConfirm.play();
      }
      menuBM.pause();//Stops the menu music
      musicOFF.setClick(false);
    } 
    if (backB.getClick()) {//goes back to main menu if back is clicked
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
    credits();//Calls credits() and shows the credits screen
    if (backB.getClick()) {//goes back to main menu if back is clicked
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=2;
      backB.setClick(false);
    }
    break;
  case 8://quit game screen
    if (!menuBM.isPlaying()) {
      menuBM.rewind();
    }
    if (musicON.getActive()) {
      menuBM.play();
    }
    quitGame();//Calls quitGame() and shows the quit menu
    if (yesB.getClick()) {//exits the program if yes is clicked
      exit();
    } else if (noB.getClick()) {//goes back to main menu if no is clicked
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen =2;
      noB.setClick(false);
    }
    break;
  case 9://update scoreboard menu
    promptUser();//gets user's name
    if (returnB.getClick()) {//If the "return to main menu" button is clicked
      modScoreboard();//Updates the scoreboard
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=2;//sets screen to 2 to go back to the main menu
      returnB.setClick(false);
    }
    played = false;//sets played to false
    break;
  }
}

void mousePressed() {//code to run if the mouse is pressed at specific locations and screens
  if (startB.isInside() && screen==1) {//If the mouse is within the start button and the screen is 1
    startB.setClick(true);//calls a mutator method to set its field, click, to true
    buttonClicked=true;
  } else if (backB.isInside() && (screen ==2 || screen == 4 || screen == 5 || screen == 6 || screen == 7)) {//if the mouse is within the back button and the screen is either 2,4,5,6, or 7
    backB.setClick(true);//set backB's click to true
    buttonClicked=true;
  } else if (playB.isInside() && screen == 2) {//if mouse is within play button and screen is 2
    playB.setClick(true);//set playB's click to true
    buttonClicked=true;
  } else if (controlsB.isInside() && screen ==2) {//if mouse is within controls button and screen is 2
    controlsB.setClick(true);
    buttonClicked=true;
  } else if (scoreboardB.isInside() && screen ==2) {//if mouse is within scoreboard button and screen is 2
    scoreboardB.setClick(true);
    buttonClicked=true;
  } else if (optionsB.isInside() && screen ==2) {//if mouse is within options button and screen is 2
    optionsB.setClick(true);
    buttonClicked=true;
  } else if (creditsB.isInside() && screen ==2) {//if mouse is within credits button and screen is 2
    creditsB.setClick(true);
    buttonClicked=true;
  } else if (quitB.isInside() && screen ==2) {//if mouse is within quit button and screen is 2
    quitB.setClick(true);
    buttonClicked=true;
  } else if (continueB.isInside() && screen ==3) {//if mouse is within continue button and screen is 3
    continueB.setClick(true);
    buttonClicked=true;
  } else if (sortName.isInside() && screen==5) {//if mouse is within sortName switch and screen is 5
    sortName.setClick(true);
    sortName.setActive(true);//Activates the sortName switch
    sortScore.setActive(false);//Deactivates the sortScore switch
    buttonClicked=true;
  } else if (sortScore.isInside() && screen==5) {//if mouse is within sortScore switch and screen is 5
    sortScore.setClick(true);
    sortScore.setActive(true);//Activates the sortScore switch
    sortName.setActive(false);//Deactivates the sortName switch
    buttonClicked=true;
  } else if (nextB.isInside() && screen ==5 && page<40 && !isSearching) {//if mouse is within next button and screen is 5 and it isn't the last page of the scoreboard and user is not searching a name in the scoreboard
    nextB.setClick(true);
    buttonClicked=true;
  } else if (previousB.isInside() && screen ==5 && page>0 && !isSearching) {//if mouse is within previous button and screen is 5 and it isn't the first page of the scoreboard and user is not searching a name in the scoreboard
    previousB.setClick(true);
    buttonClicked=true;
  } else if (musicON.isInside() && screen==6) {//if mouse is within musicON switch and screen is 6
    musicON.setClick(true);
    musicON.setActive(true);//Activates the musicON switch
    musicOFF.setActive(false);//Deactivates the musicOFF switch
    buttonClicked=true;
  } else if (musicOFF.isInside() && screen==6) {//if mouse is within musicOFF switch and screen is 6
    musicOFF.setClick(true);
    musicOFF.setActive(true);//Activates the musicOFF switch
    musicON.setActive(false);//Deactivates the musicON switch
    buttonClicked=true;
  } else if (soundON.isInside() && screen==6) {//if mouse is within soundON switch and screen is 6
    soundON.setClick(true);
    soundON.setActive(true);//Activates the soundON switch
    soundOFF.setActive(false);//Deactivates the soundOFF switch
    buttonClicked=true;
  } else if (soundOFF.isInside() && screen==6) {//if mouse is within soundOFF switch and screen is 6
    soundOFF.setActive(true);//Activates the soundOFF switch
    soundON.setActive(false);//Deactivates the soundON switch
    buttonClicked=true;
  } else if (yesB.isInside() && screen==8) {//if mouse is within yes button and screen is 8
    yesB.setClick(true);
    buttonClicked=true;
  } else if (noB.isInside() && screen==8) {//if mouse is within no button and screen is 8
    noB.setClick(true);
    buttonClicked=true;
  } else if (returnB.isInside() && screen == 9 && nameEntered) {//if mouse is within return button and screen is 9 and user has entered a name
    returnB.setClick(true);
    buttonClicked=true;
  }

  //checks to see if the search bar was clicked
  if (searchBar.isInside() && screen ==5) {
    searchBar.setColor(255, 246, 0);//if so, change outline to yellow
    searchClicked = true;//sets searchClicked to true
    buttonClicked = true;
  } else if (!searchBar.isInside() && screen == 5) {
    searchClicked = false;//sets searchClicked to false
    searchBar.setColor(255, 255, 255);//change colour back to white
  }

  //checks to see if textBox was clicked
  if (textBox.isInside() && screen == 9) {
    textBox.setColor(255, 246, 0);
    tBoxClicked = true;
    buttonClicked = true;
  } else if (!searchBar.isInside() && screen == 9) {
    tBoxClicked = false;
    textBox.setColor(255, 255, 255);
  }
}

void keyPressed() {//code to run if keys are pressed on a specific screen
  if (screen==9 && !nameEntered) {//If the screen is 9, and nameEntered is false 
    if (key>='a'&&key<='z' && cName.length()<6 && tBoxClicked) {//If a letter is pressed and the current user's name has less than 6 characters and the textBox was clicked
      cName = (cName+key).toUpperCase();//Adds the key to current user's name and changes it to upper case
    } else if (key == BACKSPACE) {//If backspace is pressed
      if (cName.length() > 0) {//If the current user's name contains 1 or more characters
        cName = cName.substring(0, cName.length()-1);//current user's name is set equal to the substring of itself minus the last character
      }
    } else if (key==ENTER) {//If the enter key is pressed
      if (cName.length()<=6 && cName.length()>=1) {//If the current user's name contains 1-6 characters
        nameEntered = true;//sets nameEntered to true
      } else {
        cName = "";//sets current user's name to null (empty string)
      }
    }
  } else if (screen==5 && searchClicked) {//If the screen is 5 and the search bar was clicked
    if (key>='a'&&key<='z' && sName.length()<6) {//If a letter is pressed and the searched name has less than 6 characters
      sName = (sName+key).toUpperCase();//Adds the key to searched name and changes it to upper case
    } else if (key == BACKSPACE) {//If backspace is pressed
      if (sName.length() > 0) {//If the searched name contains 1 or more characters
        sName = sName.substring(0, sName.length()-1);//searched name is set equal to the substring of itself minus the last character
      }
    }
  } else if (screen == 3)
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

//Displays the start screen when called upon
void startScreen() {
  image(background1, 0, 0);//draws the first image
  fill(255);//255 = white  
  textSize(60);//sets text size to 60
  text("CUE'S GREAT ESCAPE", width/2, 100);//draws text to screen at specified x and y locations
  startB.showButton();//Draw the start button
}

//Displays the main mennu screen 
void mainMenu() {
  image(background2, 0, 0);//Draws the second image
  textSize(60);
  fill(255);
  text("MAIN MENU", 200, 50);
  textSize(50);
  textAlign(LEFT);
  strip.colorRect1();//Draws a white rectangular strip near the top of the screen
  playB.showButton();//Draw 7 buttons 
  controlsB.showButton();
  scoreboardB.showButton();
  optionsB.showButton();
  creditsB.showButton();
  quitB.showButton();
  backB.showButton();
}

//Displays the play game screen
void play() {
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("PLAY", 100, 50);
  textSize(20);
  if (!played) {//If played is false
    score = (int)(99999*Math.random()); //Temporary get a random score for the user
    strScore = String.valueOf(score);//converts to string
    played = true;//set played to true
  }
  text("YOUR SCORE IS " + score, width/2, 200);//Let user know their score
  strip.colorRect1();
  continueB.showButton();//Draw continue button
}

//Displays the controls screen
void howToPlay() {
  background(0);
  tint(255, 100);//Makes background a bit darker
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
  text("JUMP", width/2+150, 200);
  text("MOVE RIGHT", width/2+150, 280);
  text("MOVE LEFT", width/2+150, 360);
  text("SHOOT", width/2+150, 440);
  text("PAUSE", width/2+150, 520);
  strip.colorRect1();
  backB.showButton();
}

//Displays the scoreboard
void scoreboardMenu(int page) {//takes in an int paramater which lets the program know which page of the scoreboard the method is to show
  background(0);
  tint(255, 100);
  image(background2, 0, 0);
  int searchPos;
  fill(255);
  textSize(60);
  text("SCOREBOARD", 225, 50);
  textSize(40);
  text("RANK", 100, 175);
  text("NAME", width/2, 175);
  text("SCORE", width-100, 175);
  textSize(30);
  text("SORT BY: ", 740, 130);
  text("SEARCH NAME: ", 158, 130); 
  searchBar.colorRect3();//Draws a small rectangle with a white stroke to represent a search bar
  fill(255, 255, 0);//yellow 
  textAlign(LEFT);
  text(sName, 285, 145);//Draws the searched name inside the text box as letters are pressed on the keyboard
  fill(255);
  textAlign(CENTER, CENTER);
  if (sName.length()>0) {//If the searched name contains atleast 1 character
    isSearching = true;
    searchPos = seqSearch(sbParts, sName); //sets search position to the value returned by the seqSearch method
    if (searchPos == -1) {//Indicates that the sequential search found no match
      text("NO MATCH FOUND", width/2, 225);//Prints the name
    }
  } else {//Draws the regular scoreboard
    isSearching = false;
    for (int i = page; i<10+page; i++) { //Prints 10 scores depending on the page
      text(sbParts[0][i], 100, 225+((i%10)*35));//Prints the rank
      text(sbParts[1][i], width/2, 225+((i%10)*35));//Prints the name
      text(sbParts[2][i], width-100, 225+((i%10)*35));//Prints the score
    }
  }
  strip.colorRect1();
  if (page<40 && !isSearching)//If page is less than 40 (not at the last page) and the user is not searching, draw the next button
    nextB.showButton();
  if (page>0 && !isSearching)//If page is greater than 0 (not at first page) and the user is not searching, draw the previous button
    previousB.showButton();
  sortName.showSwitch();//Draw the sortName switch
  sortScore.showSwitch();//Draw the sortScore switch
  backB.showButton();
}

//Displays the options menu
void options() {
  background(0);
  tint(255, 100);
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("OPTIONS", 150, 50);
  textSize(30);
  text("MUSIC:", width/2-textWidth("MUSIC"), height/2-100);
  text("SOUND:", width/2-textWidth("SOUND"), height/2);
  strip.colorRect1();
  musicON.showSwitch();//Draws 4 switches 
  musicOFF.showSwitch();
  soundON.showSwitch();
  soundOFF.showSwitch();
  backB.showButton();
}

//Displays the credits screen
void credits() {
  background(0);
  tint(255, 100);
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("CREDITS", 150, 50);
  textSize(20);
  text("MADE BY SAFWAN WADUD & HAMZA OSMAN", width/2, 200);
  text("ICS4U SUMMATIVE PROJECT", width/2, 250);
  text("JAN 21, 2019", width/2, 300);
  strip.colorRect1();
  backB.showButton();
}

//Displays the quit game menu
void quitGame() {
  background(0);
  tint(255, 100);
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("QUIT GAME", 200, 50);
  textSize(20);
  text("ARE YOU SURE YOU WANT TO QUIT THE GAME?", width/2, height/2-50);
  strip.colorRect1();
  yesB.showButton();//Draw the yes button
  noB.showButton();//Draw the no button
}

//Displays a post-game screen where if the current user made it to the top 50, a text box is drawn to get the user's name 
void promptUser() {
  background(0);
  textBox.colorRect3();//Draws a small rectangle with a white stroke to represent a text box
  textSize(30);
  fill(255);
  text("CONGRATULATIONS! YOUR SCORE HAS MADE THE TOP 50 \nENTER YOUR NAME (MAX 6 LETTERS): ", width/2, height/3);
  fill(255, 255, 0);//yellow 
  textAlign(LEFT);
  text(cName, 420, 362);//Draws the user's name inside the text box as letters are pressed on the keyboard
  textAlign(CENTER, CENTER);
  if (nameEntered) {//If the user has entered their name, a return button is drawn
    returnB.showButton();
  } else {//IF the user has not entered their name yet, the program draws text to let the user know to press enter to confirm their name
    fill(255);
    textSize(15);
    text("PRESS THE \"ENTER\" KEY TO CONFIRM", width/2, (height/2)+50);
  }
}

//Boolean method to return true if the current user's score is in the top 50, or false otherwise
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

//modifies the scoreboard given that the current user's score is in the top 50 and then updates the scoreboard
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

  try {//Prints the ranks, names, and scores to text file
    PrintWriter pw = createWriter("scoreboardGE.txt");
    for (int i = 0; i<sbParts[1].length; i++) {
      pw.println(sbParts[0][i] + "                          " + sbParts[1][i] + "                          " + sbParts[2][i]);
    }
    pw.close();
  }
  catch (Exception e) {
  }
}

//Creates a new scoreboard and prints it to a text file if there is no existing text file
void createScoreboard() {
  try {//Tries to read from a file which checks to see if the file already exists or not
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
      sbParts[0][i] = line.substring(0, line.indexOf(' '));//holds player ranks extracted from text file
      line = trimLine(line);
      sbParts[1][i] =  line.substring(0, line.indexOf(' ')); //holds player names
      sbParts[2][i] =  trimLine(line); //holds player scores
    }
    br.close();
  }
  catch (Exception e) {
  }
}

//String method to return the trimmed substring of a line which starts from the first tab   
String trimLine (String l) {
  return l.substring(l.indexOf(' ')).trim();
}

//Sorts the array, using the bubble sort algorithm, in alphebetical order and sorts the corresponding ranks and scores
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

//Sorts the array, using the selection sort algorithm, in order from highest rank to lowest rank and sorts the corresponding names and scores
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

//Searches for a name in the scoreboard specified by the user and shows corresponding rank and score
int seqSearch (String[][] list, String item)
{
  int location = -1;
  int row = 225;//holds y value to print out the row of text
  for (int i = 0; i < list[1].length; i++)
  {
    if (list[1][i].equals(item) && row<=540)//Checks to see if the value of list[1][i] is equal to item and that row is not greater than 540 so only the first ten results would show up
    {  
      location = i;
      text(sbParts[0][i], 100, row);//Prints the rank
      text(sbParts[1][i], width/2, row);//Prints the name
      text(sbParts[2][i], width-100, row);//Prints the score
      row+=35;//Increases row by 35 to prevent overlapping of scores
    }
  }
  return location;
}
