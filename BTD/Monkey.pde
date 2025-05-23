public class Monkey{
  int range, size, price;
  boolean isPlaced;
  PVector pos;
  
  public Monkey(String monkeyType, PVector position){
    pos = new PVector(mouseX,mouseY);
    isPlaced = false;
    price = 
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
    ArrayList<Balloon> = new ArrayList<Balloon>();
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
    
  }
}
