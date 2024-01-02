Ball b;
PVector velocity;
float t;
float ay = 500;
float ax = 500;

void setup(){
  size(800,800);
  b = new Ball(width/2, 100, 30);
  t = 1;
  velocity = new PVector(ax, ay);
  frameRate(15);
}

void draw(){
  background(0);
  b.display();
  b.updatePos(velocity);
  t+=(1/60);
  velocityUpdate(t);
  int crushed = isCrush(b);
  if(crushed>0){
    if(crushed ==1){
      float newAx = -1 * 0.9 * velocity.x;
      float newAy = 0.9 * velocity.y;
      velocityReset(newAx, newAy);
      println(velocity.x);
    }
    else if(crushed ==2){
      float newAx = 0.9 * velocity.x;
      float newAy = -1* 0.9 * velocity.y;
      velocityReset(newAx, newAy);
      println(velocity.y);
    }
  }
  friction();
}

class Ball{
  PVector pos;
  float radius;
  Ball(float xloc, float yloc, float r){
    pos = new PVector(xloc, yloc);
    radius = r;
  }
  void display(){
    fill(255);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  void updatePos(PVector velocity){
    if((pos.x + velocity.x) > width-radius) pos.x = width-radius;
    else if( (pos.x + velocity.x) < radius) pos.x = radius;
    else pos.x = pos.x + velocity.x;
    
    if((pos.y + velocity.y) > height-radius) pos.y = height-radius;
    else if( (pos.y + velocity.y) < radius) pos.y = radius;
    else pos.y = pos.y + velocity.y;
  }
  
  void resetPos(){
    pos.x = width/2;
    pos.y = height*0.2;
  }
};

void velocityUpdate(float t){
   velocity.x = velocity.x * t;
   velocity.y = velocity.y * t;
}

void velocityReset( float ax, float ay){
  velocity.x = ax;
  velocity.y = ay;
}

void friction(){
  if(velocity.x > 0 && velocity.x > 0.1*9.8) velocity.x -= 0.4*9.8*t;
  else if(velocity.x <0 && velocity.x < -0.1*9.8) velocity.x += 0.4*9.8*t;
  else velocity.x = 0;
  
  if(velocity.y > 0 && velocity.y > 0.1* 9.8) velocity.y -= 0.4*9.8*t;
  else if(velocity.y <0 && velocity.y < -01*9.8) velocity.y += 0.4*9.8*t;
  else velocity.y = 0;
}

int isCrush(Ball b){
  if(b.pos.x >= width-b.radius || b.pos.x <= b.radius){
    return 1;
  }
  else if(b.pos.y >= height-b.radius || b.pos.y <= b.radius){
    return 2;
  }
  else return 0;
}
