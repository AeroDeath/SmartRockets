class Rocket{
  PVector pos = new PVector(0,0);
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  DNA dna = new DNA();
  int age = 0;
  boolean alive = true;
  boolean isDestroyed = false;
  
  
  void init(){
    this.dna.init();
    this.pos.x = width/2;
    this.pos.y = height;
    this.acc.x = 0;
    this.acc.y = 0;
  }
  
  void impulse(PVector force){
    this.acc.add(force);
  }
  
  void update(){
    if(this.age == lifespan){
      this.age = 0;
    }
    if(this.alive){
      this.impulse(this.dna.genes[this.age]);
      this.age++;
    }
    else{
      this.vel.mult(0);
      this.acc.mult(0);
    }
    this.vel.add(acc);
    this.pos.add(vel);
    this.acc.mult(0);
  }
  
  void show(){
    pushMatrix();
    fill(150, 150);
    noStroke();
    translate(this.pos.x, this.pos.y);
    rotate(this.vel.heading());
    rect(0, 0, 50, 10);
    popMatrix();
  }
  
  void reached(Target target){
    if(this.pos.dist(target.loc) < target.diameter/2){
      this.alive = false;
    }
  }
  
  void hitObstacle(Obstacle[] obstacles){
    for(int i = 0; i<obstacles.length; i++){
      if(this.pos.x>obstacles[i].loc.x-obstacles[i].len/2&&this.pos.x<obstacles[i].loc.x+obstacles[i].len/2&&this.pos.y>obstacles[i].loc.y-obstacles[i].wide/2&&this.pos.y<obstacles[i].loc.y+obstacles[i].wide/2){
        this.alive = false;
        this.isDestroyed = true;
      }
    }
  }
  
  float fitness(Target target){
    if (this.alive){
      return lifespan - this.age + (1/pow(this.pos.dist(target.loc),2));
    }
    else if(this.isDestroyed){
      return ((1/pow(this.pos.dist(target.loc),2)))*0.1;
    }
    else{
      return lifespan - this.age;
    }
  }
  
  Rocket crossover(Rocket parent){
    Rocket child = new Rocket();
    child.init();
    for(int i = 0; i<lifespan;i++){
      if(random(1.0)<0.5){
        child.dna.genes[i] = this.dna.genes[i];
      }
      else{
        child.dna.genes[i] = parent.dna.genes[i];
      }
    }
    return child;
  }
  
  
}