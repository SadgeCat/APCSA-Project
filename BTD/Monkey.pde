public class Monkey{
  private int range, size, price, damage;
  private String name;
  private PVector pos;
  private boolean isPlaced;
  private PImage img;
  private Balloon target;
  private int bulletDist;
  private int cooldown;
  private int[] level;
  private float angle;
  private int upg1, upg2;
  private int value;
  
  public Monkey(String monkeyType, PVector position, int r, int cost, int u1, int u2, int siz, int d, int bd, int cd, PImage i){
    name = monkeyType;
    pos = position;
    range = r;
    isPlaced = false;
    price = cost;
    value = cost;
    upg1 = u1;
    upg2 = u2;
    damage = d;
    bulletDist = bd;
    cooldown = cd;
    level = new int[2];
    size = siz;
    target = null;
    img = i;
  }
  
  public String getName(){
    return name;
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
  
  public int getUpg1(){
    return upg1;
  }
  
  public int getUpg2(){
    return upg2;
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
  
  public int getValue(){
    return value;
  }
  
  public Balloon getTarget(){
    return target;
  }
  
  public void setDamage(int k){
    damage = k;
  }
  
  public void setRange(int k){
    range = k;
  }
  
  public void setCD(int k){
    cooldown = k;
  }
  
  public void setUpg1(int k){
    upg1 = k;
  }
  
  public void setUpg2(int k){
    upg2 = k;
  }
  
  public void addValue(int k){
    value += k;
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
    Projectile proj = new Projectile(new PVector(pos.x,pos.y),target,1,damage,bulletDist, null);
    if(name.equals("Dart Monkey")) proj = new Projectile(new PVector(pos.x,pos.y),target,1,damage,bulletDist, "dart");
    else if(name.equals("Sniper Monkey")) proj = new Projectile(new PVector(pos.x,pos.y),target,1,damage,bulletDist, "bullet");
    else if(name.equals("Super Monkey")) proj = new Projectile(new PVector(pos.x,pos.y),target,1,damage,bulletDist, "laser");
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
      angle = atan(x/y);
    } else {
      angle = atan(x/y) + PI;
    }
  }

}
