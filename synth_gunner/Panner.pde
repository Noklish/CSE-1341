class Panner{
  float x=0;
  float y=0;
  float rad=50;
  float xSpeed=1;
  float ySpeed=1;
  
  Panner(){
    x = 0;
    y = random(0,height);
    xSpeed = random(1,3);
    ySpeed = random(1,3);
  }
  
  Panner(float newX, float newY, float newRad){
    x=newX;
    y=newY;
    rad=newRad;
  }
  
  void drawPan(){
    fill(255,150,0);
    ellipse(x,y,rad,rad);
  }
  
  void panUpdate(){
    x=x+xSpeed;
    if (x < 0 && xSpeed < 0 || x > width && xSpeed > 0) {
      xSpeed = -xSpeed;
    }
    if (y < 0 && ySpeed < 0 || y > height && ySpeed > 0) {
      ySpeed = -ySpeed;
    }
  }
}