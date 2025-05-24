int cash = 500;
int lives = 100;
int round = 0;

GameController game = new GameController();

void setup(){
  size(1000,800);
}

void draw() {
  background(50, 50, 50);
  game.display();
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

void drawUI(){

}


void mouseClicked() {
  if(mouseButton == LEFT){
    
  }
  if(mouseButton == RIGHT){
    
  }
}
