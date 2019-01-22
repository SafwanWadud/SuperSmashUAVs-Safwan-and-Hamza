/* Names: Safwan Wadud & Hamza Osman
 Course: ICS4U
 Date: Jan 21, 2019
 Brief Description: This program is the main class for a single player game where the user will control a character and attempt avoid obstacles and enemies, 
 for as long as they can. Player scores are kept track of on a leader board.
 */

//Import Libraries
import ddf.minim.*;//used for music
import processing.sound.*;//used for sound

//Declaring variables
PImage fire; //fire at bottom
PImage imgR; //Standard position facing right
PImage imgL; //Standard position facing left
PImage jumpR; //Jumping position facing right
PImage jumpL; //Jumping position facing left
PImage laserImg; //Laser image
PImage planeImg;// Plane image
PImage planeImg2;// Plane image
PImage fireballImg; //Fireball image
PImage[] playerImgR = new PImage[5]; //Moving right array of images
PImage[] playerImgL = new PImage[5]; //Moving right array of images
Player player; //Player object
float counter;
Laser[] lasers;
Rectangle[] platforms;
UAV[] uavs;
Fireball[] fireballs;
Timer timer;//timer object to hold game time

Minim minim;//Minim object used to create background music; credit: http://code.compartmental.net/minim/audioplayer_class_audioplayer.html
AudioPlayer menuBM, startBM, gameBM, deathBM;//background music
SoundFile sConfirm, sDeny, sStart, sLaser;//sound effects
PFont font;//text font
PImage[] cursors = new PImage[2];//images for mouse cursor
PImage background1, background2, pausedImage, gameStage;//Background images 
int screen, gameState; //represents the different screens/ game state(paused or unpaused)
int score, position, page, uavsDestroyed;//holds user's score; position on scoreboard when checking if user made top 50; represents the page on the scoreboard; holds number of uavs destroyed by the user
String strScore, cName, sName, sRank;//holds user score as a string; holds user's current name; hold's the name searched by the user in the scoreboard;hold's the rank searched by the user in the scoreboard  
boolean searchingName, searchingRank;//determines if the user is searching for a name or a rank in the scoreboard
boolean gameEnded, nameEntered, buttonClicked;//determines if the game has ended; determines if a name was entered; determines if any button/switch/textbox was clicked
boolean nSearchClicked, rSearchClicked; //determines if the user clicked on the name search bar/rank search bar
boolean tBoxClicked, imageNotTaken;//determines if the user clicked on the textBox in the prompt user screen; determines if a screenshot of the canvas was taken or not
String [][] sbParts;//2d array to hold parts of the scoreboard (names and scores)
Button startB, playB, howToPlayB, scoreboardB, optionsB, creditsB, extrasB, quitB, backB, yesB, noB, returnB, continueB, nextB, previousB, oneB, twoB, resumeB, controlsB, pOptionsB, pQuitB;//buttons
Switch musicON, musicOFF, soundON, soundOFF, sortName, sortScore;//switches
Rectangle strip, textBox, searchBar1, searchBar2;//white strip for menu design; textBox to get user's name; searchBar to get a name/rank entered by user in scoreboard
Recursion1 fractal1;//recursive fractal design
Recursion2 fractal2;

