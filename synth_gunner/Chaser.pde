class Chaser{
  float x=0;
  float y=0;
  float rad=50;
  float xAccel = 1;
  float yAccel = 1;
  float xSpeed=0;
  float ySpeed=0;
  
  Chaser(){
    x = random(0,width);
    y = random(0,height);
    xSpeed = 0;
    ySpeed = 0;
  }
  
  Chaser(float newX, float newY, float newRad){
    x=newX;
    y=newY;
    rad=newRad;
  }
  
  void drawChaser(){
    fill(255,0,0);
    ellipse(x,y,rad,rad);
  }
  
  void chase(float shipX, float shipY){
    x = x + xSpeed;
    y = y + ySpeed;
    xSpeed = min(max(xSpeed + xAccel, -3),3);
    ySpeed = min(max(ySpeed + yAccel,-3),3);
    if(x < shipX && xAccel < 0 || x > shipX && xAccel > 0){
      xAccel = -xAccel;
    }
    if(y < shipY && yAccel < 0 || y > shipY && yAccel > 0){
      yAccel = -yAccel;
    }
  }
}