int gameScreen = 0;
int cash = 500;
int lives = 100;
int round = 0;
int balloonsPopped = 0;
PImage startImage;
String[] bOrder = {"Red.png", "Blue.png", "Green.png", "Yellow.png", "Pink.png", "White.png", "Rainbow.png", "Ceramic.png"};
PImage[] balloons = new PImage[bOrder.length];
String[] mOrder = {"Dart_Monkey.png", "Sniper_Monkey.png", "Wizard_Monkey.png", "Super_Monkey.png"};
PImage[] monkeys = new PImage[mOrder.length];

GameController game = new GameController();

Map maps = new Map();
int mapIdx = 0;

int monkeyIdx = -1;
Monkey tempMonkey = null;
Monkey selectedMonkey = null;

int timeBetweenWave = 30;
int waveTimer = timeBetweenWave;
int spawnIdx = 0, spawnInterval = 30;
boolean waveInProgress = false;
boolean win = false;

int moneyMsgTimer = 0;
int brokeMsgTimer = 0;

ArrayList<ArrayList<Balloon>> waves = new ArrayList<ArrayList<Balloon>>();

int[] speedList = {5, 4, 3, 2, 1, 1, 1, 1};
int[] sizeList = {40, 40, 40, 40, 40, 30, 40, 40};
int[] moveDistList = {4, 4, 4, 3, 4, 3, 3, 3};

void setup(){
  size(1280,720);
  startImage = loadImage("Screen/StartScreenBTD.png");
  for(int i = 0; i < bOrder.length; i++){
    balloons[i] = loadImage("Balloons/" + bOrder[i]);
  }
  for(int i = 0; i < mOrder.length; i++){
    monkeys[i] = loadImage("Monkeys/" + mOrder[i]);
  }
  
  game.setPath(maps.getMaps().get(mapIdx));
  PVector start = game.getPath().get(0);
  createWaves(start);
  
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
      Balloon current = balloon.get(i);
      
      if(current.reachedEnd(game.p)){
        
        loseLife(current.getHP());

        balloon.remove(i);
        balloonsPopped++;
        
      } else if(current.getHP() != current.getPrevHP() && current.getHP() <= 7){
        
        int currentHP = constrain(current.getHP(), 0, bOrder.length);
        addCash(10);
        
        if (currentHP > 0)
        {    
          if (current.getPrevHP() >= 6) {
            int prevHP = constrain(current.getPrevHP(), 0, bOrder.length);
            
            Balloon b = new Balloon(prevHP - 1, speedList[prevHP - 2], current.getPos().copy(), sizeList[prevHP - 2], moveDistList[prevHP - 2], balloons[prevHP - 2]);
            b.setDist(current.getDist());
            b.setPathIndex(current.getPathIndex());
            game.spawnBalloon(b);
          }
          
          current.changeStats(speedList[currentHP - 1], sizeList[currentHP - 1], moveDistList[currentHP - 1], balloons[currentHP - 1]);
        }
        else if (currentHP == 0)
        {
          balloon.remove(i);
          balloonsPopped++;
        }
      }
      
    }
    
    game.update();
    
    if(!waveInProgress && round < waves.size()){
      if(waveTimer > 0){
        if(frameCount % 60 == 0) waveTimer--;
      } else{
        waveInProgress = true;
        spawnIdx = 0;
      }
    }
    
    if(waveInProgress && frameCount % spawnInterval == 0 && spawnIdx < waves.get(round).size()){
      game.spawnBalloon(waves.get(round).get(spawnIdx));
      spawnIdx++;
    }
    
    if(spawnIdx >= waves.get(round).size() && game.balloonDead() && waveInProgress == true){
      waveTimer = timeBetweenWave;
      round++;
      moneyMsgTimer = 300;
      addCash(round * 50);
      waveInProgress = false;
    }
    
    if(lives <= 0){
      gameScreen = 2;
      win = false;
    }
    if(round >= waves.size() && game.balloonDead()){
      gameScreen = 2;
      win = true;
    }
    
    if(moneyMsgTimer > 0){
      fill(0, 255, 0, map(moneyMsgTimer, 0, 120, 0, 255));
      textAlign(CENTER);
      textFont(createFont("NotoSerifMyanmar-Medium", 24));
      text("wave bonus: $" + round * 50, width / 2, height - 50);
      moneyMsgTimer--;
    }
    if(brokeMsgTimer > 0){
      fill(179, 12, 0, map(brokeMsgTimer, 0, 120, 0, 255));
      textAlign(CENTER);
      textFont(createFont("NotoSerifMyanmar-Medium", 24));
      text("ur broke noob, maybe try gambling", width / 2, height - 50);
      brokeMsgTimer--;
    }
    
  } else if(gameScreen == 2){
    gameScreen();
    gameOverScreen();
  } else if(gameScreen == 3){
    mapSelectScreen();  
  }
}

