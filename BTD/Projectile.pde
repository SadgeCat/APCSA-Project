class Projectile{
  private PVector pos;
  private Balloon target;
  private float speed;
  private int damage;
  
  public Projectile(PVector p, Balloon t, float s, int d){
    pos = p;
    target = t;
    speed = s;
    damage = d;
  }
  
  public void update(){
    if(target == null) return;
    
    float x = target.getPos().x - pos.x;
    if(x > speed) x = speed;
    else if(x < -speed) x = -speed;
    float y = target.getPos().y - pos.y;
    if(y > speed) y = speed;
    else if(y < -speed) y = -speed;
    
    PVector dir = new PVector(x,y);
    pos.add(dir);
    
    if(dir.mag() < speed){
      target.setHP(target.getHP() - damage);
    }
  }
  
  public void display(){
    fill(0);
    ellipse(pos.x, pos.y, 10, 10);
  }
}