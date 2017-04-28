class Floater{
  float x=0;
  float y=0;
  float dim=40;
  float xSpeed=1;
  float ySpeed=1;
  float accel=0;
  
  Floater(){
    x = random(0,width);
    y = random(0,height);
    xSpeed = random(-1,1);
    ySpeed = random(-1,1);
    if(x<player.x-(player.rad/2) && x>player.x+(player.rad/2)){
      x=0;
    }
    if(y<player.y-(player.rad/2) && y>player.y+(player.rad/2)){
      y=0;
    }
  }
  
  Floater(float newX, float newY, float newDim){
    x=newX;
    y=newY;
    dim=newDim;
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
}