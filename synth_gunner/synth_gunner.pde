/*
Synth_Gunner: video game term project for CSE-1341
 Noah Schweser, April 2017
 Professor Donya Quick
 */


import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Ship player = new Ship(450, 450, 40);
ArrayList<Floater> floaters = new ArrayList<Floater>();
ArrayList<Panner> panners = new ArrayList<Panner>();
ArrayList<Chaser> chasers = new ArrayList<Chaser>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

AudioPlayer gunFire;
AudioPlayer menuTheme;
AudioPlayer barrageTheme;
AudioPlayer buildTheme;
Minim m;

//sprites
PImage chaseImg;
PImage panImg;
PImage floatImg;
PImage menubg;
PImage shipImg;
PImage shipUp;
PImage shipDown;
PImage shipLeft;
PImage shipRight;
//booleans
boolean menu = true;
boolean gameBarrage = false;
boolean gameBuild = false;
boolean dead = false;
boolean canFire = true;
//title screen
String title = "Synth Gunner";
String subtitle = "A game by Noah Schweser";
String bar = "Barrage";
String bui = "Build";
//grid production
float bgx = 0;
float bgy = 0;
float bgdim = 50;
//title boxes
float boxH = 100;
float boxW = 220;
float barX = 350;
float barY = 400;
float buiX = 350;
float buiY = 600;
//spawn functions
long minSpawn = 500;
long maxSpawn = 2000;
long spawn = 2000;
long refresh = 0;
int roundNumber = 0;

void setup() {
  size(900, 900);
  frameRate(30);
  menubg = loadImage("grid.jpg"); //Tron_Grid_Wallpaper_1680x1050 by Sarah-Hextall-Design on DeviantArt. Used without permission
  menubg.loadPixels();
  //sounds
  m = new Minim(this);
  gunFire = m.loadFile("science_fiction_laser_002.mp3");
  menuTheme = m.loadFile("Derezzed.wav");
  barrageTheme = m.loadFile("Battlefield.wav");
  buildTheme = m.loadFile("SwordofTruth.wav");
  //sprites
  chaseImg = toARGB(loadImage("chaser.bmp"));
  setTransparency(color(255), chaseImg);
  floatImg = toARGB(loadImage("floater.bmp"));
  setTransparency(color(255), floatImg);
  panImg = toARGB(loadImage("panner.bmp"));
  setTransparency(color(255), panImg);
  shipImg = toARGB(loadImage("ship.bmp"));
  setTransparency(color(255),shipImg);
  shipUp = toARGB(loadImage("ship.bmp"));
  setTransparency(color(255),shipUp);
  shipDown = toARGB(loadImage("shipDown.bmp"));
  setTransparency(color(255),shipDown);
  shipLeft = toARGB(loadImage("shipLeft.bmp"));
  setTransparency(color(255),shipLeft);
  shipRight = toARGB(loadImage("shipRight.bmp"));
  setTransparency(color(255),shipRight);
  //menu music
  menuTheme.rewind();
  menuTheme.play();
}

void draw() {
  if (menu) {
    titleScreen();
  } if (gameBarrage) {
    menuTheme.pause();
    grid();
    player.drawShip();
    player.refresh();
    barrage();
    if (player.isHit()) {
      gameBarrage=false;
      dead=true;
    }
  } else if (gameBuild) {
    menuTheme.pause();
    grid();
    player.drawShip();
    player.refresh();
    build();
    if (player.isHit()) {
      gameBuild=false;
      dead=true;
    }
  } if (dead) {
    barrageTheme.pause();
    buildTheme.pause();
    deathScreen();
  }
  fire();
  refresh++; //firing cap
}

void keyPressed() {
  if (key==' ') {
    if (dead) {
      menu = true;
      dead = false;
      gameBarrage = false;
      gameBuild = false;
      menuTheme.rewind();
      menuTheme.play();
    }
  }
  if (key=='s') {
    player.moveDown();
  } else if (key=='w') {
    player.moveUp();
  } else if (key=='a') {
    player.moveLeft();
  } else if (key=='d') {
    player.moveRight();
  }
  if (canFire) {
    if (keyCode==UP) {
      bullets.add(new Bullet(player.x, player.y));
      bullets.get(bullets.size()-1).shootUp();
      gunFire.rewind();
      gunFire.play();
      refresh = 0;
      canFire=false;
    } else if (keyCode==LEFT) {
      bullets.add(new Bullet(player.x, player.y));
      bullets.get(bullets.size()-1).shootLeft();
      gunFire.rewind();
      gunFire.play();
      refresh = 0;
      canFire=false;
    } else if (keyCode==DOWN) {
      bullets.add(new Bullet(player.x, player.y));
      bullets.get(bullets.size()-1).shootDown();
      gunFire.rewind();
      gunFire.play();
      refresh = 0;
      canFire=false;
    } else if (keyCode==RIGHT) {
      bullets.add(new Bullet(player.x, player.y));
      bullets.get(bullets.size()-1).shootRight();
      gunFire.rewind();
      gunFire.play();
      refresh = 0;
      canFire=false;
    }
  }
}

