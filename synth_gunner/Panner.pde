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
  
  //toARGB and setTransparency code taken from a lecture by Donya Quick
  PImage toARGB(PImage orig) {
    PImage newImg = createImage(orig.width, orig.height, ARGB);
    for (int i=0; i<orig.pixels.length; i++) {
      newImg.pixels[i]=orig.pixels[i];
    }
    return newImg;
  }
  
  void setTransparency(color c, PImage x) {
    for (int i=0; i<x.pixels.length; i++) {
      if (x.pixels[i]==c) {
        x.pixels[i]=color(0, 0);
      }
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