class Chaser{
  float x=0;
  float y=0;
  float ranX=random(0,width);
  float ranY=random(0,height);
  float rad=50;
  float xAccel = 0.1;
  float yAccel = 0.1;
  float xSpeed=0;
  float ySpeed=0;
  
  Chaser(){
    if(canSpawn()){
      x = ranX;
      y = ranY;
    } else {
      x=random(0,player.x-50);
      y=random(0,player.y-50);
    }
    xSpeed = 0;
    ySpeed = 0;
  }
  
  void drawChaser(){
    image(chaseImg,x-(rad/2),y-(rad/2));
    noStroke();
    noFill();
    ellipse(x,y,rad,rad);
  }
  
  void chase(float shipX, float shipY){
    x = x + xSpeed;
    y = y + ySpeed;
    xSpeed = min(max(xSpeed + xAccel, -3),3);
    ySpeed = min(max(ySpeed + yAccel,-3),3);
    if(x < shipX && xAccel < 0 || x > shipX && xAccel > 0){
      xAccel = -xAccel + random(-0.05,0);
    }
    if(y < shipY && yAccel < 0 || y > shipY && yAccel > 0){
      yAccel = -yAccel + random(-0.05,0);
    } 
    //boundary check
    if(x < 0 && xSpeed < 0 || x > width && xSpeed > 0){
      xSpeed = -xSpeed;
    }
    if(y < 0 && ySpeed < 0 || y > height && ySpeed > 0){
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
  
  boolean canSpawn(){
    boolean good = true;
    if(ranX>player.x-50 && ranX<player.x+50){
      good = false;
    }
    if(ranY>player.y-50 && ranY<player.y+50){
      good = false;
    }
    return good;
  }
}