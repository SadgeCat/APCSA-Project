public class Monkey{
  private int range, size, price, damage;
  private PVector pos;
  private boolean isPlaced;
  private PImage img;
  private Balloon target;
  private int[] level;
  
  public Monkey(String monkeyType, PVector position, int r, int cost,int siz, int d, PImage i){
    pos = new PVector(mouseX,mouseY);
    range = r;
    isPlaced = false;
    price = cost;
    damage = d;
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
  
  public int getPrice(){
    return price;
  }
  
  public int getDamage(){
    return damage;
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
    Projectile proj = new Projectile(new PVector(pos.x,pos.y),target,1,damage);
    game.getProjectiles().add(proj);
    target = null;
  }
  
  public void display(){
    image(img, pos.x, pos.y, size, size);
  }

}
