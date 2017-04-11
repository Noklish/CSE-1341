class Floater{
  float x=0;
  float y=0;
  float rad=50;
  float xSpeed=1;
  float ySpeed=1;
  float accel=0;
  
  Floater(){
    x = random(0,width);
    y = random(0,height);
    xSpeed = random(-1,1);
    ySpeed = random(-1,1);
  }
  
  Floater(float newX, float newY, float newRad){
    x=newX;
    y=newY;
    rad=newRad;
  }
  
  void drawHover(){
    fill(0,0,255);
    ellipse(x,y,rad,rad);
  }
  
  void hoverUpdate(){
    x=x+xSpeed;
    y=y+ySpeed;
    xSpeed = min(max(xSpeed + random(-1,1), -2),2);
    ySpeed = min(max(ySpeed + random(-1,1), -2),2);
    if (x < rad && xSpeed <0 || x > width-rad && xSpeed > 0) {
      xSpeed = -xSpeed;
    }
    if (y < rad && ySpeed <0 || y > height-rad && ySpeed > 0) {
      ySpeed = -ySpeed;
    }
  }
}