void setup() {
  size(1000, 700);//canvas size

  fire = loadImage("fire.png");//loading images
  imgR = loadImage("PlayerR.png");
  imgL = loadImage("PlayerL.png");
  jumpR = loadImage("JumpR.png");
  jumpL = loadImage("JumpL.png");
  laserImg = loadImage("LaserImg.png");
  planeImg = loadImage("plane.png");
  planeImg.resize(60, 30);//resizing width and height of images
  planeImg2 = loadImage("plane2.png");
  planeImg2.resize(60, 30);
  fireballImg = loadImage("fireball.png");
  fireballImg.resize(60, 30);

  //Megaman images taken https://www.deviantart.com/lucarioshirona/art/Megaman-Custom-sprites-Updated-377683787 and http://carbon-fighters.wikia.com/wiki/File:Megaman_Sprite_Sheet.png
  for (int i = 1; i <= playerImgR.length; i++)
    playerImgR[i-1] = loadImage("Right" + i + ".png"); //Initialise each index of array to an image

  for (int i = 1; i <= playerImgL.length; i++)
    playerImgL[i-1] = loadImage("Left" + i + ".png");  //Initialise each index of array to an image

  timer = new Timer();//Creates new timer object
  initializeGame();//calls on method to initialize the variables/arrays for the game

  screen = 1;//initialized to 1 representing the first screen (startscreen)
  page = 0;//initialized to 0 to represent the first page of the scoreboard
  gameState = 1;//initialized to 1 to represent the first game state (runs the game);
  sbParts = new String[3][50];//3 representing the 3 columns: rank, name and score, and the 50 representing 50 scores

  //Music
  //Loads the audio files from the data folder
  minim = new Minim(this);
  menuBM = minim.loadFile("1-03 Menu 1.mp3");//Background music for the main menu
  startBM = minim.loadFile("Fortnite-Battle-Royale-OST-Season-2_64kbs.mp3");//Background music for the start screen
  gameBM = minim.loadFile("FinalDestination.mp3");//Background music for the game
  deathBM = minim.loadFile("deathBM.mp3");//Background music for the death 


  //Sound
  //Loads the sound files from the data folder
  sConfirm = new SoundFile(this, "220168__gameaudio__button-spacey-confirm.mp3");//Sound effect when a button is pressed
  sDeny = new SoundFile(this, "220167__gameaudio__button-deny-spacey.mp3");
  sStart = new SoundFile(this, "243020__plasterbrain__game-start.mp3");//Sound effect when the start button is pressed
  sLaser = new SoundFile(this, "laser.mp3");//Sound effect when a laser is shot

  //Font
  font = createFont("ssbFont.ttf", 32);
  textFont(font);

  //Buttons
  textSize(50);//size of button
  playB = new Button("PLAY", 50, 50, 150, textWidth("PLAY"), 50); //(text to be displayed, text size, x location, y location, width, height)
  howToPlayB = new Button("HOW TO PLAY", 50, 50, 210, textWidth("HOW TO PLAY"), 50);
  scoreboardB = new Button("SCOREBOARD", 50, 50, 270, textWidth("SCOREBOARD"), 50);
  optionsB = new Button("OPTIONS", 50, 50, 330, textWidth("OPTIONS"), 50);
  creditsB = new Button("CREDITS", 50, 50, 390, textWidth("CREDITS"), 50);
  extrasB = new Button("EXTRAS", 50, 50, 450, textWidth("EXTRAS"), 50);
  quitB = new Button("QUIT GAME", 50, 50, 510, textWidth("QUIT GAME"), 50);
  textSize(40);
  startB = new Button("START", 40, width/2-(textWidth("START")/2), height/2-20, textWidth("START"), 40);
  yesB = new Button("YES", 40, width/2-(textWidth("YES")/2), (height/2)+25, textWidth("YES"), 40 );
  noB = new Button("NO", 40, width/2-(textWidth("NO")/2), (height/2)+100, textWidth("NO"), 40 );
  continueB = new Button("CONTINUE", 40, width/2-(textWidth("CONTINUE")/2), height/2+100, textWidth("CONTINUE"), 40);
  oneB = new Button("ONE", 40, width/2-(textWidth("ONE")/2), (height/2)+25, textWidth("ONE"), 40 );
  twoB = new Button("TWO", 40, width/2-(textWidth("TWO")/2), (height/2)+100, textWidth("TWO"), 40 );
  resumeB = new Button("RESUME", 40, width/2-(textWidth("RESUME")/2), (height/2)-100, textWidth("RESUME"), 40 );
  controlsB = new Button("CONTROLS", 40, width/2-(textWidth("CONTROLS")/2), (height/2)-25, textWidth("CONTROLS"), 40 );
  pOptionsB = new Button("OPTIONS", 40, width/2-(textWidth("OPTIONS")/2), (height/2)+50, textWidth("OPTIONS"), 40 );
  pQuitB = new Button("QUIT", 40, width/2-(textWidth("QUIT")/2), (height/2)+125, textWidth("QUIT"), 40 );
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
  searchBar1 = new Rectangle(517, 117, 140, 30);//Creates a rectangle with a white outline and grey fill to represent searchbars
  searchBar2 = new Rectangle(222, 117, 65, 30);

  //Recursion
  fractal1 = new Recursion1();
  fractal2 = new Recursion2();

  //import images
  background1 = loadImage("MegamanSSB.jpg"); //background for startscreen
  background1.resize(width, height);//Changes size of image to fit the screen size
  background2 = loadImage("MasterChiefBlue.jpg");//background for main menu
  background2.resize(width, height);
  gameStage = loadImage("stage.png");//background for game
  gameStage.resize(width, height);
  cursors[0] = loadImage("cursor1.png");//images for cursor
  cursors[0].resize(32, 32);
  cursors[1] = loadImage("cursor2.png");
  cursors[1].resize(32, 32);

  createScoreboard();//If there is no existing scoreboard, a new one is created
}