ArrayList<Balloon> createWave(int[] cnt, int[] hp, PVector start){
  ArrayList<Balloon> wave = new ArrayList<Balloon>();
  for (int i = 0; i < cnt.length; i++) {
    for (int j = 0; j < cnt[i]; j++) {
      Balloon b = new Balloon(hp[i], speedList[constrain(hp[i], 0, speedList.length) - 1], start.copy(), sizeList[constrain(hp[i], 0, sizeList.length) - 1], moveDistList[constrain(hp[i], 0, moveDistList.length) - 1], balloons[constrain(hp[i], 0, balloons.length) - 1]);
      wave.add(b);
    }
  }
  return wave;
}

void createWaves(PVector start) {
  waves.clear();
  // int[] cnt, int[] hp, PVector start
  waves.add(createWave(new int[]{10}, new int[]{1}, start)); // 10 red
  waves.add(createWave(new int[]{5, 5}, new int[]{1, 2}, start)); // 5 red, 5 blue
  waves.add(createWave(new int[]{10}, new int[]{2}, start)); // 10 blue
  waves.add(createWave(new int[]{10}, new int[]{3}, start)); // 10 green
  waves.add(createWave(new int[]{15}, new int[]{4}, start)); // 15 yellow
  waves.add(createWave(new int[]{15}, new int[]{5}, start)); // 15 pink
  waves.add(createWave(new int[]{5,5,5}, new int[]{4,5,6}, start)); // 5y, 5p, 5w
  waves.add(createWave(new int[]{10}, new int[]{6}, start)); // 10w
  waves.add(createWave(new int[]{10, 5, 5, 10}, new int[]{3, 5, 3, 5}, start)); // 15 pink 15 green but like assorted order
  waves.add(createWave(new int[]{5, 5, 5, 5}, new int[]{3, 6, 5, 6}, start)); // 10w 5p 5g
  waves.add(createWave(new int[]{5, 10, 5}, new int[]{5, 6, 7}, start)); // 5p 10w 5r
  waves.add(createWave(new int[]{5, 10}, new int[]{6, 7}, start)); // 5w 10r
  waves.add(createWave(new int[]{10}, new int[]{10}, start)); // 10c
  waves.add(createWave(new int[]{20, 1}, new int[]{7, 15}, start)); // 20r 1 strong ceramic
  waves.add(createWave(new int[]{3}, new int[]{33}, start)); // 3 super strong ceramic, goodluck!!!!!
}

void initScreen(){
  background(30, 30, 30);
  imageMode(CORNER);
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
  
  // select map button
  if(overBtn(width/2, 550, 200, 60)){
    fill(100);
  } else{
    fill(200);
  }
  rect(width/2, 550, 200, 60, 10);
  fill(0);
  textFont(createFont("NotoSerifMyanmar-Medium", 24));
  text("Choose Map", width/2, 550);
  
  // keybinds box
  fill(40);
  rectMode(CORNER);
  float kbX = 100;
  float kbY = 350;
  float kbW = 280;
  float kbH = 260;
  rect(kbX, kbY, kbW, kbH, 12);
  fill(255);
  textFont(createFont("NotoSerifMyanmar-Bold", 22));
  textAlign(LEFT, TOP);
  text("Keybinds", kbX + 15, kbY + 15);

  // keybinds list
  textFont(createFont("NotoSerifMyanmar-Medium", 16));
  String[] keys = {
    "1: Dart Monkey",
    "2: Sniper Monkey",
    "3: Wizard Monkey",
    "4: Super Monkey",
    "Q: Upgrade 1 (more damage)",
    "E: Upgrade 2 (better range & cd)",
    "X: Sell Monkey"
  };
  for(int i = 0; i < keys.length; i++){
    text(keys[i], kbX + 15, kbY + 60 + i * 28);
  }
}

