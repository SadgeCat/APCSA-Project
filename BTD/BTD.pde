int gameScreen = 0;
int cash = 2000;
int lives = 100;
int round = 0;
PImage startImage;
PImage[] balloons = new PImage[8];
String[] bOrder = {"Red.png", "Blue.png", "Green.png", "Yellow.png", "Pink.png", "White.png", "Black.png", "Lead.png"};
PImage[] monkeys = new PImage[8];
String[] mOrder = {"Dart_Monkey.png", "Sniper_Monkey.png", "Super_Monkey.png"};

GameController game = new GameController();

int monkeyIdx = -1;
Monkey tempMonkey = null;

int spawnIdx = 0, spawnInterval = 30;
boolean waveInProgress = false;
boolean win = false;

PVector start = game.getPath().get(0);
ArrayList<ArrayList<Balloon>> waves = new ArrayList<ArrayList<Balloon>>();

void setup(){
  size(1280,720);
  startImage = loadImage("Screen/StartScreenBTD.png");
  for(int i = 0; i < 8; i++){
    balloons[i] = loadImage("Balloons/" + bOrder[i]);
  }
  for(int i = 0; i < 3; i++){
    monkeys[i] = loadImage("Monkeys/" + mOrder[i]);
  }
  
  waves.add(createWave(new int[]{10}, new int[]{1}, new int[]{5}, new int[]{40}, new int[]{10}, new int[]{0}, start)); // 10 red
  waves.add(createWave(new int[]{5, 5}, new int[]{1, 2}, new int[]{5, 4}, new int[]{40, 40}, new int[]{20, 10}, new int[]{0, 1}, start)); // 5 red, 5 blue
  waves.add(createWave(new int[]{10}, new int[]{2}, new int[]{4}, new int[]{40}, new int[]{20}, new int[]{1}, start)); // 10 blue
  waves.add(createWave(new int[]{10}, new int[]{3}, new int[]{3}, new int[]{40}, new int[]{30}, new int[]{2}, start)); // 10 green
  waves.add(createWave(new int[]{15}, new int[]{4}, new int[]{2}, new int[]{40}, new int[]{40}, new int[]{3}, start)); // 15 yellow
  
  //String[] fontList = PFont.list();
  //printArray(fontList);
}

void draw() {
  if(gameScreen == 0){
    initScreen();
  } else if(gameScreen == 1){
    gameScreen();
    
    ArrayList<Balloon> balloon = game.getBalloons();
    
    for(int i = balloon.size()-1; i >= 0; i--){
      
      if(balloon.get(i).reachedEnd(game.p)){
        
        if(balloon.get(i).getSpeed() == 5) loseLife(1);
        else if(balloon.get(i).getSpeed() == 4) loseLife(2);
        else if(balloon.get(i).getSpeed() == 3) loseLife(3);
        else if(balloon.get(i).getSpeed() == 2) loseLife(4);
        else if(balloon.get(i).getSpeed() == 1) loseLife(5);

        balloon.remove(i);
        
      } else if(balloon.get(i).getHP() <= 0){

        addCash(balloon.get(i).getCash());
        
        if(balloon.get(i).getSpeed() == 5){
          
        } else if(balloon.get(i).getSpeed() == 4){
          Balloon b = new Balloon(1, 5, balloon.get(i).getPos(), 40, 10, balloons[0]);
          b.setDist(balloon.get(i).getDist());
          b.setPathIndex(balloon.get(i).getPathIndex());
          game.spawnBalloon(b);
        } else if(balloon.get(i).getSpeed() == 3){
          Balloon b = new Balloon(2, 4, balloon.get(i).getPos(), 40, 20, balloons[1]);
          b.setDist(balloon.get(i).getDist());
          b.setPathIndex(balloon.get(i).getPathIndex());
          game.spawnBalloon(b);
        } else if(balloon.get(i).getSpeed() == 2){
          Balloon b = new Balloon(3, 3, balloon.get(i).getPos(), 40, 30, balloons[2]);
          b.setDist(balloon.get(i).getDist());
          b.setPathIndex(balloon.get(i).getPathIndex());
          game.spawnBalloon(b);
        } else if(balloon.get(i).getSpeed() == 1){
          Balloon b = new Balloon(4, 2, balloon.get(i).getPos(), 40, 40, balloons[3]);
          b.setDist(balloon.get(i).getDist());
          b.setPathIndex(balloon.get(i).getPathIndex());
          game.spawnBalloon(b);
        } 
        
        balloon.remove(i);
      }
      
    }
    
    game.update();
    
    if(!waveInProgress && round < waves.size()){
      waveInProgress = true;
      spawnIdx = 0;
    }
    
    if(waveInProgress && frameCount % spawnInterval == 0 && spawnIdx < waves.get(round).size()){
      game.spawnBalloon(waves.get(round).get(spawnIdx));
      spawnIdx++;
    }
    
    if(spawnIdx >= waves.get(round).size() && game.balloonDead()){
      round++;
      waveInProgress = false;
    }
    
    if(lives <= 0){
      gameScreen = 2;
      win = false;
    }
    if(round >= waves.size()){
      gameScreen = 2;
      win = true;
    }
    
  } else if(gameScreen == 2){
    gameScreen();
    gameOverScreen();
  }
}

