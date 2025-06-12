class GameController{
  private ArrayList<Balloon> balloons = new ArrayList<Balloon>();
  private ArrayList<Monkey> monkeys = new ArrayList<Monkey>();
  private ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  
  private Path p;
    
  public GameController(){
    
  }
  
  public ArrayList<PVector> getPath(){
    return p.getWayPts();
  }
  
  public ArrayList<Balloon> getBalloons(){
    return balloons;
  }
  
  public ArrayList<Monkey> getMonkeys(){
    return monkeys;
  }
  
  public ArrayList<Projectile> getProjectiles(){
    return projectiles;
  }
  
  public void setPath(Path path){
    p = path;
  }
  
  public void spawnBalloon(Balloon b){
    balloons.add(b);
  }
  
  public boolean balloonDead(){
    return balloons.isEmpty();
  }
  
  public float pointToLine(PVector p, PVector a, PVector b){
    PVector ap = PVector.sub(p, a);
    PVector ab = PVector.sub(b, a);
    float dot = ap.dot(ab) / ab.magSq();
    
    PVector closest = new PVector();
    if(dot <= 0) closest = a;
    else if(dot >= 1) closest = b;
    else closest = PVector.add(a, PVector.mult(ab, dot));
    return PVector.dist(p, closest);
  }
  
  public boolean isOnPath(PVector pos, float monkeyR, float pathR){
    for(int i = 0; i < p.getWayPts().size()-1; i++){
      PVector a = p.getWayPts().get(i);
      PVector b = p.getWayPts().get(i + 1);
      
      float d = pointToLine(pos, a, b);
      if(d < monkeyR/2 + pathR){
        return true;
      }
    }
    return false;
  }
  
  public boolean placeMonkey(Monkey m){
    if(!isOnPath(m.getPos(), m.getSize(), 20)){
      m.setPlaced();
      return true;
    } else{
      return false;
    }
  }
  
  public void addMonkey(Monkey m){
    monkeys.add(m);
  }
  
  public void update(){
    //HashMap<Balloon, Integer> expectedDamage = new HashMap<Balloon, Integer>();
    // update balloons monkey & projectile
    for(Balloon b : balloons){
      if(frameCount % b.getSpeed() == 0){
        b.update(p);
      }
    }
    
    for(int i = projectiles.size()-1; i >= 0; i--){
      if(frameCount % projectiles.get(i).getSpeed() == 0){
        if(projectiles.get(i).update()){
          projectiles.remove(i);
        }
      }
    }
    
    for(Monkey m : monkeys){
      //for(Balloon b : balloons){
      //  if(Math.pow(Math.pow(b.getPos().x - m.getPos().x,2)+Math.pow(b.getPos().y - m.getPos().y,2),0.5) < m.getRange()){
      //    int expected = expectedDamage.getOrDefault(b, 0);
  
      //    if(b.getHP() > expected){
      //      m.setTarget(b);
      //      expectedDamage.put(b, expected + m.getDamage());
      //      break;
      //    }
      //  }        
      //}
      // need to add cd
      if(frameCount % m.getCooldown() == 0 && m.getPlaced()){
        m.attack(balloons);
      }
    }
    
    //for(int i = balloons.size()-1; i >= 0; i--){
    //  if(balloons.get(i).getHP() <= 0 || balloons.get(i).reachedEnd(p)){

    //    balloons.remove(i);
    //  }
    //  else if(balloons.get(i).reachedEnd(p)){
    //    balloons.remove(i);
    //  }
    //}
  }
  
  public void display(){
    p.display();
    for(Balloon b : balloons) b.display();
    for(Monkey m : monkeys){
      if(selectedMonkey == m){
        pushStyle();
        noFill();
        stroke(255, 255, 0);
        strokeWeight(2);
        ellipse(m.getPos().x, m.getPos().y, m.getSize() + 10, m.getSize() + 10);
        fill(100, 100, 100, 100);
        circle(m.getPos().x, m.getPos().y,2*m.getRange());
        popStyle();
      }
      if (!m.getPlaced()){
        if (m.getRange() == 2000){
          m.setPos(new PVector(mouseX,mouseY));
        } else {
          fill(100, 100, 100, 100);
          if (isOnPath(m.getPos(), m.getSize(), 20)){
            fill(255,10,10,100);
          }
          circle(mouseX,mouseY,2*m.getRange());
        }
        m.setPos(new PVector(mouseX,mouseY));
      }
      m.display();
    }
    for(Projectile p : projectiles) p.display();
    // also display all balloons monkeys & projectiles
  }
}