void mapSelectScreen(){
  background(40);
  fill(255);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textFont(createFont("NotoSerifMyanmar-Bold", 36));
  text("Select a Map", width/2, 80);
  
  for(int i = 0; i < 6; i++){
    int btnX = 150 + i * 200;
    int btnY = height / 2;
    int btnW = 120;
    int btnH = 80;

    if(overBtn(btnX, btnY, btnW, btnH)){
      fill(100, 180, 250);
    } else{
      fill(180);
    }

    rect(btnX, btnY, btnW, btnH, 12);
    fill(0);
    textFont(createFont("NotoSerifMyanmar-Medium", 20));
    text("Map " + (i+1), btnX, btnY);
  }

  // return to starting screen
  int backX = width / 2;
  int backY = height - 100;
  if(overBtn(backX, backY, 160, 60)){
    fill(100);
  } else{
    fill(200);
  }
  rect(backX, backY, 160, 60, 10);
  fill(0);
  textFont(createFont("NotoSerifMyanmar-Medium", 22));
  text("Back", backX, backY);
}

void gameScreen(){
  background(45, 133, 68);
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
  text("Lives: " + lives, 180, 20);
  fill(255);
  text("Round: " + (round+1), 340, 20);
  text("Timer: " + waveTimer, 500, 20);
  text("# Popped: " + balloonsPopped, 660, 20);
  
  // sidebar for monkeys
  fill(40);
  rect(width - 280, 0, 280, height);
  fill(255);
  textAlign(CENTER, TOP);
  textFont(createFont("NotoSerifMyanmar-Bold", 22));
  text("Monkeys", width - 140, 20);
  
  // play button
  if(overBtn(width - 280/2, height - 70/2, 280, 70)){
    fill(50, 200,50);
  } else{
    fill(0, 255,0);
  }
  rect(width - 280, height - 70, 280, 70);
  fill(255);
  triangle((width - 140) - 27, (height - 35) - 23.5, (width - 140) - 27, (height - 35) + 23.5, (width - 140) + 27, (height - 35));
  
  // gambling buttons (money $ lives gamble)
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  if(overBtn(width - 210, 400, 100, 40)){
    fill(100);
  } else{
    fill(200);
  }
  rect(width - 210, 400, 100, 40, 6);
  fill(0);
  textFont(createFont("NotoSerifMyanmar-Medium", 18));
  text("lives: " + lives, width - 210, 400);
  fill(215, 236, 252);
  textSize(12);
  text("gamble lives", width - 210, 430);
  
  if(overBtn(width - 70, 400, 100, 40)){
    fill(100);
  } else{
    fill(200);
  }
  rect(width - 70, 400, 100, 40, 6);
  fill(0);
  textFont(createFont("NotoSerifMyanmar-Medium", 18));
  text("cash: " + cash, width - 70, 400);
  fill(215, 236, 252);
  textSize(12);
  text("gamble $$", width - 70, 430);
  
  drawMonkeyBtn(monkeys[0], width - 206, 120, 120, 120, 250);
  drawMonkeyBtn(monkeys[1], width - 74, 120, 120, 120, 400);
  drawMonkeyBtn(monkeys[2], width - 206, 252, 120, 120, 850);
  drawMonkeyBtn(monkeys[3], width - 74, 252, 120, 120, 1100);
  
  drawMonkeyUI();
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
  
  if(win) text("VICTORY", width/2, height/2 - 100);
  else text("DEFEAT", width/2, height/2 - 100);
  
  textFont(createFont("NotoSerifMyanmar-Medium", 30));
  
  if(overBtn(width/2-140, height/2+40, 180, 100)){
    fill(26, 82, 99);
  } else{
    fill(43, 143, 173);
  }
  rect(width/2-140, height/2+40, 180, 100, 10);
  fill(0);
  text("Play Again", width/2-140, height/2+40);
  
  if(overBtn(width/2+140, height/2+40, 180, 100)){
    fill(84, 13, 20);
  } else{
    fill(156, 19, 9);
  }
  rect(width/2+140, height/2+40, 180, 100, 10);
  fill(0);
  text("Quit", width/2+140, height/2+40);
}

boolean overBtn(int x, int y, int width, int height){
  if(mouseX >= x - width/2 && mouseX <= x + width/2 && mouseY >= y - height/2 && mouseY <= y + height/2){
    return true;
  } else{
    return false;
  }
}

