public class Monkey{
  private int range, size, price, damage;
  private PVector pos;
  private boolean isPlaced;
  private PImage img;
  private Balloon target;
  private int bulletDist;
  private int cooldown;
  private int[] level;
  private float angle;
  
  public Monkey(String monkeyType, PVector position, int r, int cost,int siz, int d, int bd, int cd, PImage i){
    pos = new PVector(mouseX,mouseY);
    range = r;
    isPlaced = false;
    price = cost;
    damage = d;
    bulletDist = bd;
    cooldown = cd;
    level = new int[2];
    size = siz;
    target = null;
    img = i;
  }
  
  public int getRange(){
    return range;
  }
  
  public int getSize(){
    return size;
  }
  
  public boolean getPlaced(){
    return isPlaced;
  }
  
  public int getPrice(){
    return price;
  }
  
  public int getDamage(){
    return damage;
  }
  
  public int getCooldown(){
    return cooldown;
  }
  
  public PVector getPos(){
    return pos;
  }
  
  public Balloon getTarget(){
    return target;
  }
  
  public void setPos(PVector p){
    pos = p;
  }
  
  public void setTarget(Balloon b){
    target = b;
  }
  
  public void setPlaced(){
    isPlaced = true;
  }
  
  //need to replace the b.x and b.y with bloon pos PVector coords
  public void attack(ArrayList<Balloon> lst){
    for (Balloon b : lst){
      if (Math.pow(Math.pow(b.getPos().x - pos.x,2)+Math.pow(b.getPos().y - pos.y,2),0.5) < range){
        if (target == null){
          target = b;
        } else {
          if (target.getDist() < b.getDist()){
            target = b;
          } 
        }
      }
    }
    if (target == null){
      return;
    }
    rotateMonkey(target.getPos());
    Projectile proj = new Projectile(new PVector(pos.x,pos.y),target,1,damage,bulletDist);
    game.getProjectiles().add(proj);
    target = null;
  }
  
  public void display(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    image(img, 0, 0, size, size);
    popMatrix();
  }
  
  private void rotateMonkey(PVector b){
    float y = pos.y-b.y;
    float x = b.x-pos.x;
    if (b.y <= pos.y){
      angle = atan(y/x);
    }
  }

}