void keyReleased() {
  player.release();
}

void mousePressed(){
  if(mouseX>=barX && mouseX<=barX+boxW && mouseY>=barY && mouseY<=barY+boxH){
    spawn = millis() + spawn;
    menu=false;
    gameBarrage=true;
    barrageTheme.rewind();
    barrageTheme.play();
  }
  if(mouseX>=buiX && mouseX<=buiX+boxW && mouseY>=buiY && mouseY<=buiY+boxH){
    spawn = millis() + spawn;
    menu=false;
    gameBuild=true;
    buildTheme.rewind();
    buildTheme.play();
    roundNumber=0;
  }
}

void titleScreen() {
  image(menubg, 0, 0);
  fill(255, 90, 200);
  textSize(50);
  text(title, 300, 200);
  textSize(20);
  text(subtitle, 340, 250);
  stroke(255, 90, 200);
  fill(0,100,255);
  rect(barX,barY,boxW,boxH);
  rect(buiX,buiY,boxW,boxH);
  noStroke();
  fill(255, 90, 200);
  text(bar,barX+boxW/3,barY+boxH/2);
  text(bui,buiX+85,buiY+boxH/2);
}

void grid() {
  background(0);
  for (float bgx=0; bgx<width+bgdim; bgx=bgx+bgdim) {
    rect(bgx, bgy, bgdim, bgdim);
    for (int k=0; k<=width; k=k+1) {
      bgy=k*width/20;
      fill(0);
      stroke(0, 255, 255);
      rect(bgx, bgy, bgdim, bgdim);
    }
  }
}

void fire() {
  for (int i=0; i<bullets.size(); i++) {
    bullets.get(i).drawBullet();
    bullets.get(i).bulletUpdate();
    if (bullets.get(i).x < 0 || bullets.get(i).x > width) {
      bullets.remove(i);
    } else if (bullets.get(i).y < 0 || bullets.get(i).y > height) {
      bullets.remove(i);
    }
  }
  if (refresh>=15) {
    canFire = true;
  }
}

void deathScreen() {
  image(menubg, 0, 0);
  fill(255, 0, 0);
  textSize(100);
  int RNG;
  RNG = round(random(0, 100));
  if (RNG<=99) {
    text("Retire", (width/2)-120, height/2);
  } else {
    text("Youst", (width/2)-120, height/2);
  }
  textSize(20);
  text("press space to return to menu", (width/2)-110, (height/2)+30);
  for(int i=bullets.size()-1; i>=0; i--){
    if(bullets.size()>0){
      bullets.remove(i);
    }
  }
  for(int i=floaters.size()-1; i>=0; i--){
    if(floaters.size()>0){
      floaters.remove(i);
    }
  }
  for(int i=panners.size()-1; i>=0; i--){
    if(panners.size()>0){
      panners.remove(i);
    }
  }
  for(int i=chasers.size()-1; i>=0; i--){
    if(chasers.size()>0){
      chasers.remove(i);
    }
  }
  player.x=450;
  player.y=450;
}

void barrage() {
  int RNG;
  if (millis() > spawn) {
    RNG = round(random(0, 4));
    spawn = spawn + round(random(minSpawn, maxSpawn));
    if (RNG<2) {
      floaters.add(new Floater());
    } else if (RNG==2) {
      panners.add(new Panner());
    } else if (RNG>2) {
      chasers.add(new Chaser());
    }
  }
  enemyBehavior();
}

void build(){
  println(roundNumber);
  println(floaters.size());
  if(millis()>=spawn){
    if(floaters.size()==0 && panners.size()==0 && chasers.size()==0){
      roundNumber=roundNumber+1;
      if(roundNumber<=5){
        for(int i=1; i<=roundNumber; i++){
          floaters.add(new Floater());
        }
      } else if(roundNumber>5 && roundNumber<=10){
        for(int i=1; i<=roundNumber%5; i++){
          panners.add(new Panner());
        }
      } else if(roundNumber>10 && roundNumber<=15){
        for(int i=1; i<=roundNumber%5; i++){
          floaters.add(new Floater());
        }
        for(int i=2; i<=roundNumber%3; i++){
          panners.add(new Panner());
        }
      }
    }
  }
  enemyBehavior();
}

void enemyBehavior(){
  for (int i=floaters.size()-1; i>=0; i--) {
    floaters.get(i).drawHover();
    floaters.get(i).hoverUpdate();
    if (floaters.get(i).isHit()) {
      floaters.remove(i);
    }
  }
  for (int i=chasers.size()-1; i>=0; i--) {
    chasers.get(i).drawChaser();
    chasers.get(i).chase(player.x, player.y);
    if (chasers.get(i).isHit()) {
      chasers.remove(i);
    }
  }
  for (int i=panners.size()-1; i>=0; i--) {
    panners.get(i).drawPan();
    panners.get(i).panUpdate();
    if (panners.get(i).isHit()) {
      panners.remove(i);
    }
  }
}

//toARGB, setTransparency, and flip code taken from lectures by Donya Quick
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