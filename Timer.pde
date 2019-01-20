class Timer {
  float startTime;
  float pausedTime;
  float gameTime;
  int minutes;
  int seconds;
  boolean running;

  Timer() {
    startTime = 0;
    pausedTime = 0;
    gameTime = 0;
    minutes = 0;
    seconds = 0;
    running = false;
  }

  void startTime() {
    startTime = millis();
  }

  void pausedTime() {
    pausedTime = millis() - gameTime - startTime;
  }


  String toString() {
    gameTime = (millis() - startTime - pausedTime)/60000;
    minutes = floor(gameTime);
    seconds = floor(gameTime * 60) % 60;

    if (minutes > 0)
      return "Time: " + str(minutes) + ':' + nf(seconds, 2);

    return "Time: " + nf(seconds, 2);
  }
}
