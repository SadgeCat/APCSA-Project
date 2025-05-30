int gameScreen = 1;
int cash = 500;
int lives = 100;
int round = 0;
PImage startImage;
PImage[] balloons = new PImage[8];
String[] bOrder = {"Red.png", "Blue.png", "Green.png", "Yellow.png", "Pink.png", "White.png", "Black.png", "Lead.png"};
PImage[] monkeys = new PImage[8];
String[] mOrder = {"Red.png", "Blue.png", "Green.png", "Yellow.png", "Pink.png", "White.png", "Black.png", "Lead.png"};

GameController game = new GameController();

void setup(){
  size(1280,720);
  startImage = loadImage("Screen/StartScreenBTD.png");
  for(int i = 0; i < 8; i++){
    balloons[i] = loadImage("Balloons/" + bOrder[i]);
    monkeys[i] = loadImage("Monkeys/" + mOrder[i]);
  }
  
  //String[] fontList = PFont.list();
  //printArray(fontList);
}

void draw() {
  if(gameScreen == 0){
    initScreen();
  } else if(gameScreen == 1){
    gameScreen();
  } else if(gameScreen == 2){
    gameScreen();
    gameOverScreen();
  }
}

void initScreen(){
  background(30, 30, 30);
  image(startImage, 0, 0, width, height);
  
  // title box
  fill(179, 250, 22);
  rectMode(CENTER);
  rect(width/2, 200, 700, 120, 20);

  // title text
  textAlign(CENTER, CENTER);
  textFont(createFont("NotoSerifMyanmar-Bold", 45));
  fill(0);
  text("BLOONS TD -1", width/2, 200);

  // button
  if(overBtn(width/2, 400, 200, 75)){
    fill(100);
  } else{
    fill(200);
  }
  rect(width/2, 400, 200, 75, 10);
  fill(0);
  textFont(createFont("NotoSerifMyanmar-Medium", 24));
  text("Start Game", width/2, 400);

  // start game text
  fill(215, 236, 252);
  textSize(16);
  text("Click 'Start Game' to begin.", width/2, 480);
  
  // gambling buttons (money $ lives gamble)
  if(overBtn(width/2 + 300, 350, 140, 50)){
    fill(100);
  } else{
    fill(200);
  }
  rect(width/2 + 300, 350, 140, 50, 6);
  fill(0);
  textFont(createFont("NotoSerifMyanmar-Medium", 24));
  text("lives: " + lives, width/2 + 300, 350);
  fill(215, 236, 252);
  textSize(16);
  if(lives > 20){
    text("Click this button to gamble ur lives", width/2 + 300, 400);
  } else{
    text("get scammed bozo", width/2 + 300, 400);
  }
  
  if(overBtn(width/2 + 300, 450, 140, 50)){
    fill(100);
  } else{
    fill(200);
  }
  rect(width/2 + 300, 450, 140, 50, 6);
  fill(0);
  textFont(createFont("NotoSerifMyanmar-Medium", 24));
  text("cash: " + cash, width/2 + 300, 450);
  fill(215, 236, 252);
  textSize(16);
  if(cash > 100){
    text("Click this button to gamble ur $$", width/2 + 300, 500);
  } else{
    text("get scammed bozo", width/2 + 300, 500);
  }
  
}

void gameScreen(){
  background(50, 50, 50);
  game.display();
  
  // wave, cash, lives info at top
  rectMode(CORNER);
  fill(30);
  rect(0, 0, width, 40);
  textAlign(LEFT, CENTER);
  textFont(createFont("NotoSerifMyanmar-Medium", 20));
  fill(20, 156, 34);
  text("Cash: " + cash, 20, 20);
  fill(230, 39, 39);
  text("Lives: " + lives, 220, 20);
  fill(255);
  text("Round: " + round, 420, 20);
  
  // sidebar for monkeys
  fill(40);
  rect(width - 280, 0, 280, height);
  fill(255);
  textAlign(CENTER, TOP);
  textFont(createFont("NotoSerifMyanmar-Bold", 22));
  text("Monkeys", width - 140, 20);
  
  drawMonkeyBtn(monkeys[0], width - 206, 120, 120, 120, 200);
  drawMonkeyBtn(monkeys[1], width - 74, 120, 120, 120, 200);
  drawMonkeyBtn(monkeys[2], width - 206, 252, 120, 120, 200);
  drawMonkeyBtn(monkeys[3], width - 74, 252, 120, 120, 200);
}

void gameOverScreen(){
  rectMode(CORNER);
  fill(0, 120);
  rect(0, 0, width, height);
  rectMode(CENTER);
  fill(135, 171, 255);
  rect(width/2, height/2, 600, 360, 20);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(createFont("NotoSerifMyanmar-Bold", 45));
  text("DEFEAT", width/2, height/2 - 100);
}

boolean overBtn(int x, int y, int width, int height){
  if(mouseX >= x - width/2 && mouseX <= x + width/2 && mouseY >= y - height/2 && mouseY <= y + height/2){
    return true;
  } else{
    return false;
  }
}

void drawMonkeyBtn(PImage icon, int x, int y, int width, int height, int cost){
  if(overBtn(x, y, width, height)){
    fill(100);
  } else{
    fill(200);
  }
  rectMode(CENTER);
  rect(x, y, width, height, 10);
  
  imageMode(CENTER);
  image(icon, x, y - 10, width * 0.8, height * 0.8);

  fill(0);
  textAlign(CENTER, CENTER);
  textFont(createFont("NotoSerifMyanmar-Medium", 18));
  text(cost, x, y + 3 * height/4);
}

void addCash(int k){
  cash += k;
}

boolean useCash(int k){
  if(cash >= k){
    cash -= k;
    return true;
  } else{
    return false;
  }
}

void loseLife(){
  lives--;
}

boolean isGameOver(){
  return false;
}

void mouseClicked(){
  if(gameScreen == 0){
    if(overBtn(width/2, 400, 200, 75)){
      gameScreen = 1;
    }
    if(overBtn(width/2 + 300, 350, 140, 50) && lives > 20){
      float r = random(2);
      if(r >= 1) lives+=5;
      else lives-=10;
    }
    if(overBtn(width/2 + 300, 450, 140, 50) && cash > 100){
      float r = random(2);
      if(r >= 1) cash+=50;
      else cash-=100;
    }
  } else if(gameScreen == 1){
    if(overBtn(width - 206, 120, 120, 120)){
    
    }
    if(overBtn(width - 74, 120, 120, 120)){
    
    }
    if(overBtn(width - 206, 252, 120, 120)){
    
    }
    if(overBtn(width - 74, 252, 120, 120)){
    
    }
  } else{
  
  }
  if(mouseButton == LEFT){
    
  }
  if(mouseButton == RIGHT){
    
  }
}
