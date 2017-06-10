class DNA{
  PVector[] genes = new PVector[lifespan];
  
  void init(){
    for(int i =0; i<this.genes.length; i++){
    this.genes[i] = PVector.random2D().setMag(force_scale);
    }
  }
  
  void mutate(float mutationRate){
    for(int i = 0;i<this.genes.length;i++){
      if(random(1)<mutationRate){
        this.genes[i] = PVector.random2D().setMag(force_scale);
      }
    }
  }
  
}