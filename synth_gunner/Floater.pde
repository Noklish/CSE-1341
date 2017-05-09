class Floater{
  float x=0;
  float y=0;
  float ranX=random(0,width);
  float ranY=random(0,height);
  float dim=40;
  float xSpeed=1;
  float ySpeed=1;
  float accel=0;
  
  Floater(){
    if(canSpawn()){
      x = ranX;
      y = ranY;
    } else {
      x=random(0,player.x-50);
      y=random(0,player.y-50);
    }
    xSpeed = random(-1,1);
    ySpeed = random(-1,1);
  }
  
  void drawHover(){
    image(floatImg,x-(dim/2),y-(dim/2));
    noStroke();
    noFill();
    ellipse(x,y,dim,dim);
  }
  
  void hoverUpdate(){
    x=x+xSpeed;
    y=y+ySpeed;
    xSpeed = min(max(xSpeed + random(-1,1), -2),2);
    ySpeed = min(max(ySpeed + random(-1,1), -2),2);
    //boundary check
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
      if(r<dim-10){
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