class Balloon 
{
  private int HP;
  private int speed;
  private PVector pos;
  private int size;
  private int cash;
  private int moveDist;
  private int pathIndex;
  private float distFromStart;
  private PImage img;
  
  public Balloon(int HP, int speed, PVector position, int size, int c, int md, PImage i)
  {
    this.HP = HP;
    this.speed = speed;
    this.size = size;
    cash = c;
    moveDist = md;
    pos = position;
    distFromStart = 0;
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
  
  public int getSpeed()
  {
    return speed;
  }
  
  public int getSize(){
    return size;
  }
  
  public int getCash(){
    return cash;
  }
  
  public float getDist(){
    return distFromStart;
  }
  
  public int getPathIndex(){
    return pathIndex;
  }
  
  public PImage getImg(){
    return img;
  }
  
  public void setHP(int hp){
    HP = hp;
  }
  
  public void setDist(float d){
    distFromStart = d;
  }
  
  public void setPathIndex(int idx){
    pathIndex = idx;
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
      if(x > moveDist) x = moveDist;
      else if(x < -moveDist) x = -moveDist;
      float y = target.y - pos.y;
      if(y > moveDist) y = moveDist;
      else if(y < -moveDist) y = -moveDist;
      
      PVector dir = new PVector(x,y);
      
      if(dir.mag() < 2){
        pos = target.copy();
        pathIndex++;
      } else{
        pos.add(dir);
        distFromStart += dir.mag();
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