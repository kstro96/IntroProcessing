/*
    =>Codigo realizado por Alejandro Castro Martinez 
 - email: alejokstro08@gmail.com
 Ingenieria de Sistemas y Electronica
 Introduccion al ambiente de programacion de Processing
 
 Ultima modificacion: 23/08/2017 Version: 1.0
 
 Funcionalidades del sistema: 
 *Movimiento del mouse al clickear y arrastrar
 *Click del mouse sobre la pantalla
 *Teclas de desplazamiento (Arriba, abajo, izquierda, derecha)
 *Teclas w, a, s, d (WASD)
 *Tecla r o Tecla R
 *Tecla c o Tecla C
 *Tecla p o Tecla P
 
 
 */
color bcolor = color(51, 51, 51); 
color ellipseColor = color(200, 100, 10);
color triangleColor = color(0, 100, 200);
color boxColor = color(250, 0, 0);
color sphere1 = color(50, 150, 250);

color sphere2 = color(150, 250, 50);
color sphere3 = color(250, 50, 150);

float translateX = 0;
float translateY = 0;
float distance = 0;

boolean mode = false;
boolean play = false;

float sphereCount = 1;

float sensibility3D = 0.01;
float sensibility2D = 0.5;
float animationRate = 0.1;

PVector p1 = new PVector(20,20);
PVector p2 = new PVector(100,40);
PVector p3 = new PVector(20,100);

void setup() {
  size (900, 650, P3D);
}

void draw() {
  background(bcolor);
  if (!mode) {
    translate(translateX, translateY, -distance);
    fill(ellipseColor);
    stroke(255);
    ellipse(width/2, height/2, 550, 550);
    if (play) {
      float deltaX = (pmouseX-mouseX);
      float deltaY = (pmouseY-mouseY);
      fill(triangleColor);
      triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
      p1.x -= deltaX;
      p2.x -= deltaX;
      p3.x -= deltaX;
      p1.y -= deltaY;
      p2.y -= deltaY;
      p3.y -= deltaY;
    } else {
      fill(triangleColor);
      triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
    }
  } else {
    translate(width/2, height/2, -distance);
    rotateX(-translateY);
    rotateY(translateX);
    noFill();
    stroke(boxColor);
    box(400);
    if (!play) {
      drawSphere1(1);
      drawSphere1(-1);
      drawSphere2(1);
      drawSphere2(-1);
      drawSphere3(1);
      drawSphere3(-1);
    } else {
      int sphere = (int)sphereCount;
      switch(sphere) {
      case 1:
        drawSphere1(1);
        break;
      case 2:
        drawSphere1(-1);
        break;
      case 3:
        drawSphere2(1);
        break;
      case 4:
        drawSphere2(-1);
        break;
      case 5:
        drawSphere3(1);
        break;
      case 6:
        drawSphere3(-1);
        break;
      }
      sphereCount += animationRate;
      if (sphereCount >= 7)
        sphereCount = 1;
    }
  }
}

void drawSphere1(int in) {
  pushMatrix();
  translate(0, 100*in);
  stroke(sphere1);
  sphere(100);
  popMatrix();
}
void drawSphere2(int in) {
  pushMatrix();
  translate(100*in, 0);
  stroke(sphere2);
  sphere(100);
  popMatrix();
}
void drawSphere3(int in) {
  pushMatrix();
  translate(0, 0, 100*in);
  stroke(sphere3);
  sphere(100);
  popMatrix();
}
void mouseDragged() {
  if (mode) {
    translateX += (mouseX-pmouseX)*sensibility3D;
    translateY += (mouseY-pmouseY)*sensibility3D;
  } else {
    translateX += (mouseX-pmouseX)*sensibility2D;
    translateY += (mouseY-pmouseY)*sensibility2D;
  }
}

/*
  Funcion para el control de rotacion dado 
 por el teclado
 */
void keyPressed() {
  if (keyCode == UP) {
    distance -= 10;
  }
  if (keyCode == DOWN) {
    distance += 10;
  }
  if (keyCode == RIGHT) {
    if (mode)
      translateX += sensibility3D;
    else
      translateX += sensibility2D*10;
  }
  if (keyCode == LEFT) {
    if (mode)
      translateX -= sensibility3D;
    else
      translateX -= sensibility2D*10;
  }
  if (keyCode == 'R' || keyCode == 'r') {
    translateX = 0;
    translateY = 0;
    distance = 0;
  }
  if (keyCode == 'W' || keyCode == 'w') {
    distance -= 50;
  }
  if (keyCode == 'S' || keyCode == 's') {
    distance += 50;
  }
  if (keyCode == 'D' || keyCode == 'd') {
    if (mode)
      translateX += sensibility3D*5;
    else
      translateX += sensibility2D*20;
  }
  if (keyCode == 'A' || keyCode == 'a') {
    if (mode)
      translateX += sensibility3D*5;
    else
      translateX -= sensibility2D*20;
  }
  if (keyCode == 'C' || keyCode == 'c') {
    mode = !mode;
    translateX = 0;
    translateY = 0;
    distance = 0;
    play = false;
    PVector ran = PVector.random2D();
    ran = new PVector(abs(ran.x),abs(ran.y));
    p1 = PVector.mult(ran,random(0, width-100));
    p2 = PVector.add(p1,new PVector(80,20));
    p3 = PVector.add(p1,new PVector(0,80));
  }
  if (keyCode == 'P' || keyCode == 'p') {
    play = !play;
  }
}
void mouseClicked(){
  play = !play;
}