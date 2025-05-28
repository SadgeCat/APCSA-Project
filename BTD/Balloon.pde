class Balloon 
{
  private int HP;
  private float speed;
  private PVector pos;
  private PImage img;
  
  public Balloon(int HP)
  {
    this.HP = HP;
    this.speed = 5;
    this.pos = new PVector(0, 0);
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
    // move along the path
  }
}
