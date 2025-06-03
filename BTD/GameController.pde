class GameController{
  private ArrayList<Balloon> balloons = new ArrayList<Balloon>();
  //private ArrayList<Monkey> monkeys = new ArrayList<Monkey>();
  private ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  private Path p = new Path();
  
  public GameController(){
    
  }
  
  public ArrayList<PVector> getPath(){
    return p.getWayPts();
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
  
  public void placeMonkey(PVector pos, float r, float cd, int d){
    // Monkey m = new Monkey(pos, r, cd, d);
    // monkeys.add(m);
  }
  
  public void update(){
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
    
    for(int i = balloons.size()-1; i >= 0; i--){
      if(balloons.get(i).getHP() <= 0 || balloons.get(i).reachedEnd(p)){
        balloons.remove(i);
      }
    }
  }
  
  public void display(){
    p.display();
    for(Balloon b : balloons) b.display();
    for(Projectile p : projectiles) p.display();
    // also display all balloons monkeys & projectiles
  }
}
