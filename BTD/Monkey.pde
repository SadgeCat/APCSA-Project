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
    for (Ballon b : lst){
      if (Math.pow(Math.pow(b.x - pos.x,2)+Math.pow(b.y - pos.y,2),0.5) < range){
        
      }
    }
  }
  
  
  public void placeMonkey(){
    if (onTrack()){
      return;
    }
    isPlaced = true;
    pos = new PVector(mouseX,mouseY);
  }
  
  private boolean onTrack(){
    for (int i = 0;i < path.size();i++){
      if (path.get(i)
    }
  }
}
