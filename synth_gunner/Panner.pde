class Panner{
  float x=0;
  float y=0;
  float rad=50;
  float xSpeed=1;
  float ySpeed=1;
  
  Panner(){
    x = 0;
    y = random(0,height);
    xSpeed = random(3,5);
    ySpeed = random(3,5);
    if(x<player.x-(player.rad/2) && x>player.x+(player.rad/2)){
      x=0;
    }
    if(y<player.y-(player.rad/2) && y>player.y+(player.rad/2)){
      y=random(0,height);
    }
  }
  
  Panner(float newX, float newY, float newRad){
    x=newX;
    y=newY;
    rad=newRad;
  }
  
  void drawPan(){
    image(panImg,x-(rad/2),y-(rad/2));
    noStroke();
    noFill();
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

  boolean isHit(){
    boolean hit = false;
    for(int i=bullets.size()-1; i>=0; i--){
      float r = sqrt(pow(bullets.get(i).x-x,2)+pow(bullets.get(i).y-y,2));
      if(r<rad-10){
        hit = true;
        bullets.remove(i);
      }
    }
    return hit;
  }
}