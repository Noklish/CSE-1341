class Ship{
  float x=0;
  float y=0;
  float rad=50;
  float theta=0;
  float speed=5;
  boolean s = false;
  boolean w = false;
  boolean a = false;
  boolean d = false;
  
  Ship(){
    
  }
  
  Ship(float newX, float newY, float nRad){
    x=newX;
    y=newY;
    rad=nRad;
  }
  
  void drawShip(){
    fill(255);
    ellipse(x,y,rad,rad);
  }
  
  void moveDown(){
    s = true;
  }
  
  void moveUp(){
    w = true;
  }
  
  void moveLeft(){
    a = true;
  }
  
  void moveRight(){
    d = true;
  }
  
  void refresh(){
    if(s){
      y=y+speed;
    } else if(w){
      y=y-speed;
    } else if(a){
      x=x-speed;
    } else if(d){
      x=x+speed;
    }
  }
  
  void release(){
    s = false;
    w = false;
    a = false;
    d = false;
  }
}