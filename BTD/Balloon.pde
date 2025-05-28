class Balloon 
{
  private int HP;
  private float speed;
  private PVector pos;
  
  public Balloon(int HP)
  {
    this.HP = HP;
    this.speed = 0;
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
  
  
}
