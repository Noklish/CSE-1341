class Ship{
  float x=0;
  float y=0;
  float rad=40;
  float theta=0;
  float xSpeed=0;
  float ySpeed=0;
  boolean s = false;
  boolean w = false;
  boolean a = false;
  boolean d = false;
  
  Ship(float newX, float newY, float nRad){
    x=newX;
    y=newY;
    rad=nRad;
  }
  
  void drawShip(){
    noFill();
    noStroke();
    ellipse(x,y,rad,rad);
    image(shipImg, x-(rad/2), y-(rad/2));
    x=x+xSpeed;
    y=y+ySpeed;
  }
  
  void moveDown(){
    s = true;
    shipImg=shipDown;
  }
  
  void moveUp(){
    w = true;
    shipImg=shipUp;
  }
  
  void moveLeft(){
    a = true;
    shipImg=shipLeft;
  }
  
  void moveRight(){
    d = true;
    shipImg=shipRight;
  }
  
  void refresh(){
    if(s){
      ySpeed=5;
    } else if(w){
      ySpeed=-5;
    } else if(a){
      xSpeed=-5;
    } else if(d){
      xSpeed=5;
    } else if(s==false && w==false && a==false && d==false){
      xSpeed=0;
      ySpeed=0;
    }
    
    //boundary check
    if(x<0 && xSpeed<0){
      x=0;
    } if(x>width && xSpeed>0){
      x=width;
    } if(y<0 && ySpeed<0){
      y=0;
    } if(y>height && ySpeed>0){
      y=height;
    }
  }
  
  void release(){
    s = false;
    w = false;
    a = false;
    d = false;
  }
  
  boolean isHit(){
    boolean hit = false;
    for(int i=floaters.size()-1; i>=0; i--){
      float r = sqrt(pow(floaters.get(i).x-x,2)+pow(floaters.get(i).y-y,2));
      if(r<rad){
        hit = true;
      }
    }
    for(int i=panners.size()-1; i>=0; i--){
      float r = sqrt(pow(panners.get(i).x-x,2)+pow(panners.get(i).y-y,2));
      if(r<rad){
        hit = true;
      }
    }
    for(int i=chasers.size()-1; i>=0; i--){
      float r = sqrt(pow(chasers.get(i).x-x,2)+pow(chasers.get(i).y-y,2));
      if(r<rad){
        hit = true;
      }
    }
    return hit;
  }
}