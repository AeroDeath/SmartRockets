class Target{
  PVector loc = new PVector();
  int diameter = 50;
  
  void init(int x,int y){
    this.loc.x = x;
    this.loc.y = y;
  }
  void show(){
    fill(255);
    ellipse(this.loc.x, this.loc.y, this.diameter, this.diameter);
  }
}