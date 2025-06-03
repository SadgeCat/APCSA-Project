class Balloon 
{
  private int HP;
  private float speed;
  private PVector pos;
  private int wayPointIndex;
  private PVector[] waypoints;
  
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
    if (wayPointIndex >= waypoints.length - 1)
    {
      return;
    }
    
    PVector target = waypoints[wayPointIndex + 1];
    
    if (target.x == pos.x) 
    {
      if (target.y > pos.y) 
      {
        pos.y = min(pos.y + speed, target.y);
      } else 
      {
        pos.y = max(pos.y - speed, target.y);
      }
    }
    else if (target.y == pos.y) 
    {
      if (target.x > pos.x) 
      {
        pos.x = min(pos.x + speed, target.x);
      } 
      else 
      {
        pos.x = max(pos.x - speed, target.x);
      }
    }

    if (pos.equals(target)) 
    {
      wayPointIndex++;
    }
  }
}
