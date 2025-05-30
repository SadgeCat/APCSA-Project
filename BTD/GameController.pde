class GameController{
  private ArrayList<Balloon> balloons = new ArrayList<Balloon>();
  //private ArrayList<Monkey> monkeys = new ArrayList<Monkey>();
  private ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  private Path p = new Path();
  
  public GameController(){
    
  }
  
  // need to (hard code?) array for waves of balloons
  public void spawnBalloon(){
    // Balloon b = new Balloon(hp, speed, spawnpos);
    // balloons.add(b);
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
  }
  
  public void display(){
    p.display();
    // also display all balloons monkeys & projectiles
  }
}
