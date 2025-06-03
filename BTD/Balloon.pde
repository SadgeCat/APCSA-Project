class Balloon 
{
  private int HP;
  private int speed;
  private PVector pos;
  private int size;
  private int pathIndex;
  private float distFromEnd;
  private PImage img;
  
  public Balloon(int HP, int speed, PVector position, int size, PImage i)
  {
    this.HP = HP;
    this.speed = speed;
    this.size = size;
    pos = position;
    distFromEnd = 0;
    img = i;
  }
  
  public int getHP()
  {
    return HP;
  }
  
  public float getDist(){
    return distFromEnd;
  }
  
  public PVector getPos()
  {
    return pos;
  }
  
  public int getSpeed()
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
      if(x > 1) x = 1;
      else if(x < -1) x = -1;
      float y = target.y - pos.y;
      if(y > 1) y = 1;
      else if(y < -1) y = -1;
      
      PVector dir = new PVector(x,y);
      
      if(dir.mag() < 1){
        pos = target.copy();
        pathIndex++;
      } else{
        pos.add(dir);
        distFromEnd += dir.mag();
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