//Procedure to initialize all variables/arrays/objects used for the game 
void initializeGame() {
  score =0;
  uavsDestroyed=0;

  lasers = new Laser[4];
  for (int i=0; i<lasers.length; i++) 
    lasers[i]= new Laser(laserImg); //Initilise the laser array

  uavs = new UAV[30];  
  for (int i=0; i<uavs.length; i+=3) {
    uavs[i]= new UAV(width+(i*1000), 370, 50, 40, planeImg); //Initilise the uav array
    uavs[i+1]= new UAV(width+(i*1000), 230, 50, 40, planeImg);
    uavs[i+2]= new UAV(width+(i*1000), 80, 50, 40, planeImg);
  }

  fireballs = new Fireball[3];
  fireballs[0]= new Fireball(0, 370, 50, 40, fireballImg); //Initilise the fireball array
  fireballs[1]= new Fireball(0-600, 230, 50, 40, fireballImg);
  fireballs[2]= new Fireball(0-200, 80, 50, 40, fireballImg);

  platforms = new Rectangle[4];
  platforms[0] = new Rectangle(185, 428, 615, 25);//Initilise the platform array
  platforms[1] = new Rectangle(235, 283, 170, 15);
  platforms[2] = new Rectangle(582, 283, 170, 15);
  platforms[3] = new Rectangle(414, 141, 158, 25);

  player = new Player(platforms[0].x + platforms[0].w/2-25, platforms[0].y - 50, 50, 50, imgR); //(x,y,width,height,image)
}

//Procedure to play the music passed on as a parameter
void playMusic (AudioPlayer m) {
  if (!m.isPlaying()) {//if the music is not playing, rewind it
    m.rewind();
  }
  if (musicON.getActive()) {//If the music on button is activated, play the music
    m.play();
  }
}