void drawMonkeyUI(){
  if(selectedMonkey != null){
    // main frame
    fill(60);
    rectMode(CORNER);
    rect(width - 280, height - 210, 280, 140, 10);
    
    // monkey name and stats
    fill(255);
    textAlign(LEFT, TOP);
    textFont(createFont("NotoSerifMyanmar-Bold", 18));
    text(selectedMonkey.getName(), width - 270, height - 200);
    
    textFont(createFont("NotoSerifMyanmar-Medium", 14));
    text("Damage: " + selectedMonkey.getDamage(), width - 270, height - 175);
    text("Range: " + selectedMonkey.getRange(), width - 270, height - 155);
    text("Attack CD: " + selectedMonkey.getCooldown(), width - 150, height - 175);
    
    // sell button (50% refund)
    if(overBtn(width - 230, height - 100, 80, 30)){
      fill(200, 50, 50);
    } else{
      fill(255, 80, 80);
    }
    rectMode(CENTER);
    rect(width - 230, height - 100, 80, 30, 5);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(createFont("NotoSerifMyanmar-Medium", 14));
    text("Sell ($" + selectedMonkey.getValue() / 2 + ")", width - 230, height - 100);
    
    // Upgrade buttons
    if(overBtn(width - 100, height - 135, 150, 30)){
      fill(50, 200, 50);
    } else{
      fill(80, 255, 80);
    }
    rectMode(CENTER);
    rect(width - 100, height - 135, 150, 30, 5);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(createFont("NotoSerifMyanmar-Medium", 14));
    text("+ damage ($" + selectedMonkey.getUpg1() + ")", width - 100, height - 135);
    
    if(overBtn(width - 100, height - 100, 150, 30)){
      fill(50, 200, 50);
    } else{
      fill(80, 255, 80);
    }
    rectMode(CENTER);
    rect(width - 100, height - 100, 150, 30, 5);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(createFont("NotoSerifMyanmar-Medium", 14));
    text("+ range & cd ($" + selectedMonkey.getUpg2() + ")", width - 100, height - 100);

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
  if (cost == 400){
    image(icon, x, y - 30, width * 0.8, height * 1.2);
  } else {
    image(icon, x, y - 10, width * 0.8, height * 0.8);
  }
  

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

void sell(){
  addCash(selectedMonkey.getPrice() / 2);
  game.getMonkeys().remove(selectedMonkey);
  selectedMonkey = null;
}
void upgrade1(){
  if(useCash(selectedMonkey.getUpg1())){
    selectedMonkey.addValue(selectedMonkey.getUpg1());
    selectedMonkey.setDamage(2 * selectedMonkey.getDamage());
    selectedMonkey.setUpg1(floor(2.5 * selectedMonkey.getUpg1()));
  } else{
    brokeMsgTimer = 240;
  }
}
void upgrade2(){
  if(useCash(selectedMonkey.getUpg2())){
    selectedMonkey.addValue(selectedMonkey.getUpg2());
    selectedMonkey.setRange(floor(1.5 * selectedMonkey.getRange()));
    selectedMonkey.setCD(floor(0.67 * selectedMonkey.getCooldown()));
    selectedMonkey.setUpg2(floor(2.5 * selectedMonkey.getUpg2()));
  } else{
    brokeMsgTimer = 240;
  }
}

void dartMonkey(){
  if(monkeyIdx != -1) game.getMonkeys().remove(game.getMonkeys().size()-1);
  monkeyIdx = 0;
  tempMonkey = new Monkey("Dart Monkey", new PVector(mouseX, mouseY), 100, 250, 350, 300, 50, 1, 10, 60, 1, monkeys[0]);
  game.addMonkey(tempMonkey);
}
void sniperMonkey(){
  if(monkeyIdx != -1) game.getMonkeys().remove(game.getMonkeys().size()-1);
  monkeyIdx = 1;
  tempMonkey = new Monkey("Sniper Monkey", new PVector(mouseX, mouseY), 2000, 400, 450, 300, 50, 2, 40, 150, 1, monkeys[1]);
  game.addMonkey(tempMonkey);
}
void wizardMonkey(){
  if(monkeyIdx != -1) game.getMonkeys().remove(game.getMonkeys().size()-1);
  monkeyIdx = 2;
  tempMonkey = new Monkey("Wizard Monkey", new PVector(mouseX, mouseY), 150, 850, 1150, 1000, 50, 1, 7, 120, 4, monkeys[2]);
  game.addMonkey(tempMonkey);
}
void superMonkey(){
  if(monkeyIdx != -1) game.getMonkeys().remove(game.getMonkeys().size()-1);
  monkeyIdx = 3;
  tempMonkey = new Monkey("Super Monkey", new PVector(mouseX, mouseY), 200, 1100, 1200, 900, 60, 1, 20, 15, 1, monkeys[3]);
  game.addMonkey(tempMonkey);
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
    if(overBtn(width/2, 550, 200, 60)){
      gameScreen = 3;
    }
    
  } else if(gameScreen == 1){
    //gamble
    if(overBtn(width - 210, 400, 100, 40) && lives > 20){
      float r = random(2);
      if(r >= 1) lives+=5;
      else lives-=10;
    }
    if(overBtn(width - 70, 400, 100, 40) && cash > 100){
      float r = random(2);
      if(r >= 1) cash+=50;
      else cash-=100;
    }
    //sell
    if(overBtn(width - 230, height - 100, 80, 30) && selectedMonkey != null){
      sell();
      return;
    }
    //upgrade1
    if(overBtn(width - 100, height - 135, 150, 30) && selectedMonkey != null){
      upgrade1();
      return;
    }
    //upgrade2
    if(overBtn(width - 100, height - 100, 150, 30) && selectedMonkey != null){
      upgrade2();
      return;
    }
    
    if(mouseButton == LEFT && monkeyIdx == -1 && tempMonkey == null){
      selectedMonkey = null;
      
      for(Monkey m : game.getMonkeys()){
        float distance = dist(mouseX, mouseY, m.getPos().x, m.getPos().y);
        if(distance < m.getSize()/2){
          selectedMonkey = m;
          break;
        }
      }
      
      if(selectedMonkey != null){
        return;
      }
    }
    
    if(overBtn(width - 280/2, height - 70/2, 280, 70) && !waveInProgress){
      waveTimer = 0;
    }
    
    if(overBtn(width - 206, 120, 120, 120)){
      dartMonkey();
    } else if(overBtn(width - 74, 120, 120, 120)){
      sniperMonkey();
    } else if(overBtn(width - 206, 252, 120, 120)){
      wizardMonkey();
    } else if(overBtn(width - 74, 252, 120, 120)){
      superMonkey();
    } else if (monkeyIdx != -1) {
      tempMonkey.setPos(new PVector(mouseX, mouseY));
      if(useCash(tempMonkey.getPrice())) {
        if(!game.placeMonkey(tempMonkey)){
          cash += tempMonkey.getPrice();
          tempMonkey = null;
          monkeyIdx = -1;
          game.getMonkeys().remove(game.getMonkeys().size()-1);
        } else{
          selectedMonkey = tempMonkey;
          tempMonkey = null;
          monkeyIdx = -1;
        }
      } else{
        brokeMsgTimer = 240;
        tempMonkey = null;
        monkeyIdx = -1;
        game.getMonkeys().remove(game.getMonkeys().size()-1);
      }
      
    }
    
  } else if(gameScreen == 2){
    if(overBtn(width/2-140, height/2+40, 180, 100)){
      cash = 500;
      lives = 100;
      round = 0;
      balloonsPopped = 0;
      gameScreen = 0;
      
      selectedMonkey = null;
      
      game.getMonkeys().clear();
      game.getBalloons().clear();
      PVector start = game.getPath().get(0);
      createWaves(start);
    }
    if(overBtn(width/2+140, height/2+40, 180, 100)){
      exit();
    }
    
  } else if(gameScreen == 3){
    for(int i = 0; i < 6; i++){
      int btnX = 150 + i * 200;
      int btnY = height / 2;
      int btnW = 120;
      int btnH = 80;
      if(overBtn(btnX, btnY, btnW, btnH)){
        mapIdx = i;
        
        game.setPath(maps.getMaps().get(mapIdx));
        PVector start = game.getPath().get(0);
        createWaves(start);
        
        gameScreen = 1;
      }
    }
    if(overBtn(width / 2, height - 100, 160, 60)){
      gameScreen = 0;
    }
  }
}

void keyPressed(){
  if(gameScreen == 1){
    if(selectedMonkey != null && key == 'x' || key == 'X'){
      sell();
      return;
    }
    if(selectedMonkey != null && key == 'q' || key == 'Q'){
      upgrade1();
      return;
    }
    if(selectedMonkey != null && key == 'e' || key == 'E'){
      upgrade2();
      return;
    }
    
    if(key == '1'){
      dartMonkey();
    }
    if(key == '2'){
      sniperMonkey();
    }
    if(key == '3'){
      wizardMonkey();
    }
    if(key == '4'){
      superMonkey();
    }
  }
}
