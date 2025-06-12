class Path{
  private ArrayList<PVector> waypoints = new ArrayList<PVector>();
  
  public Path(ArrayList<PVector> wpts){
    //waypoints.add(new PVector(0,400));
    
    //waypoints.add(new PVector(100,400));
    //waypoints.add(new PVector(100,600));
    //waypoints.add(new PVector(500,600));
    //waypoints.add(new PVector(500,100));
    //waypoints.add(new PVector(700,100));
    //waypoints.add(new PVector(700,400));
    
    //waypoints.add(new PVector(1000,400));
    
    waypoints = wpts;
  }
  
  public ArrayList<PVector> getWayPts(){
    return waypoints;
  }
  
  public void display(){
    stroke(36, 61, 43);
    strokeWeight(40);
    noFill();
    beginShape();
    for(PVector p : waypoints){
      vertex(p.x, p.y);
    }
    endShape();
    strokeWeight(0);
  }
}