void draw() {
  if (buttonClicked) {//Drops the framerate to show second mouse cursor when the mouse clicks on something
    frameRate(5);
    cursor(cursors[1], 0, 0);
    buttonClicked = false;
  } else {//show the first mouse cursor and put the framerate back to 60
    cursor(cursors[0], 0, 0);
    frameRate(60);
  }
  switch (screen) {
  case 1://Start screen
    menuBM.rewind();//rewinds the menu music
    playMusic(startBM);//plays start screen music
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
    gameBM.rewind();//Rewinds the game music
    gameBM.pause();//Stops the game music 
    deathBM.rewind(); //Rewinds the death music
    deathBM.pause(); //Stops the death music 
    playMusic(menuBM);//plays the menu music
    mainMenu();//Call mainMenu() to show the main menu 
    if (playB.getClick()) {//IF the play button gets clicked
      if (soundON.getActive()) {//If the sound on button is activated, play the 'confirm' sound effect
        sConfirm.play();
      }
      screen = 3;//set screen to 3 so that it can go to the play game screen (case 3)
      gameEnded =false;//sets game ended to false before starting the game
      playB.setClick(false);
    } else if (howToPlayB.getClick()) {//howToPlay button
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen =4;//sets screen to 4 to go to case 4 (how to play menu)
      howToPlayB.setClick(false);
    } else if (scoreboardB.getClick()) {//scoreboard button
      if (soundON.getActive()) {
        sConfirm.play();
      }
      sName = "";// initializes searched name
      sRank = "";// initializes the searched rank
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
    } else if (extrasB.getClick()) {//extras button
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=10;//sets screen to 10 (extras menu screen)
      extrasB.setClick(false);
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
    menuBM.rewind();//Rewinds the menu music
    menuBM.pause();//Stops the menu music 
    playMusic(gameBM);//plays the background music for the game
    switch (gameState) {
    case 1: //runs the game
      playGame();//calls method playGame to play the game
      break;
    case 2://pause state
      if (imageNotTaken) {//If an image of the current screen was not taken yet
        pausedImage = get(); //Take a screenshot of the canvas and set it to pausedImage
        imageNotTaken = false;
      }
      pauseMenu();//Shows pause menu
      if (resumeB.getClick()) {//resume button
        if (soundON.getActive()) {
          sConfirm.play();
        }
        gameState = 1;//sets game state to 1 (returns to game)
        resumeB.setClick(false);
      } else if (controlsB.getClick()) {//controls button
        if (soundON.getActive()) {
          sConfirm.play();
        }
        screen=4;//sets screen to 4 (controls screen)
        controlsB.setClick(false);
      } else if (pOptionsB.getClick()) {//options button
        if (soundON.getActive()) {
          sConfirm.play();
        }
        screen=6;//sets screen to 6 (options screen)
        pOptionsB.setClick(false);
      } else if (pQuitB.getClick()) {//quit button
        if (soundON.getActive()) {
          sConfirm.play();
        }
        screen=2;//sets screen to 2 (main menu screen)
        initializeGame();//resets all data for the game
        gameState=1;
        pQuitB.setClick(false);
      }
      break;
    }
    break;
  case 4://How to play screen
    if (gameBM.isPlaying())
      gameBM.pause();//Stops the game music 
    playMusic(menuBM);//plays menu music
    howToPlay();//calls howToPlay() to show the controls screen
    if (backB.getClick()) {//goes back to main menu if back is clicked
      if (soundON.getActive()) {
        sDeny.play();
      }
      if (gameState == 2) {//goes back to pause menu
        screen =3;
        if (musicON.getActive())
          gameBM.play();
      } else
        screen=2;//goes back to main menu
      backB.setClick(false);
    }
    break;
  case 5://scoreboard screen
    playMusic(menuBM);
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
    if (gameBM.isPlaying())
      gameBM.pause();//Stops the game music 
    playMusic(menuBM);//plays menu music
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
      if (gameState ==2) {//Goes back to pause menu
        screen =3;
        if (musicON.getActive())
          gameBM.play();
      } else
        screen=2;//goes back to main menu
      backB.setClick(false);
    }
    break;
  case 7://credits screen
    playMusic(menuBM);//plays menu music
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
    playMusic(menuBM);//plays menu music
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
    playMusic(deathBM);//plays menu music
    promptUser();//gets user's name
    if (returnB.getClick()) {//If the "return to main menu" button is clicked
      modScoreboard();//Updates the scoreboard
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen=2;//sets screen to 2 to go back to the main menu
      initializeGame();
      returnB.setClick(false);
    }
    break;
  case 10://extras menu
    playMusic(menuBM);//plays menu music
    extrasMenu();//Calls extrasMenu() and shows the extras menu
    if (oneB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen = 11;//goes to screen 11 to show recursive design 1
      oneB.setClick(false);
    } else if (twoB.getClick()) {
      if (soundON.getActive()) {
        sConfirm.play();
      }
      screen = 12;//goes to screen 12 to show recursive design 2
      twoB.setClick(false);
    } else if (backB.getClick()) {//goes back to main menu if back is clicked
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=2;
      backB.setClick(false);
    }
    break;
  case 11://recursive design 1
    playMusic(menuBM);//plays menu music
    fractal1.showFractal();
    backB.showButton();
    if (backB.getClick()) {//goes back to main menu if back is clicked
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=10;
      backB.setClick(false);
    }
    break;
  case 12://recursive design 2
    playMusic(menuBM);//plays menu music
    fractal2.showFractal();
    backB.showButton();
    if (backB.getClick()) {//goes back to main menu if back is clicked
      if (soundON.getActive()) {
        sDeny.play();
      }
      screen=10;
      backB.setClick(false);
    }
    break;
  case 13://post game screen
    gameBM.rewind();//Rewinds the game music
    gameBM.pause();//Stops the game music 
    playMusic(deathBM);//plays menu music
    gameOver();//calls method gameOver to show post game results
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
      initializeGame();
      continueB.setClick(false);
    }
    break;
  }
}

