public class Monkey{
  private int range, size, price;
  private PVector pos;
  private boolean isPlaced;
  private PImage img;
  private int[] level;
  
  public Monkey(String monkeyType, PVector position, int r, int cost,int siz, PImage i){
    pos = new PVector(mouseX,mouseY);
    range = r;
    isPlaced = false;
    price = cost;
    level = new int[2];
    size = siz;
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
  
  public PVector getPos(){
    return pos;
  }
  
  public void setPos(PVector p){
    pos = p;
  }
  
  //need to replace the b.x and b.y with bloon pos PVector coords
  public void attack(ArrayList<Balloon> lst){
    Balloon close = null;
    for (Balloon b : lst){
      if (Math.pow(Math.pow(b.getPos().x - pos.x,2)+Math.pow(b.getPos().y - pos.y,2),0.5) < range){
        if (close == null){
          close = b;
        } else {
          if (close.getDist() < b.getDist()){
            close = b;
          } 
        }
      }
    }
    if (close == null){
      return;
    }
    Projectile proj = new Projectile(new PVector(pos.x,pos.y),close,1,1);
    game.getProjectiles().add(proj);
  }
  
  public void display(){
    image(img, pos.x, pos.y, size, size);
  }

}