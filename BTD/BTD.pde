int gameScreen = 0;
int cash = 500;
int lives = 100;
int round = 0;

GameController game = new GameController();

void setup(){
  size(1000,800);
  //String[] fontList = PFont.list();
  //printArray(fontList);
}

void draw() {
  if(gameScreen == 0){
    initScreen();
  } else if(gameScreen == 1){
    gameScreen();
  } else if(gameScreen == 2){
    gameOverScreen();
  }
}

void initScreen(){
  background(30, 30, 30);
  
  fill(179, 250, 22);
  rectMode(CENTER);
  rect(width/2, 200, 700, 120, 20);

  textAlign(CENTER, CENTER);
  textFont(createFont("NotoSerifMyanmar-Bold", 45));
  fill(0);
  text("BLOONS TOWER DEFENSE -1", width/2, 200);

  if(overBtn(width/2, 400, 200, 75)){
    fill(100);
  } else{
    fill(200);
  }
  rect(width/2, 400, 200, 75, 10);
  fill(0);
  textFont(createFont("NotoSerifMyanmar-Medium", 24));
  text("Start Game", width/2, 400);

  fill(255);
  textSize(16);
  textAlign(CENTER);
  text("Click 'Start Game' to begin.", width/2, 480);
}

void gameScreen(){
  background(50, 50, 50);
  game.display();
}

void gameOverScreen(){
  
}

boolean overBtn(int x, int y, int width, int height){
  if(mouseX >= x - width/2 && mouseX <= x + width/2 && mouseY >= y - height/2 && mouseY <= y + height/2){
    return true;
  } else{
    return false;
  }
}

void addCash(){

}

boolean useCash(){
  return true;
}

void loseLife(){

}

boolean isGameOver(){
  return false;
}

void mouseClicked(){
  if(gameScreen == 0){
    if(mouseX >= 400 && mouseX <= 600 && mouseY >= 362.5 && mouseY <= 437.5){
      gameScreen = 1;
    }
  }
  if(mouseButton == LEFT){
    
  }
  if(mouseButton == RIGHT){
    
  }
}