void mousePressed() {//code to run if the mouse is pressed at specific locations and screens
  if (startB.isInside() && screen==1) {//If the mouse is within the start button and the screen is 1
    startB.setClick(true);//calls a mutator method to set its field, click, to true
    buttonClicked=true;
  } else if (backB.isInside() && (screen ==2 || screen == 4 || screen == 5 || screen == 6 || screen == 7 || screen == 10 || screen == 11 || screen == 12)) {//if the mouse is within the back button and the screen is either 2,4,5,6,7,10,11 or 12
    backB.setClick(true);//set backB's click to true
    buttonClicked=true;
  } else if (playB.isInside() && screen == 2) {//if mouse is within play button and screen is 2
    playB.setClick(true);//set playB's click to true
    buttonClicked=true;
    //resets timer
    timer.timeElapsed=millis();
    timer.pausedTime = 0;
    timer.notPaused=true;
  } else if (howToPlayB.isInside() && screen ==2) {//if mouse is within controls button and screen is 2
    howToPlayB.setClick(true);
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
  } else if (extrasB.isInside() && screen ==2) {//if mouse is within extras button and screen is 2
    extrasB.setClick(true);
    buttonClicked=true;
  } else if (quitB.isInside() && screen ==2) {//if mouse is within quit button and screen is 2
    quitB.setClick(true);
    buttonClicked=true;
  } else if (continueB.isInside() && screen ==13) {//if mouse is within continue button and screen is 3
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
  } else if (nextB.isInside() && screen ==5 && page<40 && !searchingName && !searchingRank) {//if mouse is within next button and screen is 5 and it isn't the last page of the scoreboard and user is not searching a name/rank in the scoreboard
    nextB.setClick(true);
    buttonClicked=true;
  } else if (previousB.isInside() && screen ==5 && page>0 && !searchingName && !searchingRank) {//if mouse is within previous button and screen is 5 and it isn't the first page of the scoreboard and user is not searching a name/rank in the scoreboard
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
  } else if (oneB.isInside() && screen == 10) {//If mouse is within one button and screen is 10
    oneB.setClick(true);
    buttonClicked = true;
  } else if (twoB.isInside() && screen == 10) {//If mouse is within two button and screen is 10
    twoB.setClick(true);
    buttonClicked = true;
  } else if (resumeB.isInside() && gameState == 2 && screen==3) {//If mouse within resume button and game is paused and screen is 3 
    resumeB.setClick(true);
    buttonClicked = true;
    //resumes the timer
    if (!timer.notPaused) {
      timer.timeElapsed=millis();
      timer.notPaused = true;
    }
  } else if (controlsB.isInside() && gameState == 2 && screen==3) {//if mouse within controls button and game is paused and screen is 3
    controlsB.setClick(true);
    buttonClicked = true;
  } else if (pOptionsB.isInside() && gameState ==2 && screen==3) {//if mouse within options button and game is paused and screen is 3
    pOptionsB.setClick(true);
    buttonClicked = true;
  } else if (pQuitB.isInside() && gameState == 2  && screen==3) {//if mouse within quit button and game is paused and screen is 3
    pQuitB.setClick(true);
    buttonClicked = true;
  }

  //checks to see if the name search bar was clicked
  if (searchBar1.isInside() && screen ==5) {
    searchBar1.setColor(255, 246, 0);//if so, change outline to yellow
    nSearchClicked = true;//sets searchClicked to true
    buttonClicked = true;
  } else if (!searchBar1.isInside() && screen == 5) {
    nSearchClicked = false;//sets searchClicked to false
    searchBar1.setColor(255, 255, 255);//change colour back to white
  }

  //checks to see if the rank search bar was clicked
  if (searchBar2.isInside() && screen ==5) {
    searchBar2.setColor(255, 246, 0);//if so, change outline to yellow
    rSearchClicked = true;//sets searchClicked to true
    buttonClicked = true;
  } else if (!searchBar2.isInside() && screen == 5) {
    rSearchClicked = false;//sets searchClicked to false
    searchBar2.setColor(255, 255, 255);//change colour back to white
  }

  //checks to see if textBox was clicked
  if (textBox.isInside() && screen == 9) {
    textBox.setColor(255, 246, 0);
    tBoxClicked = true;
    buttonClicked = true;
  } else if (!textBox.isInside() && screen == 9) {
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
  } else if (screen==5) {//If the screen is 5
    if (nSearchClicked) {//If the name search bar was clicked
      if (key>='a'&&key<='z' && sName.length()<6) {//If a letter is pressed and the searched name has less than 6 characters
        sName = (sName+key).toUpperCase();//Adds the key to searched name and changes it to upper case
      } else if (key == BACKSPACE) {//If backspace is pressed
        if (sName.length() > 0) {//If the searched name contains 1 or more characters
          sName = sName.substring(0, sName.length()-1);//searched name is set equal to the substring of itself minus the last character
        }
      }
    }
    if (rSearchClicked) {//If the rank search bar was clicked
      if (key>= '0' &&key<= '9' && sRank.length()<2) {//If a number is pressed and the searched rank has less than 2 characters
        sRank += key;//Adds the key to searched rank
      } else if (key == BACKSPACE) {//If backspace is pressed
        if (sRank.length() > 0) {//If the searched name contains 1 or more characters
          sRank = sRank.substring(0, sRank.length()-1);//searched rank is set equal to the substring of itself minus the last character
        }
      }
    }
  } else if (screen == 3 && gameState ==1) {//player movements
    if (keyCode == 'W' || keyCode == UP) {
      while (player.inAir == false)
      {
        player.inAir = true;
        player.setyVelocity(-30);
      }
    } else if (keyCode == 'S' || keyCode == DOWN) {
      player.setyVelocity(20);
    } else if (keyCode == 'D' || keyCode == RIGHT) {
      player.right = true; 
      player.moving = true;
      player.setxVelocity(6);
    } else if (keyCode == 'A' || keyCode == LEFT) {
      player.right = false;
      player.moving = true;
      player.setxVelocity(-6);
    } else if (keyCode == 'P') {
      //pauses timer
      if (timer.notPaused) {
        timer.pausedTime+=millis()-timer.timeElapsed;
        timer.notPaused = false;
      }
      if (soundON.getActive()) {
        sDeny.play();
      }
      gameState = 2;
    }
  }
}

