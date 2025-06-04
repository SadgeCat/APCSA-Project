class Projectile{
  private PVector pos;
  private Balloon target;
  private int speed;
  private int damage;
  private int bulletDist;
  
  public Projectile(PVector p, Balloon t, int s, int d, int bd){
    pos = p;
    target = t;
    speed = s;
    damage = d;
    bulletDist = bd;
  }
  
  public int getSpeed(){
    return speed;
  }
  
  public boolean update(){
    if(target == null) return false;
    
    int moveDist = bulletDist;
    
    float x = target.getPos().x - pos.x;
    if(x > moveDist) x = moveDist;
    else if(x < -moveDist) x = -moveDist;
    float y = target.getPos().y - pos.y;
    if(y > moveDist) y = moveDist;
    else if(y < -moveDist) y = -moveDist;
    
    PVector dir = new PVector(x,y);
    
    if(dir.mag() < 1){
      target.setHP(target.getHP() - damage);
      return true;
    } else{
      pos.add(dir);
      return false;
    }
  }
  
  public void display(){
    fill(0);
    ellipse(pos.x, pos.y, 10, 10);
  }
}
