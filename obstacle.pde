class Obstacle{
  PVector loc = new PVector(0,0);
  float len = 0;
  float wide = 0;
  
  void init(float wide, float len){
    this.loc.x = width/2;
    this.loc.y = height/2;
    this.wide = wide;
    this.len = len;
  }
  
  void show(){
    pushMatrix();
    fill(150,0,0,150);
    rectMode(CENTER);
    rect(this.loc.x, this.loc.y, this.len, this.wide);
    popMatrix();
  }
}