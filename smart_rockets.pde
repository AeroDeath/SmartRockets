//TO DO INTEGRATE MUTATION, ADD ELITISM

Target target = new Target();
float crossoverRate = 0.6;
float randomRate = 0.3;
float elitism = 0.1;
int lifespan = 600;
int popSize = 100;
float force_scale = 0.3;
int age = 0;
int generation = 0;
Rocket Rock = new Rocket();
Population armada = new Population();
Obstacle[] obstacles = new Obstacle[1];

void setup(){
  size(1280, 960);
  armada.init();
  target.init(width/2, 0);
  for(int i =0; i<obstacles.length;i++){
    obstacles[i] = new Obstacle();
    obstacles[i].init(100,1000);
  }
}

void draw(){
  background(0);
  obstacles[0].show();
  target.show();
  armada.update();
  armada.show();
  armada.hitObstacle(obstacles);
  armada.reached(target);
  age = age + 1;
  if(age == lifespan){
    armada.calcFitness(target);
    armada.calcElite();
    println(armada.selectionArray);
    armada.reproduce();
    age = 0;
  }
}