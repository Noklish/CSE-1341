class Bullet{
  float x = 0;
  float y = 0;
  float rad = 10;
  float xSpeed = 0;
  float ySpeed = 0;
  
  Bullet(float newX, float newY){
    x=newX;
    y=newY;
  }
  
  void drawBullet(){
    fill(0,255,0);
    ellipse(x,y,rad,rad);
  }
  
  void bulletUpdate(){
    x=x+xSpeed;
    y=y+ySpeed;
  }
  
  void shootDown(){
    xSpeed = 0;
    ySpeed = 5;
  }
  
  void shootRight(){
    ySpeed = 0;
    xSpeed = 5;
  }
  
  void shootUp(){
    xSpeed = 0;
    ySpeed = -5;
  }
  
  void shootLeft(){
    ySpeed = 0;
    xSpeed = -5;
  }
}