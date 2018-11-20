import processing.video.*;
import java.awt.*;

Capture video;
PImage imagen, L_Filtro, camara, guardar, filtro, salir, guardarF;
PImage letra, pixel, burbuja;
int pantalla = 0;
float progressBar = 0;
int timerSet;
 

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  
  timerSet = millis();
  L_Filtro = loadImage("data/logocamFiltro.png");
  
  guardar = loadImage("data/png/save.png");
  filtro = loadImage("data/png/filtro.png");
  guardarF = loadImage("data/png/saveF.png");
  camara = loadImage("data/png/camara.png");
  salir = loadImage("data/png/salir.png");
  
  letra = loadImage("data/png/letras.png");
  pixel = loadImage("data/png/pixel.png");
  burbuja = loadImage("data/png/burbuja.png");

  video.start();
}

void draw() {

  if(pantalla == 0)  
    inicio_Op0();
    
  if(pantalla == 1)
    camara_Op1();
  
  if(pantalla == 2){
    filtro_Op2();  
    image(L_Filtro,500,340);
  }
  
   if(key == 'g'){
    save("captura.jpg");
    key = 0;
    println("¡Foto guardada!");
  }
  
  if(key == 'x')
    exit();
    
}


void captureEvent(Capture c) {
  c.read();
}


void camara_Op1(){
  scale(2);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  
  if(key == 't')
    pantalla = 2;    
  
  println("Tomando foto...");
}

void filtro_Op2(){
  imagen = loadImage("captura.jpg");

  for (int i = 0; i <imagen.width; i+=10){
    for (int j = 0; j <imagen.height; j+=10){
      
      int c = imagen.get(i,j);    
      fill(c);
      noStroke();
      
      if(key == '1'){
        rect(i,j,22,22);
        println("Filtro: Pixel");
      }
      
      if(key == '2'){
        ellipse(i,j,20,20);
        println("Filtro: Burbuja");
      }
      
      if(key == '3'){
        boolean ASD = true;
        if(ASD){
          textSize(60);
          text(char(ceil(random(65,127))),i,j);  
          ASD = false;
          println("Filtro: Sopa de Letras");
        }
      }
      
    }
  }

  if(key == 'f')
  pantalla = 1;
}

void inicio_Op0(){  
  background(255);
  image(L_Filtro,270,20);
  fill(0);
  textSize(15);
  text("INTRUCCIONES:",110,170);
  text("FILTROS:",470,170);
  
  textSize(12);
  image(guardar,50,180);
  text("1. Guardar: Tecla G",50,230);
  
  image(filtro,50,250);
  text("2. Filtros: Tecla T & 1 - 2 - 3",50,300);
  
  image(guardarF,50,320);
  text("3. Guardar Filtro: Tecla G" ,50,370);
  
  image(camara,250,180);
  text("4. Regresar: Tecla F",250,230);
  
  image(salir,250,250);
  text("5. Salir: Tecla E",250,300);
  
  image(pixel,450,180);
  text("Pixel - Tecla 1",450,230);
  
  image(burbuja,450,250);
  text("Burbuja: Tecla 2",450,300);
  
  image(letra,450,320);
  text("Sopa de Letras: Tecla 3",450,370);
  
  if(progressBar < 500){
    if(progressBar == 50 || progressBar == 200 || progressBar == 350 || progressBar == 500)
          text("Cargando la magia.",500,440);
    if(progressBar == 100 || progressBar == 250 || progressBar == 400)
          text("Cargando la magia..",500,440);
    if(progressBar == 150 || progressBar == 300 || progressBar == 450)
          text("Cargando la magia...",500,440);
  }
  else{
     text("Presiona ENTER",500,440);
  }
  
  if ( (millis() > timerSet + 1000 ) && (progressBar < 500)) {
    progressBar += 50;    
    timerSet = millis();
  }
  print("Tiempo ");
  println(timerSet / 1000);
  print("Cargando pantalla...: ");
  println(progressBar/5);
  int progressHeight = 20;  
  fill (0, 102, 204, 70);
  noStroke();
  rect(73, 400, progressBar, progressHeight, 10);
   
  if(progressBar == 500 && key == ENTER)
    pantalla = 1;
  
}
