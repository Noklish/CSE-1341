class PanEnemy{
  float x=0;
  float y=0;
  float rad=50;
  float xSpeed=1;
  float ySpeed=1;
  
  PanEnemy(){
    x = 0;
    y = random(0,height);
    xSpeed = random(1,3);
    ySpeed = random(1,3);
  }
  
  PanEnemy(float newX, float newY, float newRad){
    x=newX;
    y=newY;
    rad=newRad;
  }
  
  void drawPan(){
    fill(200,50,0);
    ellipse(x,y,rad,rad);
  }
  
  void panUpdate(){
    x=x+xSpeed;
    if (x < rad && xSpeed <0 || x > width-rad && xSpeed > 0) {
      xSpeed = -xSpeed;
    }
    if (y < rad && ySpeed <0 || y > height-rad && ySpeed > 0) {
      ySpeed = -ySpeed;
    }
  }
}