ArrayList<Balloon> createWave(int[] cnt, int[] hp, int[] speed, int[] size, int[] cash, int[] type, PVector start){
  ArrayList<Balloon> wave = new ArrayList<Balloon>();
  for (int i = 0; i < cnt.length; i++) {
    for (int j = 0; j < cnt[i]; j++) {
      Balloon b = new Balloon(hp[i], speed[i], start.copy(), size[i], cash[i], balloons[type[i]]);
      wave.add(b);
    }
  }
  return wave;
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
  text("Round: " + (round+1), 420, 20);
  
  // sidebar for monkeys
  fill(40);
  rect(width - 280, 0, 280, height);
  fill(255);
  textAlign(CENTER, TOP);
  textFont(createFont("NotoSerifMyanmar-Bold", 22));
  text("Monkeys", width - 140, 20);

  // play button
  fill(0, 255, 0);
  rect(width - 280, height - 70, 280, 70);
  fill(255);
  triangle((width - 140) - 27, (height - 35) - 23.5, (width - 140) - 27, (height - 35) + 23.5, (width - 140) + 27, (height - 35));
  
  drawMonkeyBtn(monkeys[0], width - 206, 120, 120, 120, 200);
  //drawMonkeyBtn(monkeys[1], width - 74, 120, 120, 120, 200);
  //drawMonkeyBtn(monkeys[2], width - 206, 252, 120, 120, 200);
  //drawMonkeyBtn(monkeys[3], width - 74, 252, 120, 120, 200);
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
  text(cost, x, y + 50);
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

void loseLife(int k){
  lives -= k;
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
      monkeyIdx = 0;
      tempMonkey = new Monkey("Dart Monkey", new PVector(mouseX, mouseY), 100, 200, 50, 1, monkeys[0]);
    //} else if(overBtn(width - 74, 120, 120, 120)){
    //  monkeyIdx = 1;
    //  tempMonkey = new Monkey("Dart Monkey", new PVector(mouseX, mouseY), 100, 200, 50, 1, monkeys[0]);
    //} else if(overBtn(width - 206, 252, 120, 120)){
    //  monkeyIdx = 2;
    //  tempMonkey = new Monkey("Dart Monkey", new PVector(mouseX, mouseY), 100, 200, 50, 1, monkeys[0]);
    //} else if(overBtn(width - 74, 252, 120, 120)){
    //  monkeyIdx = 3;
    //  tempMonkey = new Monkey("Dart Monkey", new PVector(mouseX, mouseY), 100, 200, 50, 1, monkeys[0]);
    } else if (monkeyIdx != -1) {
      tempMonkey.setPos(new PVector(mouseX, mouseY));
      if(useCash(tempMonkey.getPrice())) {
        if(!game.placeMonkey(tempMonkey)){
          cash += tempMonkey.getPrice();
        }
      }
      tempMonkey = null;
      monkeyIdx = -1;
    }
  } else{
  
  }
  if(mouseButton == LEFT){
    
  }
  if(mouseButton == RIGHT){
    
  }
}
