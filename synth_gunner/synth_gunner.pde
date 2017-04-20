import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

/*
Synth_Gunner: video game term project for CSE-1341
 Noah Schweser, April 2017
 Professor Donya Quick
 */

Ship player = new Ship(450, 450, 50);
Floater[] floaters = new Floater[10];
Panner[] pans = new Panner[5];
Chaser[] chasers = new Chaser[5];
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

AudioPlayer gunFire;
Minim m;

PImage menubg;
boolean menu = true;
String title = "Synth Gunner";
String subtitle = "A game by Noah Schweser";
float bgx = 0;
float bgy = 0;
float bgdim = 50;

void setup() {
  size(900, 900);
  menubg = loadImage("grid.jpg"); //Tron_Grid_Wallpaper_1680x1050 by Sarah-Hextall-Design on DeviantArt. Used without permission
  menubg.loadPixels();
  m = new Minim(this);
  gunFire = m.loadFile("science_fiction_laser_002.mp3");
  for (int i=0; i<pans.length; i++) {
    pans[i] = new Panner();
  }
  for (int i=0; i<floaters.length; i++) {
    floaters[i] = new Floater();
  }
  for (int i=0; i<chasers.length; i++) {
    chasers[i] = new Chaser();
  }
  for (int i=0; i<bullets.size(); i++){
    bullets.get(i).drawBullet();
    bullets.get(i).bulletUpdate();
  }
}

void draw() {
  if (menu) {
    titleScreen();
  } else {
    background(0);
    for(float bgx=0; bgx<width+bgdim; bgx=bgx+bgdim){
      rect(bgx,bgy,bgdim,bgdim);
      for(int k=0; k<=width; k=k+1){
        bgy=k*width/20;
        fill(0);
        stroke(0,255,255);
        rect(bgx,bgy,bgdim,bgdim);
      }
    }
    player.drawShip();
    player.refresh();
    /*for (int i=0; i<pans.length; i++) {
       pans[i].drawPan();
       pans[i].panUpdate();
    }
    for (int i=0; i<floaters.length; i++){
      floaters[i].drawHover();
      floaters[i].hoverUpdate();
    }
    for (int i=0; i<chasers.length; i++){
      chasers[i].drawChaser();
      chasers[i].chase(player.x,player.y);
    }*/
    for (int i=0; i<bullets.size(); i++){
      bullets.get(i).drawBullet();
      bullets.get(i).bulletUpdate();
      if(bullets.get(i).x < 0 || bullets.get(i).x > width){
        bullets.remove(i);
      } else if(bullets.get(i).y < 0 || bullets.get(i).y > height){
        bullets.remove(i);
      }
    }
  }
}

void keyPressed() {
  if (key==' ') {
    if (menu) {
      menu=false;
    }
  }
  if (key=='s') {
    player.moveDown();
  }
  if (key=='w') {
    player.moveUp();
  }
  if (key=='a') {
    player.moveLeft();
  }
  if (key=='d') {
    player.moveRight();
  }
  if(keyCode==UP){
    bullets.add(new Bullet(player.x, player.y));
    bullets.get(bullets.size()-1).shootUp();
    gunFire.rewind();
    gunFire.play();
  }
  if(keyCode==LEFT){
    bullets.add(new Bullet(player.x, player.y));
    bullets.get(bullets.size()-1).shootLeft();
    gunFire.rewind();
    gunFire.play();
  }
  if(keyCode==DOWN){
    bullets.add(new Bullet(player.x, player.y));
    bullets.get(bullets.size()-1).shootDown();
    gunFire.rewind();
    gunFire.play();
  }
  if(keyCode==RIGHT){
    bullets.add(new Bullet(player.x, player.y));
    bullets.get(bullets.size()-1).shootRight();
    gunFire.rewind();
    gunFire.play();
  }
}

void keyReleased() {
  player.release();
}

void titleScreen(){
  image(menubg,0,0);
  fill(255, 90, 200);
  textSize(50);
  text(title, 300, 200);
  textSize(20);
  text(subtitle, 340, 250);
}