class Balloon 
{
  private int HP;
  private float speed;
  private PVector pos;
  private int size;
  private int pathIndex;
  private PImage img;
  
  public Balloon(int HP, float speed, PVector position, int size, PImage i)
  {
    this.HP = HP;
    this.speed = speed;
    this.size = size;
    pos = position;
    img = i;
  }
  
  public int getHP()
  {
    return HP;
  }
  
  public PVector getPos()
  {
    return pos;
  }
  
  public float getSpeed()
  {
    return speed;
  }
  
  public void setHP(int hp){
    HP = hp;
  }
  
  public void pop(int damage)
  {
    HP -= damage;
  }
  
  public void update(Path p)
  {
    if(pathIndex < p.getWayPts().size()){
      PVector target = p.getWayPts().get(pathIndex);
      float x = target.x - pos.x;
      if(x > speed) x = speed;
      else if(x < -speed) x = -speed;
      float y = target.y - pos.y;
      if(y > speed) y = speed;
      else if(y < -speed) y = -speed;
      
      PVector dir = new PVector(x,y);
      
      if(dir.mag() < speed){
        pos = target.copy();
        pathIndex++;
      } else{
        pos.add(dir);
      }
    }
    // move along the path
  }
  
  public void display(){
    image(img, pos.x, pos.y, size, size);
  }
  
  public boolean reachedEnd(Path path){
    return pathIndex >= path.getWayPts().size();
  }
}