void keyReleased() {//code to run if keys are pressed and released on a specific screen
  if (gameState ==1) {//player movements
    if (keyCode == 'D' || keyCode == RIGHT) {
      player.setxVelocity(0);
      player.moving = false;
    } else if (keyCode == 'A' || keyCode == LEFT) {
      player.setxVelocity(0);
      player.moving = false;
    } else if (key==' ' && screen == 3) {

      for (int i=0; i<lasers.length; i++) {      
        if (!lasers[i].shot) {
          if (soundON.getActive()) {//if the sound on button is activated, play the 'laser' sound effect
            sLaser.play();
          }     
          lasers[i].shot=true;
          lasers[i].right = player.right;
          if (player.right)
            lasers[i].x= player.getX() + player.getW();
          else
            lasers[i].x= player.getX() - player.getW();
          lasers[i].y= player.getY();
          break;
        }
      }
    }
  }
}

//Displays the start screen when called upon
void startScreen() {
  image(background1, 0, 0);//draws the first image
  fill(255);//255 = white  
  textSize(60);//sets text size to 60
  text("SUPER SMASH UAVS", width/2, 100);//draws text to screen at specified x and y locations
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
  playB.showButton();//Draw 8 buttons 
  howToPlayB.showButton();
  scoreboardB.showButton();
  optionsB.showButton();
  creditsB.showButton();
  extrasB.showButton();
  quitB.showButton();
  backB.showButton();
}

