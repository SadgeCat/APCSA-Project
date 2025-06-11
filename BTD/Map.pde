import java.util.Arrays;

class Map{
  private ArrayList<Path> maps = new ArrayList<Path>();
  
  public Map(){
    ArrayList<PVector> a1 = new ArrayList<PVector>(Arrays.asList(
      new PVector(0, 400),
      new PVector(100, 400),
      new PVector(100, 600),
      new PVector(500, 600),
      new PVector(500, 100),
      new PVector(700, 100),
      new PVector(700, 400),
      new PVector(1000, 400)
    ));
    ArrayList<PVector> a2 = new ArrayList<PVector>(Arrays.asList(
      new PVector(0, 200),
      new PVector(300, 200),
      new PVector(300, 500),
      new PVector(600, 500),
      new PVector(600, 300),
      new PVector(800, 300),
      new PVector(800, 600),
      new PVector(1000, 600)
    ));
    ArrayList<PVector> a3 = new ArrayList<PVector>(Arrays.asList(
      new PVector(0, 100),
      new PVector(150, 100),
      new PVector(150, 300),
      new PVector(400, 300),
      new PVector(400, 700),
      new PVector(900, 700),
      new PVector(900, 200),
      new PVector(1000, 200)
    ));
    ArrayList<PVector> a4 = new ArrayList<PVector>(Arrays.asList(
      new PVector(0, 500),
      new PVector(200, 500),
      new PVector(200, 100),
      new PVector(450, 100),
      new PVector(450, 400),
      new PVector(850, 400),
      new PVector(850, 300),
      new PVector(1000, 300)
    ));
    ArrayList<PVector> a5 = new ArrayList<PVector>(Arrays.asList(
      new PVector(0, 300),
      new PVector(100, 300),
      new PVector(100, 600),
      new PVector(300, 600),
      new PVector(300, 200),
      new PVector(600, 200),
      new PVector(600, 500),
      new PVector(1000, 500)
    ));
    
    maps.add(new Path(a1));
    maps.add(new Path(a2));
    maps.add(new Path(a3));
    maps.add(new Path(a4));
    maps.add(new Path(a5));
  }
  
  public ArrayList<Path> getMaps(){
    return maps;
  }

}
