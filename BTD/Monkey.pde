public class Monkey{
  int range, size, price;
  boolean isPlaced;
  PVector pos;
  int[] level;
  
  public Monkey(String monkeyType, PVector position, int cost,int siz){
    pos = new PVector(mouseX,mouseY);
    isPlaced = false;
    price = cost;
    level = new int[2];
    size = siz;
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
  
  //need to replace the b.x and b.y with bloon pos PVector coords
  public void attack(ArrayList<Balloon> lst){
    Balloon close = lst.get(0);
    for (Balloon b : lst){
      if (Math.pow(Math.pow(b.getPos().x - pos.x,2)+Math.pow(b.getPos().y - pos.y,2),0.5) < range){
        // something to find which balloon is closest to end of track
      }
    }
    Projectile atk = new Projectile(
  }
  
  
  public void placeMonkey(){
    if (onTrack()){
      return;
    }
    isPlaced = true;
    pos = new PVector(mouseX,mouseY);
  }
  
  private boolean onTrack(int trackWidth, ArrayList<PVector> waypoints){
    for (int i = 0;i < waypoints.size()-1;i++){
      if (GameController.pointToLine(pos,waypoints.get(i),waypoints.get(i+1)) >= size+trackWidth){
        return true;
      }
    }
    return false;
  }
  
  
}