//Procedure to play the game
void playGame() {
  image(gameStage, 0, 0);//background image for game
  noTint();//Takes off the tint
  frameRate(60);
  imageNotTaken = true;
  boolean intersects = false;
  int index = 0;

  if (!gameEnded) {//if the game has not ended
    timer.updateTime();
    player.update();

    //Display Score
    textSize(30);
    textAlign(LEFT);
    text("SCORE:", 10, 40);
    score = (uavsDestroyed * 50)+(3*timer.gameTime/1000);
    if (score>99999)//high score limit
      score = 99999;
    text(score, 125, 40);

    //Display Timer
    text("Time: " + timer.toString(), 780, 40);

    //Fire on ground
    image(fire, 0, height - 40, width, 40);

    if (player.getY() == height - player.h)
    {
      gameEnded =true;
      if (imageNotTaken) {//If an image of the current screen was not taken yet
        pausedImage = get(); //Take a screenshot of the canvas and set it to pausedImage
        imageNotTaken = false;
      }
      screen =13;
    }

    for (UAV uav : uavs) {
      uav.show();
      uav.update();

      if (uav.getSpeed() > 0)//flips image of plane depending on the direction its moving
        uav.setImg(planeImg2);
      else
        uav.setImg(planeImg);

      if (uav.equals(player)) {//if the uav intersects with the player 
        gameEnded =true;
        if (imageNotTaken) {//If an image of the current screen was not taken yet
          pausedImage = get(); //Take a screenshot of the canvas and set it to pausedImage
          imageNotTaken = false;
        }
        screen =13;
        break;
      }
      for (Laser laser : lasers) {
        if ( laser.equals(uav, player) && laser.getShot() ) {//if the laser intersects with a uav
          laser.setShot(false);
          uav.setX(width+random(100, 1000));//respawn location
          uavsDestroyed+=1;
          laser.setX(0);
        }
      }
    }

    for (Fireball fireball : fireballs) {
      fireball.show();
      fireball.update();

      if (fireball.equals(player)) {//if the fireball intersects the player
        gameEnded =true;
        if (imageNotTaken) {//If an image of the current screen was not taken yet
          pausedImage = get(); //Take a screenshot of the canvas and set it to pausedImage
          imageNotTaken = false;
        }
        screen =13;
        break;
      }

      for (Laser laser : lasers) {
        if (laser.equals(fireball, player) && laser.getShot() ) {//if laser intersects with a fireball
          laser.setShot(false);
          laser.setX(0);
        }
      }
    }

    for (int i = 0; i < platforms.length; i ++) {
      //platforms[i].colorRect1();
      switch(player.intersection(platforms[i])) {
      case 1: //Intersect from top
        player.setyVelocity(0);
        intersects = true;
        player.inAir = false;
        player.y = platforms[i].y - player.h;
        break;  

      case 2: //Intersect from below
        if (player.yVelocity < 0) // If still rising
          player.setyVelocity(2);
        break; 

      case 3: //No intersection
        if (player.y < height - player.w && intersects == false)
          player.inAir = true;
        break;
      }
    }
  }

  //Lasers
  do {
    for (int j=0; j<platforms.length; j++) {
      if (lasers[index].intersection(platforms[j]) ==1)
        lasers[index].setShot(false);
    }
    if (lasers[index].shot==true) {
      lasers[index].show();
      lasers[index].move();
    } 
    index++;
  } while (index<lasers.length);


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

//Procedure to display the pause menu
void pauseMenu() {
  background(0);
  tint(255, 100);
  image(pausedImage, 0, 0);//shows a tinted image of the game as a background
  fill(255);
  textSize(60);
  text("PAUSE MENU", 225, 50);
  textSize(30);
  strip.colorRect1();
  resumeB.showButton();
  controlsB.showButton();
  pOptionsB.showButton();
  pQuitB.showButton();
}

//Procedure to display post game results aftet the user dies 
void gameOver() {
  background(0);
  tint(255, 100);
  image(pausedImage, 0, 0);
  fill(255);
  textSize(60);
  text("GAME OVER", width/2, height/2-200);
  textSize(30);
  strScore = String.valueOf(score);//converts user's score to a string
  gameEnded = false;
  text("UAVS DESTROYED: " + uavsDestroyed, width/2, height/2-100);
  text("TIME SURVIVED: " + timer, width/2, height/2-50);
  text("FINAL SCORE: " + score, width/2, height/2);
  continueB.showButton();
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
  text("S", width/2-150, 280);
  text("A", width/2-150, 360);
  text("D", width/2-150, 440);
  text("SPACEBAR", width/2-150, 520);
  text("P", width/2-150, 600);
  text("JUMP", width/2+150, 200);
  text("DOWN", width/2+150, 280);
  text("MOVE LEFT", width/2+150, 360);
  text("MOVE RIGHT", width/2+150, 440);
  text("SHOOT", width/2+150, 520);
  text("PAUSE", width/2+150, 600);
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
  textSize(30);
  text("RANK", 100, 175);
  text("NAME", width/2, 175);
  text("SCORE", width-100, 175);
  textSize(20);
  text("SORT BY: ", 760, 130);
  text("SEARCH RANK: ", 135, 130);
  text("SEARCH NAME: ", 430, 130);
  searchBar1.colorRect3();//Draws a small rectangle with a white stroke to represent a search bar
  searchBar2.colorRect3();
  fill(255, 255, 0);//yellow 
  textAlign(LEFT);
  text(sRank, 230, 140);//Draws the searched rank inside the text box as keys are pressed on the keyboard
  text(sName, 525, 140);//Draws the searched name
  fill(255);
  textSize(30);
  textAlign(CENTER, CENTER);
  if (sName.length()>0) {//If the searched name contains atleast 1 character
    searchingName = true;
    searchPos = seqSearch(sbParts, sName); //sets search position to the value returned by the seqSearch method
    if (searchPos == -1) {//Indicates that the sequential search found no match
      text("NO MATCH FOUND", width/2, 225);//Prints the name
    }
  } else if (sRank.length()>0) {//If the searched rank contains atleast 1 character
    searchingRank = true;
    int loc = seqSearch(sbParts, Integer.parseInt(sRank));
    if (loc == -1) //Indicates that the sequential search found no match
      text("NO MATCH FOUND", width/2, 225);//Prints the name
    else {
      text(sbParts[0][loc], 100, 225);//Prints the rank
      text(sbParts[1][loc], width/2, 225);//Prints the name
      text(sbParts[2][loc], width-100, 225);//Prints the score
    }
  } else {//Draws the regular scoreboard
    searchingName = false;
    searchingRank = false;
    int i = page;
    while (i<10+page) {//Prints 10 scores depending on the page
      text(sbParts[0][i], 100, 225+((i%10)*35));//Prints the rank
      text(sbParts[1][i], width/2, 225+((i%10)*35));//Prints the name
      text(sbParts[2][i], width-100, 225+((i%10)*35));//Prints the score
      i++;
    }
  }
  strip.colorRect1();
  if (page<40 && !searchingName && !searchingRank)//If page is less than 40 (not at the last page) and the user is not searching, draw the next button
    nextB.showButton();
  if (page>0 && !searchingName && !searchingRank)//If page is greater than 0 (not at first page) and the user is not searching, draw the previous button
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

//Displays the extras menu
void extrasMenu() {
  background(0);
  tint(255, 100);
  image(background2, 0, 0);
  fill(255);
  textSize(60);
  text("EXTRAS", 150, 50);
  textSize(30);
  text("SELECT AN OPTION TO SHOW A RECURSIVE DESIGN", width/2, 300); 
  strip.colorRect1();
  oneB.showButton();
  twoB.showButton();
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
  tint(255, 100);
  image(pausedImage, 0, 0);
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
  int i = 0;
  do {//Goes through the scoreboard to check if current player's score has made top 50
    if (Integer.parseInt(strScore)>Integer.parseInt(sbParts[2][i]) && !sPlaced) {//Modifies scoreboard if current player's score is greater than the score currently held AND player's score has not already been placed in a higher position 
      sPlaced = true;
      position = i;
    }
    i++;
  } while (i<sbParts[2].length);
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

//Sorts the array, using the bubble sort algorithm, in alphabetical order and sorts the corresponding ranks and scores
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
      if (Integer.parseInt(list[0][i].substring(0, (list[0][i].length()-2))) > Integer.parseInt(list[0][largeLoc].substring(0, (list[0][largeLoc].length()-2))))
        //Gets rid of the prefixes and compares the numbers
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

//Searches for a rank in the scoreboard specified by the user and shows corresponding name and score
int seqSearch (String[][] list, int item)
{
  int location = -1;
  for (int i = 0; i < list[0].length; i++)
  {
    if (Integer.parseInt(list[0][i].substring(0, (list[0][i].length()-2))) == item)//Checks to see if the value of list[1][i] is equal to item
      location = i;
  }
  return location;
}
