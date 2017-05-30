class Population{
  Rocket[] individuals = new Rocket[popSize];
  float[] fitness = new float[popSize];
  float[] selectionArray = new float[popSize];
  FloatDict elitists = new FloatDict();
  
  void init(){
    for(int i = 0; i<popSize; i++){
      this.individuals[i] = new Rocket();
      this.individuals[i].init();
    }
  }
  
  void update(){
    for(int i = 0; i<popSize;i++){
      this.individuals[i].update();
    }
  }
  
  void show(){
    for(int i = 0; i<popSize;i++){
      this.individuals[i].show();
    }
  }
  
  void hitObstacle(Obstacle[] obstacles){
    for(int i = 0; i<popSize; i++){
      this.individuals[i].hitObstacle(obstacles);
    }
  }
  void reached(Target target){
    for(int i = 0; i<popSize;i++){
      this.individuals[i].reached(target);
    }
  }
  
  void calcFitness(Target target){
    float sum = 0;
    for(int i = 0; i<popSize;i++){
      this.fitness[i] = this.individuals[i].fitness(target);
      sum += fitness[i];
      this.selectionArray[i] = sum;
    }
    for(int i=0; i<popSize;i++){
      this.fitness[i]/=sum;
      this.selectionArray[i] /= sum;
    }
  }
  
  void calcElite(){
    for(int i =0; i<popSize;i++){
      this.elitists.set(str(i),fitness[i]);
    }
    this.elitists.sortValuesReverse();
    println(this.elitists);
  }
  
  Rocket[] getElite(int number){
    Rocket[] Elite = new Rocket[number];
    String[] keys = this.elitists.keyArray();
    for(int i=0;i<number;i++){
      Elite[i] = this.individuals[Integer.parseInt(keys[i])];
    }
    return Elite;
  }
  
  void reproduce(){
    Rocket[] nextGen = new Rocket[popSize];
    Rocket father = new Rocket();
    Rocket mother = new Rocket();
    int number = round(popSize*elitism);
    Rocket[] Elite = getElite(number);
    
    for(int i = 0; i<popSize; i++){
      
      if(i<number){
      nextGen[i] = new Rocket();
      nextGen[i].init();
      nextGen[i].dna = Elite[i].dna;
      }
      else if(i<round(popSize*(randomRate + elitism))){
        nextGen[i] = new Rocket();
        nextGen[i].init();
      }
      else{
        float decision_dad = random(1);
        float decision_mom = random(1);
        boolean dadMissing = true;
        boolean momMissing = true;
        for(int j = 0;j<popSize;j++){
          if((decision_dad<selectionArray[j]) && dadMissing){
            father = this.individuals[j];
            dadMissing = false;
          }
          if((decision_mom<random(1)) && momMissing){
            mother = this.individuals[j];
            momMissing = false;
          }
        }
        nextGen[i] = father.crossover(mother);
        nextGen[i].dna.mutate(0.05);
      }
    }
    
    this.individuals = nextGen;
    
  }
  
  
}