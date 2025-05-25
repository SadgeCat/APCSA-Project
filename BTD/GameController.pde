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
  
  public void update(){
    // update balloons monkey & projectile
  }
  
  public void display(){
    p.display();
    // also display all balloons monkeys & projectiles
  }
}