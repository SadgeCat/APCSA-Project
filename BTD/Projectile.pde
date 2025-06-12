import java.util.HashSet;

class Projectile{
  private PVector pos;
  private Balloon target;
  private int speed;
  private int damage;
  private int bulletDist;
  private int chain;
  private String type;
  private HashSet<Balloon> hitBalloons = new HashSet<Balloon>();
  
  public Projectile(PVector p, Balloon t, int s, int d, int bd, int ch, String tp){
    pos = p;
    target = t;
    speed = s;
    damage = d;
    bulletDist = bd;
    chain = ch;
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
      chain--;
      target.pop(damage);
      hitBalloons.add(target);
      if(chain == 0){
        return true;
      } else{
        Balloon nextTarget = null;
        float minDist = Float.MAX_VALUE;
  
        for(Balloon b : game.balloons){
          if(!hitBalloons.contains(b) && b.getHP() > 0){
            float d = PVector.dist(pos, b.getPos());
            if(d < minDist){
              minDist = d;
              nextTarget = b;
            }
          }
        }
        
        if(nextTarget != null){
          target = nextTarget;
          return false;
        } else {
          return true;
        }
      }
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
      case "wizard":
        noStroke();
        fill(155, 0, 255, 100);
        ellipse(0, 0, 25, 25);
        fill(200, 0, 255);
        ellipse(0, 0, 12, 12);
        fill(255, 200, 0, 80);
        ellipse(-8, 0, 10, 6);
        break;
      default:
        fill(0);
        ellipse(0, 0, 10, 10);
    }
    
    popMatrix();
  }
}
