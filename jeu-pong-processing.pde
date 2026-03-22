float raquettey3 ;//debut de raquette ordi
float raquettey4 ;//fin de raquette ordi
float movO ;//mouvement de raquette odri
float movH ;//mouvement de raquette humain
float raquettey1;//debut de raquette humain
float raquettey2;//fin de raquette humain
float r ; // rayon de balon
float vitesse=4 ; // LA VITESSE
float ballonX; //position du ballon
float ballonY; //position du ballon
float vitesseX = vitesse * cos(PI / 4);//mouvement de ballon
float vitesseY = vitesse * sin(PI / 4);//mouvement de ballon
int score1 = 0;//le score de l'ordinateur
int score2 = 0;//le score de l'human
boolean upKeyPressed = false;//pour verifier si on a appuyer sur la touche up
boolean downKeyPressed = false;//pour verifier si on a appuyer sur la touche down
boolean jeuCommence = false; // variable booléenne


void setup() {
  size(800, 600);
  restartGame();
  movO=height/200;
  movH=height/200;
  raquettey1 = height/3;
  raquettey2 = height/1.7;
  raquettey3 = 0;
  raquettey4 = height/4;
  r=width/32;
}

void restartGame() { //procedure qui sera appele a chaque debut de partie

// rendre le ballon au centre de terrain
  ballonX = width / 2;
  ballonY = height / 2;
  
//initialiser les booleen a faux
  upKeyPressed = false;
  downKeyPressed = false;
}

 
void draw() {

   if (!jeuCommence) {
     background(199, 204, 232);
     textSize(width/10);
     fill(random(255), random(255), random(255));
     text("JEU DE TENNIS", width / 5, height/3);
     fill(0);
     textSize(width/30);
     text("***Appuyez sur la souris pour commencer***", width / 5, height*2/3);

  } else {
     background(199, 204, 232);//La couleur de terrain

//dessiner une ligne qui separe le terrain en deux
  stroke(0);
  strokeWeight(3);
  line(width / 2, 0, width / 2, height);

//afficher le score des joueur au haut de l'ecran et la couleur de score est de forme aleatoire
  fill(random(255), random(255), random(255));
  textSize(width/16);
  text("score", width/2.28, height/12);
  text(score1, width/4, height/10);
  text(score2, width/1.33,height/10 );

//dessiner le ballon
  noStroke();
  fill(26, 58, 255);
  ellipseMode(RADIUS);
  ellipse(ballonX, ballonY, r, r);

 // Dessiner les yeux
  fill(0); // Couleur des yeux
  float eyeSize = r / 6; // Taille des yeux
  ellipse(ballonX - r / 4, ballonY - r / 4, eyeSize, eyeSize); // oeil gauche
  ellipse(ballonX + r / 4, ballonY - r / 4, eyeSize, eyeSize); // oeil droit

// Dessiner la bouche souriante
  noFill();
  stroke(0);
  strokeWeight(3);
  arc(ballonX, ballonY + r / 4, r / 2, r / 4, 0, PI); // Bouche en forme de sourire

//dessiner la raquette de l'ordinateur
  stroke(0);
  strokeWeight(width/40);
  line(width/40, raquettey3, width/40, raquettey4);

//dessiner la raquette de l'humain
  stroke(0);
  strokeWeight(width/40);
  line(width/1.03, raquettey1, width/1.03, raquettey2);

// Changer la position de la raquette de l'ordinateur
  raquettey3 += movO;
  raquettey4 += movO;
  if (raquettey3 <= 0 || raquettey4 >= height) {
     movO = -movO;
  }

//changer la position de ballon
  ballonX += vitesseX;
  ballonY += vitesseY;
  
//changer la position de ballon si elle touche la raquette de l'humain
  if (ballonX >= width/1.07) {
    if (ballonY > raquettey1 && ballonY < raquettey2) {
       vitesseX = -vitesseX;
    }

//changer la position de ballon si elle touche la raquette de l'ordinateur
  } else if (ballonX <= width/16) {
       if (ballonY > raquettey3 && ballonY < raquettey4) {
         vitesseX = -vitesseX;
    }
  }

//changer la position de ballon si elle touche les bords haut et bas
   if (ballonY < r || ballonY > height - r) {
      vitesseY = -vitesseY;
    }

//Changer la position de la raquette humain vers le haut si on appuyent sur "up"
  if (upKeyPressed && raquettey1 > 0) {
    raquettey1 -= movH;
    raquettey2 -= movH;
  }

//Changer la position de la raquette humain vers le bas si on appuyent sur "down"
  if (downKeyPressed && raquettey2 < height) {
    raquettey1 += movH;
    raquettey2 += movH;
  }

  if (ballonX >= width || ballonX <= 0) {// Le ballon a atteint le bord sans toucher une raquette
    if (ballonX >= width) {
     // Incrémenter le score ici
      score1++;
    } else {
      // Incrémenter le score ici
      score2++; 
    }

// Réinitialiser la position du ballon et sa vitesse
    restartGame();
  }

  //si le score arrive a 3 afficher si le joueur a gagner ou pas
  if( score1>=3){
    background(199, 204, 232);
    fill(255,0,0);
    text ("vous avez perdu la partie",width/5.7,height/3);
  }
  if(score2>=3){
  background(199, 204, 232);
  fill(97,170,96);
  text("vous avez gagner la partie",width/5.7,height/3);
    }
  }
}

//La procedure de clavier
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      upKeyPressed = true;
    } else if (keyCode == DOWN) {
      downKeyPressed = true;
    }
  }
}

//La procedure qui est appelée chaque fois qu'une touche du clavier est relâchée
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      upKeyPressed = false;
    } else if (keyCode == DOWN) {
      downKeyPressed = false;
    }
  }
}

// commancer le jeux
void mousePressed() {
   if (!jeuCommence) {
    restartGame();
    jeuCommence = true;
  }
}
