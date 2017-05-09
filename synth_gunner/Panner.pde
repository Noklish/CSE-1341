class Panner{
  float x=0;
  float y=0;
  float ranX=0;
  float ranY=random(0,height);
  float rad=50;
  float xSpeed=1;
  float ySpeed=1;
  
  Panner(){
    if(canSpawn()){
      x = 0;
      y = ranY;
    } else {
      x=0;
      y=random(0,player.y-50);
    }
    xSpeed = random(3,5);
    ySpeed = random(3,5);
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