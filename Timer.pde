//Name: Hamza Osman & Safwan Wadud 
//Brief Description: Blueprint for timer class
class Timer {
  int gameTime, timeElapsed, pausedTime, minutes, seconds, millis;
  boolean notPaused;
  Timer() {
    gameTime = 0;
    timeElapsed = 0;
    pausedTime = 0;
    minutes = 0;
    seconds = 0;
    millis = 0;
    notPaused = false;
  }

  void updateTime() {
    gameTime = millis()-timeElapsed+pausedTime;
    millis = (gameTime/10)%100;
    seconds = (gameTime/1000)%60;
    minutes = (gameTime/1000)/60;
  }

  String toString() {
    if (notPaused) {
      return nf(minutes, 2) + ':' + nf(seconds, 2) + ":" + nf(millis);
    } else 
    return "" +pausedTime;
  }
}
