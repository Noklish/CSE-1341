
Ship player = new Ship(450,450,50);
Floater[] floaters = new Floater[5];
PanEnemy[] pans = new PanEnemy[10];
Chaser[] chasers = new Chaser[5];

void setup(){
  size(900,900);
    for (int i=0; i<floaters.length; i++) {
    pans[i] = new PanEnemy();
    floaters[i] = new Floater();
    chasers[i] = new Chaser();
  }
}

void draw(){
  background(0);
  player.drawShip();
  player.refresh();
  for (int i=0; i<floaters.length; i++) {
    pans[i].drawPan();
    pans[i].panUpdate();
    floaters[i].drawHover();
    floaters[i].hoverUpdate();
    chasers[i].drawChaser();
    chasers[i].chase(player.x,player.y);
  }
}

void keyPressed(){
  if(key=='s'){
    player.moveDown();
  }
  if(key=='w'){
    player.moveUp();
  }
  if(key=='a'){
    player.moveLeft();
  }
  if(key=='d'){
    player.moveRight();
  }
}

void keyReleased(){
    player.release();
}