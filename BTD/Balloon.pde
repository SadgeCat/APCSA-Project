class Balloon 
{
  private int HP;
  private float speed;
  private PVector pos;
  private PImage img;
  private int wayPointIndex;
  
  public Balloon(int HP, PVector pos)
  {
    this.HP = HP;
    this.speed = 5;
    this.pos = pos;
    this.wayPointIndex = 0;
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
  
  public void pop(int damage)
  {
    HP -= damage;
  }
  
  public void updateBalloon()
  {
    
  }
}
