class Projectile{
  private PVector pos;
  private Balloon target;
  private int speed;
  private int damage;
  private int bulletDist;
  private String type;
  
  public Projectile(PVector p, Balloon t, int s, int d, int bd, String tp){
    pos = p;
    target = t;
    speed = s;
    damage = d;
    bulletDist = bd;
    type = tp;
  }
  
  public int getSpeed(){
    return speed;
  }
  
  public boolean update(){
    if(target == null || target.getHP() <= 0) return true;
    
    int moveDist = bulletDist;
    
    PVector toTarget = PVector.sub(target.getPos(), pos);
    float distance = toTarget.mag();
    
    PVector dir = PVector.mult(toTarget.normalize(), moveDist);
    
    if(distance < target.getSize()/2){
      target.pop(damage);
      return true;
    } else{
      pos.add(dir);
      return false;
    }
  }
  
  public void display(){
    PVector toTarget = PVector.sub(target.getPos(), pos);
  
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(atan2(toTarget.y, toTarget.x));
    
    switch(type){
      case "dart":
        fill(139, 69, 19);
        triangle(-10, -5, -10, 5, 10, 0);
        break;
      case "laser":
        stroke(255, 0, 0);
        strokeWeight(5);
        line(0, 0, 15, 0);
        noStroke();
        break;
      case "bullet":
        fill(80);
        ellipse(0, 0, 15, 8);
        break;
      default:
        fill(0);
        ellipse(0, 0, 10, 10);
    }
    
    popMatrix();
  }
}
