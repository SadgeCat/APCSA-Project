class GameController{
  private ArrayList<Balloon> balloons = new ArrayList<Balloon>();
  private ArrayList<Monkey> monkeys = new ArrayList<Monkey>();
  private ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  private Path p = new Path();
  
  public GameController(){
    
  }
  
  public ArrayList<PVector> getPath(){
    return p.getWayPts();
  }
  
  public ArrayList<Projectile> getProjectiles(){
    return projectiles;
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
      if(d < monkeyR + pathR){
        return true;
      }
    }
    return false;
  }
  
  public boolean placeMonkey(Monkey m){
    if(!isOnPath(m.getPos(), m.getSize(), 20)){
      monkeys.add(m);
      return true;
    } else{
      return false;
    }
  }
  
  public void update(){
    // update balloons monkey & projectile
    for(Balloon b : balloons){
      if(frameCount % b.getSpeed() == 0){
        b.update(p);
      }
    }
    
    for(Monkey m : monkeys){
      // need to add cd
      if(frameCount % 60 == 0){
        m.attack(balloons);
      }
    }
    
    for(int i = projectiles.size()-1; i >= 0; i--){
      if(frameCount % projectiles.get(i).getSpeed() == 0){
        if(projectiles.get(i).update()){
          projectiles.remove(i);
        }
      }
    }
    
    for(int i = balloons.size()-1; i >= 0; i--){
      if(balloons.get(i).getHP() <= 0 || balloons.get(i).reachedEnd(p)){
        balloons.remove(i);
      }
    }
  }
  
  public void display(){
    p.display();
    for(Balloon b : balloons) b.display();
    for(Monkey m : monkeys) m.display();
    for(Projectile p : projectiles) p.display();
    // also display all balloons monkeys & projectiles
  }
}