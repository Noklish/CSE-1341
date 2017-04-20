class Ship{
  float x=0;
  float y=0;
  float rad=50;
  float theta=0;
  float xSpeed=0;
  float ySpeed=0;
  boolean s = false;
  boolean w = false;
  boolean a = false;
  boolean d = false;
  
  Ship(){
    
  }
  
  Ship(float newX, float newY, float nRad){
    x=newX;
    y=newY;
    rad=nRad;
  }
  
  void drawShip(){
    fill(255);
    ellipse(x,y,rad,rad);
    x=x+xSpeed;
    y=y+ySpeed;
  }
  
  void moveDown(){
    s = true;
  }
  
  void moveUp(){
    w = true;
  }
  
  void moveLeft(){
    a = true;
  }
  
  void moveRight(){
    d = true;
  }
  
  void refresh(){
    if(s){
      ySpeed=5;
    } if(w){
      ySpeed=-5;
    } if(a){
      xSpeed=-5;
    } if(d){
      xSpeed=5;
    } if(s==false && w==false && a==false && d==false){
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
}