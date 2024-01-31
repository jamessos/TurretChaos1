import processing.sound.*;

//how much missles
int missleAmount = 1;

//how much turrets
int turretAmount = 3;

//how much melee enemy
int swingerAmount = 10;


float main[] = new float [5];
int control[] = new int [13];
float gun [][] = new float [4][2];
float bullet [][][] = new float [2][30][5];
float ability [][] = new float [150][6];
float abilityTimer [][] = new float [3][2];
int reload [] = new int [3];
int cmag [] = new int [2];
int reloadTime [] = new int [2];
int time [] = new int [3];

int shots = 200;

float missle [][] = new float [20][8];
float missleDir [][][] = new float [20][4][2];
float warningMissle [][] = new float [20][3];
float missleTop [][][] = new float [20][3][2];
PImage explode[] = new PImage [29];
PImage swing[] = new PImage [24];
float expVar[][] = new float [50][6];
float swingVar[][] = new float [20][6];
float healTimer[] = new float [2];

float turret[][] = new float [20][15]; 
float swinger[][] = new float [20][16];
float turretBullet[][] = new float [shots][6];
float turretGun [][][] = new float [20][4][2];
float health;
float missleFade;
String realTime;
float RNG;
int shootTimer;
int runOut;
int expImmune = 0;
float stage = 0;
PImage startScreen;
PImage howTo;
float Phealth;
int warningVal = 0;

int preTimer = 0;
int endTimer = 0;
PImage endAn [] = new PImage [40];
PImage preAn [] = new PImage [40];
PImage starter[] = new PImage [191];
PImage message;

int startVal = 1;

int buttonInt = 0;
int dificulty = 0;
int autoHealerCheck = 0;
int ramping = 0;

SoundFile explody;
SoundFile finalBoom;
SoundFile shring;
SoundFile pew;

/*
0. X
 1. Y
 2. VX
 3. VY
 */

void setup () {
  size (1440, 800);
  frameRate (30);
  imageMode (CENTER);
  main[0] = 720;
  main[1] = 400;
  cmag[0] = 0;
  for (int i = 0; i<29; i++) {
    explode[i] = loadImage("exp/exp"+i+".png");
  }
  for (int i = 0; i<24; i++) {
    swing[i] = loadImage("swing/swing"+i+".png");
  }
  for (int x = 0; x<2; x++ ) {
    for (int i = 0; i<30; i++ ) {
      bullet[x][i][4] = 0;
    }
  }
  reload[0] = 0;
  time[0] = 0;
  time[1] = 0;
  for (int i = 0; i<20; i++) {
    missle[i][5] = random(90, 450);
    missle[i][7] = 0;
  }

  health = 1500;

  for (int i = 0; i<20; i++ ) {
    turret[i][10] = 0;
    turret[i][11] = random(90, 450);
  }
  for (int i = 0; i<20; i++ ) {
    swinger[i][10] = 0;
    swinger[i][11] = random(90, 450);
  }
  for (int i = 0; i<40; i++ ) {
    endAn[i] = loadImage("endimation/ending"+i+".png");
  }
  for (int i = 0; i<40; i++ ) {
    preAn[i] = loadImage("preDeath/boom_1"+i+".png");
  }
  for (int i = 1; i<190; i++ ) {
    if (i<10) {
      starter[i] = loadImage("starter/start_100"+i+".png");
    } else if (i< 100) {
      starter[i] = loadImage("starter/start_10"+i+".png");
    } else {
      starter[i] = loadImage("starter/start_1"+i+".png");
    }
  }
  message = loadImage ("message.png");
  startScreen = loadImage ("startScreen.png");
  howTo = loadImage ("howTo.png");
  Phealth = health;
  explody = new SoundFile (this, "explode.mp3");
  finalBoom = new SoundFile (this, "big boom.mp3");
  shring = new SoundFile (this, "shring.mp3");
  pew = new SoundFile (this, "pew.mp3");
}

void draw () {
  background (#05DCFF); 

  if (stage == -1) {
    fill (#008CFF);
    rect (-10, -10, 2000, 2000);
    image (howTo, 720, 400);
    if (keyPressed == true) {
      stage = 0;
    }
  }

  if (stage == 0) {
    fill (#008CFF);
    rect (-10, -10, 2000, 2000);
    image (startScreen, 720, 400);
    fill (255, 0, 0);
    strokeWeight (0);
    if (mousePressed == true && mouseX > 547 && mouseX < 933 && mouseY > 444.5 && mouseY < 584.5) {
      stage = 0.5;
    }
    if (mousePressed == true && mouseX > 615 && mouseX < 873 && mouseY > 627 && mouseY < 705) {
      stage = -1;
    }
    if (dificulty == 0) {
      fill (0, 255, 0);
    } else if (dificulty == 1) {
      fill (255, 255, 0);
    } else if (dificulty == 2) {
      fill (255, 0, 0);
    } else if (dificulty == 3) {
      fill (100, 0, 0);
    }
    rect (1265, 38, 135, 30);
    if (mousePressed == true && mouseX > 1265 && mouseX < 1400 && mouseY > 38 && mouseY < 68 && buttonInt == 0) {
      if (dificulty == 3) {
        dificulty = 0;
      } else {
        dificulty++;
      }
      buttonInt = 1;
    }
    if (dificulty == 0) {
      textSize (20);
      fill (#14C800);
      text ("Easy", 1310, 59);
    } else if (dificulty == 1) {
      textSize (20);
      fill (#AAAA2E);
      text ("Intermediate", 1270, 59);
    } else if (dificulty == 2) {
      textSize (20);
      fill (#BC2222);
      text ("Hard", 1310, 59);
    } else if (dificulty == 3) {
      textSize (20);
      fill (#2B0707);
      text ("Extream", 1295, 59);
    }


    if (autoHealerCheck == 0) {
      fill (255, 0, 0);
    } else if (autoHealerCheck == 1) {
      fill (0, 255, 0);
    }
    rect (1265, 87, 135, 30);
    if (mousePressed == true && mouseX > 1265 && mouseX < 1400 && mouseY > 87 && mouseY < 117 && buttonInt == 0) {
      if (autoHealerCheck == 0) {
        autoHealerCheck = 1;
      } else {
        autoHealerCheck=0;
      }
      buttonInt = 1;
    }
    if (autoHealerCheck == 0) {
      textSize (20);
      fill (#BC2222);
      text ("Off", 1315, 110);
    } else if (autoHealerCheck == 1) {
      textSize (20);
      fill (#14C800);
      text ("On", 1315, 110);
    }

    if (ramping == 0) {
      fill (255, 0, 0);
    } else if (ramping == 1) {
      fill (0, 255, 0);
    }
    rect (1265, 140, 135, 30);
    if (mousePressed == true && mouseX > 1265 && mouseX < 1400 && mouseY > 140 && mouseY < 170  && buttonInt == 0) {
      if (ramping == 0) {
        ramping = 1;
      } else {
        ramping = 0;
      }
      buttonInt = 1;
    }
    if (ramping == 0) {
      textSize (20);
      fill (#BC2222);
      text ("Off", 1315, 163);
    } else if (ramping == 1) {
      textSize (20);
      fill (#14C800);
      text ("On", 1315, 163);
    }

    if (mousePressed == false ) {
      buttonInt = 0;
    }
  }

  if (stage == 0.5) {
    fill (#008CFF);
    rect (-10, -10, 2000, 2000);
    image (startScreen, 720, 400);
    fill (255, 0, 0);
    strokeWeight (0);

    if (dificulty == 0) {
      missleAmount = 1;
      turretAmount = 1;
      swingerAmount = 5;
    } else if (dificulty == 1) {
      missleAmount = 1;
      turretAmount = 2;
      swingerAmount = 7;
    } else if (dificulty == 2) {
      missleAmount = 1;
      turretAmount = 3;
      swingerAmount = 10;
    } else if (dificulty == 3) {
      health = 1000;
      missleAmount = 2;
      turretAmount = 5;
      swingerAmount = 12;
    }

    if (mousePressed == false) {
      stage = 0.75;
    }
  }

  if (stage == 0.75) {
    if (startVal < 189 && keyPressed != true) {
      image (starter[startVal], 720, 400, 1440, 800);
      tint (255, 170);
      image (message, 60, 10, message.width/3, message.height/3);
      tint (255);
      startVal++ ;
    } else {
      stage = 1;
      startVal = 1;
    }
  }

  if (stage == 1) {
    if (control[10] == 1){
      stage = 1.1;
    }

    randomNumberGenerator ();

    if (shootTimer == 0 && reload[0] == 0 && mousePressed == true) {
      shoot ();
      pew.play(1, 0.3);
      control[5] = 1;
    }

    bulletMain (); 
    bulletDraw (); 
    mainVar (); 
    mainDraw (); 
    mainStb (); 
    gunTimer (); 
    missleMain ();
    turretMain ();
    abilityMain();
    mainTdraw();
    swingerMain ();
    explode ();
    swinging ();
    autoHealer ();
    mainPanel (); 
    reloadMain ();

    dmgChecker ();
    endChecker ();
    
    if (ramping == 1) {
      if (time[2] == 3 && dificulty == 0) {
        missleAmount = 1;
        turretAmount = 2;
        swingerAmount = 6;
      }
      if (time[2] == 5 && dificulty == 0) {
        missleAmount = 1;
        turretAmount = 2;
        swingerAmount = 7;
      }

      if (time[2] == 3 && dificulty == 1) {
        missleAmount = 1;
        turretAmount = 3;
        swingerAmount = 8;
      }
      if (time[2] == 5 && dificulty == 1) {
        missleAmount = 1;
        turretAmount = 3;
        swingerAmount = 10;
      }

      if (time[2] == 3 && dificulty == 2) {
        missleAmount = 1;
        turretAmount = 4;
        swingerAmount = 11;
      }
      if (time[2] == 4 && dificulty == 2) {
        missleAmount = 2;
        turretAmount = 5;
        swingerAmount = 12;
      }

      if (time[2] == 2 && dificulty == 3) {
        missleAmount = 2;
        turretAmount = 6;
        swingerAmount = 13;
      }
      if (time[2] == 4 && dificulty == 3) {
        missleAmount = 2;
        turretAmount = 7;
        swingerAmount = 15;
      }
    }
  }
  
  if (stage == 1.1){
    textAlign (CENTER);
    textSize (150);
    fill (#14C800);
    
    text("Paused" , 720, 330);
    textSize (50);
    text("click anywhere to continue" , 720, 410);
    textSize (30);
    text("click L to go back to home page" , 720, 470);
    text("click K to end game" , 720, 520);
    
    if (mousePressed == true){
      stage = 1.15;
    }
    if (dificulty == 0) {
      text ("current diffculty: easy", 720, 700);
    } else if (dificulty == 1) {
      text ("current diffculty: intermediate", 720, 700);
    } else if (dificulty == 2) {
      text ("current diffculty: hard", 720, 700);
    } else if (dificulty == 3) {
      text ("current diffculty: extream", 720, 700);
    }
    if (ramping == 1){
      text ("with ramping", 720, 730);
    }
    if (control[11] == 1){
      restartAll ();
    }
    if (control[12] == 1){
      stage = 2;
    }
  }
  if (stage == 1.15){
    textAlign (CENTER);
    textSize (150);
    fill (#14C800);
    text("Paused" , 720, 330);
    textSize (50);
    text("click anywhere to continue" , 720, 410);
    textSize (30);
    text("click L to go back to home page" , 720, 470);
    text("click K to end game" , 720, 520);
    if (mousePressed == false){
      stage = 1;
      textAlign (LEFT);
    }
    
    if (dificulty == 0) {
      text ("current diffculty: easy", 720, 700);
    } else if (dificulty == 1) {
      text ("current diffculty: intermediate", 720, 700);
    } else if (dificulty == 2) {
      text ("current diffculty: hard", 720, 700);
    } else if (dificulty == 3) {
      text ("current diffculty: extream", 720, 700);
    }
    if (ramping == 1){
      text ("with ramping", 720, 730);
    }
  }
  
  if (stage == 1.5) {
    bulletMain (); 
    bulletDraw (); 
    mainDraw (); 
    missleMain ();
    turretMain ();
    mainTdraw();
    swingerMain ();
    explode ();
    swinging ();
    mainPanel (); 
    health = 0;

    if (preTimer < 40) {
      if (preTimer == 37) {
        finalBoom.play(1, 0.4);
      }
      image (preAn[preTimer], main[0], main[1]);
      preTimer++;
    }

    if (preTimer == 40) {

      if (endTimer <=18) {
        endExplode (endTimer);
        endTimer++;
      } else {
        stage = 2;
      }
    }
  }
  if (stage == 2) {
    background (255);

    endScreenDraw();

    if (endTimer < 39) {
      endTimer++;
      endExplode (endTimer);
    }
  }

  if (stage == 2.5) {
    background (255);

    endScreenDraw();

    if (endTimer < 39) {
      endTimer++;
      endExplode (endTimer);
    }
  }
}

void autoHealer () {
  if (autoHealerCheck == 1) {
    if (health < 1200) {
      control[6] = 1;
    }
  }
}

void restartAll () {
  for (int i = 0; i<5; i++) {
    main[i] = 0;
  }

  for (int i = 0; i<10; i++) {
    control[i] = 0;
  }

  for (int i = 0; i<4; i++) {
    for (int a = 0; a<2; a++) {
      gun[i][a] = 0;
    }
  }

  for (int i = 0; i<2; i++) {
    for (int a = 0; a<30; a++) {
      for (int b = 0; b<5; b++) {
        bullet[i][a][b] = 0;
      }
    }
  }

  for (int i = 0; i<150; i++) {
    for (int a = 0; a<6; a++) {
      ability[i][a] = 0;
    }
  }

  for (int i = 0; i<3; i++) {
    for (int a = 0; a<2; a++) {
      abilityTimer[i][a] = 0;
    }
  }

  for (int i = 0; i<3; i++) {
    reload[i] = 0;
  }

  for (int i = 0; i<2; i++) {
    cmag[i] = 0;
  }

  for (int i = 0; i<2; i++) {
    reloadTime[i] = 0;
  }

  for (int i = 0; i<3; i++) {
    time[i] = 0;
  }


  for (int i = 0; i<missleAmount; i++) {
    for (int a = 0; a<8; a++) {
      missle[i][a] = 0;
    }
  }

  for (int i = 0; i<missleAmount; i++) {
    for (int a = 0; a<4; a++) {
      for (int b = 0; b<2; b++) {
        missleDir[i][a][b] = 0;
      }
    }
  }

  for (int i = 0; i<missleAmount; i++) {
    for (int a = 0; a<3; a++) {
      warningMissle[i][a] = 0;
    }
  }

  for (int i = 0; i<missleAmount; i++) {
    for (int a = 0; a<3; a++) {
      for (int b = 0; b<2; b++) {
        missleTop[i][a][b] = 0;
      }
    }
  }

  for (int i = 0; i<50; i++) {
    for (int a = 0; a<6; a++) {
      expVar[i][a] = 0;
    }
  }

  for (int i = 0; i<20; i++) {
    for (int a = 0; a<6; a++) {
      swingVar[i][a] = 0;
    }
  }

  for (int i = 0; i<2; i++) {
    healTimer[i] = 0;
  }

  //shots = turretAmount*50;

  for (int i = 0; i<turretAmount; i++) {
    for (int a = 0; a<15; a++) {
      turret[i][a] = 0;
    }
  }

  for (int i = 0; i<swingerAmount; i++) {
    for (int a = 0; a<16; a++) {
      swinger[i][a] = 0;
    }
  }

  for (int i = 0; i<shots; i++) {
    for (int a = 0; a<6; a++) {
      turretBullet[i][a] = 0;
    }
  }

  for (int i = 0; i<turretAmount; i++) {
    for (int a = 0; a<4; a++) {
      for (int b = 0; b<2; b++) {
        turretGun[i][a][b] = 0;
      }
    }
  }


  expImmune = 0;
  stage = 0;

  warningVal = 0;


  main[0] = 720;
  main[1] = 400;
  cmag[0] = 0;

  for (int x = 0; x<2; x++ ) {
    for (int i = 0; i<30; i++ ) {
      bullet[x][i][4] = 0;
    }
  }
  reload[0] = 0;
  time[0] = 0;
  time[1] = 0;

  for (int i = 0; i<missleAmount; i++) {
    missle[i][5] = random(90, 450);
    missle[i][7] = 0;
  }

  health = 1500;

  for (int i = 0; i<turretAmount; i++ ) {
    turret[i][10] = 0;
    turret[i][11] = random(90, 450);
  }
  for (int i = 0; i<swingerAmount; i++ ) {
    swinger[i][10] = 0;
    swinger[i][11] = random(90, 450);
  }

  Phealth = health;
  textAlign (LEFT);
}

void endScreenDraw() {
  fill (0);
  textSize (150);
  textAlign (CENTER);
  text ("You survived for", 720, 200);
  text (time[2] + ":" + realTime, 720, 400);
  fill (150);
  rect (600, 570, 240, 100);
  fill (0);
  textSize (50);
  text ("Restart?", 720, 640);
  if (mousePressed == false && stage == 2.5) {
    restartAll ();
  }
  if (mousePressed == true && mouseX > 600 && mouseX < 840 && mouseY > 570 && mouseY < 670) {
    stage=2.5;
  }
  if (dificulty == 0) {
    textSize (30);
    text ("on easy mode", 720, 480);
  } else if (dificulty == 1) {
    textSize (30);
    text ("on intermediate mode", 720, 480);
  } else if (dificulty == 2) {
    textSize (30);
    text ("on hard mode", 720, 480);
  } else if (dificulty == 3) {
    textSize (30);
    text ("on extream mode", 720, 480);
  }
  if (ramping == 1){
    textSize (30);
    text ("with ramping", 720, 520);
  }
}

void endExplode (int x) {
  image(endAn[x], main[0], main[1], endAn[x].width*2, endAn[x].height*2);
}
void endChecker () {
  if (health < 0) {
    health = 0;
    stage = 1.5;
    endTimer = 0;
    preTimer = 0;
  }
}

void dmgChecker () {
  if (Phealth > health) {
    warningVal = 255;
  } 
  if (dificulty == 0) {
    if (health < 1500) {
      health += 0.05;
    }
  } else if (dificulty == 3) {
    health -= 0.1;
  }
  Phealth = health;
}

void swingerMain () {
  for (int i = 0; i<swingerAmount; i++) {
    if (swinger[i][10] == 0) {
      if (swinger[i][11]>swinger[i][12]) {
        swinger[i][12]++;
      } else {
        swinger[i][12] = 0;
        swinger[i][11] = 15;
        swinger[i][10] = 1;
      }
    }
    if (swinger[i][10] == 1) {
      swingerPrep (i);
    }
    if (swinger[i][10] == 1.5) {
      if (swinger[i][11]>swinger[i][12]) {
        swinger[i][12]++;
        fill (255, 255, 255);
        strokeWeight (3);
        rect (swinger[i][0]-25, swinger[i][1]-25, 50, 50);
      } else {
        swinger[i][12] = 0;
        swinger[i][11] = 90;
        swinger[i][10] = 2;
      }
    }
    if (swinger[i][10] == 2) {
      swingerMove (i);
    }
    if (swinger[i][10] == 3) {
      swingerMove (i);
    }
    if (swinger[i][10] == 4) {
      swingerMove (i);
    }
    if (swinger[i][10] == 5) {
      if (swinger[i][11]>swinger[i][12]) {
        swinger[i][12]++;
        swingerFade (i, swinger[i][12]);
      } else {
        swinger[i][12] = 0;
        swinger[i][11] = floor (random (90, 450));
        swinger[i][10] = 0;
        swinger[i][8] = 0;
      }
    }
  }
}

void swingerPrep (int x) {
  if (RNG < 0.25) {
    swinger[x][0] = random(0, 1340);
    swinger[x][1] = 0;
  }
  if (RNG >= 0.25 && RNG < 0.5) {
    swinger[x][0] = random(0, 1340);
    swinger[x][1] = 700;
  }
  if (RNG >= 0.5 && RNG < 0.75) {
    swinger[x][0] = 0;
    swinger[x][1] = random(100, 700);
  }
  if (RNG >= 0.75 && RNG <= 1) {
    swinger[x][0] = 1445;
    swinger[x][1] = random(100, 700);
  }
  if (dificulty == 3) {
    swinger[x][9] = floor(random(-0.7, 1.2));
  } else {
    swinger[x][9] = floor(random(-0.5, 1.1));
  }

  swinger[x][10] = 1.5;
  swinger[x][11] = 35;
  if (swinger[x][9] == 1) {
    swinger[x][13] = 330;
  } else if (swinger[x][9] == 0) {
    swinger[x][13] = 80;
  } else {
    swinger[x][13] = 190;
  }
  swingerRand (x);
}

void swingerRand (int x) {
  swinger[x][6] = random(0, 360);

  if (swinger[x][9] == 1) {
    if (RNG >0.5) {
      swinger[x][7] = random(1, 2);
    } else {
      swinger[x][7] = random(-1, -2);
    }
  } else {
    if (RNG >0.5) {
      swinger[x][7] = random(2.5, 4);
    } else {
      swinger[x][7] = random(-2.5, -4);
    }
  }
}

void swingRotator (int x) {
  if (swinger[x][6]< 360) {
    swinger[x][6]+=swinger[x][7];
  } else {
    swinger[x][6] = 0;
  }
  if (swinger[x][9] == 1) {
    swinger[x][4] = (cos (radians(swinger[x][6]))*150)+ main[0];
    swinger[x][5] = (sin (radians(swinger[x][6]))*150)+ main[1];
  } else {
    swinger[x][4] = (cos (radians(swinger[x][6]))*100)+ main[0];
    swinger[x][5] = (sin (radians(swinger[x][6]))*100)+ main[1];
  }
}

void swingerMove (int x) {
  if (swinger[x][10] == 3) {
    if (swinger[x][11]>swinger[x][12]) {
      swinger[x][8] = 1;
      swinger[x][12]++;
    } else {
      swinger[x][10] = 2;
      swinger[x][12] = 0;
      swinger[x][8] = 0;
    }
  }
  if (swinger[x][10] == 4) {
    if (swinger[x][11]>swinger[x][12]) {
      swinger[x][8] = 1;
      swinger[x][12]++;
      if (swinger[x][12] == 8 || swinger[x][12] == 13) {
        swinger[x][15] = 1;
      } else {
        swinger[x][15] = 0;
      }
    } else {
      swinger[x][2] = 0;
      swinger[x][3] = 0;
      swinger[x][10] = 3;
      swinger[x][11] = 30;
      swinger[x][12] = 0;
    }
  }
  if (swinger[x][10] != 4) {
    swingRotator (x);
    if (swinger[x][9] == 1 || swinger[x][9] == 0) {
      if (dist (swinger[x][0], swinger[x][1], main[0], main[1])<150 && swinger[x][8] == 0) {
        swinger[x][10] = 4;
        swinger[x][11] = 25;
        swinger[x][12] = 0;
        if (swinger[x][9] == 0) {
          swingCall (swinger[x][0], swinger[x][1], 1, 40);
        } else {
          swingCall (swinger[x][0], swinger[x][1], 1.25, 100);
        }
      } else {
        if (10* -(swinger[x][0] - swinger[x][4])/ sqrt(sq(swinger[x][1] - swinger[x][5])+ sq(swinger[x][0] - swinger[x][4]))<swinger[x][2]) {
          swinger[x][2]-=1;
        }
        if (10* -(swinger[x][0] - swinger[x][4])/ sqrt(sq(swinger[x][1] - swinger[x][5])+ sq(swinger[x][0] - swinger[x][4]))>swinger[x][2]) {
          swinger[x][2]+=1;
        }
        if (10* -(swinger[x][1] - swinger[x][5])/ sqrt(sq(swinger[x][1] - swinger[x][5])+ sq(swinger[x][0] - swinger[x][4]))<swinger[x][3]) {
          swinger[x][3]-=1;
        }
        if (10* -(swinger[x][1] - swinger[x][5])/ sqrt(sq(swinger[x][1] - swinger[x][5])+ sq(swinger[x][0] - swinger[x][4]))>swinger[x][3]) {
          swinger[x][3]+=1;
        }
      }
    } else {
      if (dist (swinger[x][0], swinger[x][1], main[0], main[1])<110 && swinger[x][8] == 0) {
        swinger[x][10] = 4;
        swinger[x][11] = 30;
        swinger[x][12] = 0;

        swingCall (swinger[x][0], swinger[x][1], 1, 60);
      } else {
        if (12* -(swinger[x][0] - swinger[x][4])/ sqrt(sq(swinger[x][1] - swinger[x][5])+ sq(swinger[x][0] - swinger[x][4]))<swinger[x][2]) {
          swinger[x][2]-=1.5;
        }
        if (12* -(swinger[x][0] - swinger[x][4])/ sqrt(sq(swinger[x][1] - swinger[x][5])+ sq(swinger[x][0] - swinger[x][4]))>swinger[x][2]) {
          swinger[x][2]+=1.5;
        }
        if (12* -(swinger[x][1] - swinger[x][5])/ sqrt(sq(swinger[x][1] - swinger[x][5])+ sq(swinger[x][0] - swinger[x][4]))<swinger[x][3]) {
          swinger[x][3]-=1.5;
        }
        if (12* -(swinger[x][1] - swinger[x][5])/ sqrt(sq(swinger[x][1] - swinger[x][5])+ sq(swinger[x][0] - swinger[x][4]))>swinger[x][3]) {
          swinger[x][3]+=1.5;
        }
      }
    }
    swinger[x][0] += swinger[x][2];
    swinger[x][1] += swinger[x][3];
  }

  if (swinger[x][13] <= 0 || dist (swinger[x][0], swinger[x][1], main[0], main[1])<70) {
    swinger[x][13] = 0;
    swinger[x][10] = 5;
    swinger[x][11] = 20;
    swinger[x][12] = 0;
    if (dist (swinger[x][0], swinger[x][1], main[0], main[1])<70) {
      if (swinger [x][9] == -1) {
        health-=75;
      } else if (swinger [x][9] == 0) {
        health-=50;
      } else if (swinger [x][9] == 1) {
        health-=100;
      }
    }
  }
}
void swingerDraw (int x) {
  stroke (100);
  strokeWeight (3);

  if (swinger[x][9] == 1) {
    fill (255);
    ellipse (swinger[x][0], swinger[x][1], 50, 50);
    fill (200);
    ellipse (swinger[x][0], swinger[x][1], 25, 25);
  } else if (swinger[x][9] == -1) {
    fill (255);
    ellipse (swinger[x][0], swinger[x][1], 50, 50);
  } else {
    fill (200);
    ellipse (swinger[x][0], swinger[x][1], 50, 50);
  }

  strokeWeight(3);
  fill (200);
  rect (swinger[x][0] - 37, swinger[x][1] - 55, 75, 15);
  strokeWeight(0);
  if (swinger[x][9] == -1) {
    fill (255, 0, 0);
    rect (swinger[x][0] - 36, swinger[x][1] - 54, 73*swinger[x][13]*0.005236, 13);
  } else if (swinger[x][9] == 1) {
    fill (255, 0, 0);
    rect (swinger[x][0] - 36, swinger[x][1] - 54, 73*swinger[x][13]*0.00303030303, 13);
  } else {
    fill (255, 0, 0);
    rect (swinger[x][0] - 36, swinger[x][1] - 54, 73*swinger[x][13]*0.0125, 13);
  }
}

void swingerFade (int x, float fade) {
  stroke (100, 255-255*fade*0.05);
  strokeWeight (3);

  if (swinger[x][9] == 1) {
    fill (255, 255-255*fade*0.05);
    ellipse (swinger[x][0], swinger[x][1], 50, 50);
    fill (200, 255-255*fade*0.05);
    ellipse (swinger[x][0], swinger[x][1], 25, 25);
  } else if (swinger[x][9] == 0) {
    fill (200, 255-255*fade*0.05);
    ellipse (swinger[x][0], swinger[x][1], 50, 50);
  } else {
    fill (255, 255-255*fade*0.05);
    ellipse (swinger[x][0], swinger[x][1], 50, 50);
  }

  strokeWeight(3);
  fill (200, 255-255*fade*0.05);
  rect (swinger[x][0] - 37, swinger[x][1] - 55, 75, 15);
}

void swingCall (float x, float y, float size, float dmg) {
  for (int i = 0; i<20; i++) {
    if (swingVar[i][4] == 0) {
      swingVar[i][0] = x;
      swingVar[i][1] = y;
      swingVar[i][2] = size;
      swingVar[i][3] = 0;
      swingVar[i][4] = 1;
      swingVar[i][5] = dmg;
      break;
    }
  }
}

void swinging () {
  for  (int i = 0; i<20; i++) {
    if (swingVar[i][4] == 1) {
      if (swingVar [i][3] == 1 && stage == 1) {
        shring.play(1, 0.2);
      }
      if (swingVar[i][3] < 22) {
        image(swing[round(swingVar[i][3])], swingVar[i][0], swingVar[i][1], swingVar[i][2]*swing[round(swingVar[i][3])].width, swingVar[i][2]*swing[round(swingVar[i][3])].height);        
        swingVar[i][3]++;
        if (8==swingVar[i][3] || 13==swingVar[i][3]) {

          if (dist(swingVar[i][0], swingVar[i][1], main[0], main[1])<swingVar[i][2]*190) {
            health-=swingVar[i][5];
          }
          for (int a = 0; a<turretAmount; a++) {
            if (dist(swingVar[i][0], swingVar[i][1], turret[a][0], turret[a][1])<swingVar[i][2]*170 && (turret[a][10] == 2 || turret[a][10] == 3 )) {
              turret[a][13]-=swingVar[i][5]/1.5;
            }
          }
          for (int a = 0; a<swingerAmount; a++) {
            if (dist(swingVar[i][0], swingVar[i][1], swinger[a][0], swinger[a][1])<swingVar[i][2]*170 && (swinger[a][15] == 0)) {
              swinger[a][13]-=swingVar[i][5]/2;
            }
          }
          for (int a = 0; a<missleAmount; a++) {
            if (dist(swingVar[i][0], swingVar[i][1], missle[a][0], missle[a][1])<expVar[i][2]*190 && missle[a][7] == 4) {
              missle[a][7] = 5;
            }
          }
        }
      } else {
        swingVar[i][4] = 0;
      }
    }
  }
  for (int i = 0; i<swingerAmount; i++) {
    if (swinger[i][10] == 2 || swinger[i][10] == 3 || swinger[i][10] == 4) {
      swingerDraw (i);
    }
  }
}


void turretMain () {
  turretFire ();
  for (int i = 0; i<turretAmount; i++) {
    if (turret[i][10] == 0) {
      if (turret[i][11]>turret[i][12]) {
        turret[i][12]++;
      } else {
        turret[i][12] = 0;
        turret[i][11] = 30;
        turret[i][10] = 1;
      }
    }
    if (turret[i][10] == 1) {
      turretPrep(i);
    }
    if (turret[i][10] == 1.5) {
      if (turret[i][11]>turret[i][12]) {
        turret[i][12]++;
        fill (0, 200, 200);
        strokeWeight (3);
        rect (turret[i][0]-50, turret[i][1]-50, 120, 120);
      } else {
        turret[i][12] = 0;
        turret[i][11] = 90;
        turret[i][10] = 2;
      }
    }
    if (turret[i][10] == 2) {
      turrerMove (i);
    }
    if (turret[i][10] == 3) {
      turrerMove (i);
    }
    if (turret[i][10] == 4) {
      if (turret[i][9] == 2) {
        boomCheck (turret[i][0], turret[i][1], 0.2, 250);
      } else {
        boomCheck (turret[i][0], turret[i][1], 0.2, 99);
      }
      turret[i][10] = 5;
      turret[i][11] = 5;
      turret[i][12] = 0;
    }
    if (turret[i][10] == 5) {
      if (turret[i][12]<turret[i][11]) {
        turret[i][12]++;

        if (turret[i][10] == 3) {
          fill (255, 0, 0);
        } else {
          fill (150 + 0.2*(255-150)*turret[i][12], 150 - 0.2*150*turret[i][12], 150 - 0.2*150*turret[i][12]);
        }
        stroke (100);
        strokeWeight (3);
        quad (turretGun[i][0][0], turretGun[i][0][1], turretGun[i][1][0], turretGun[i][1][1], turretGun[i][2][0], turretGun[i][2][1], turretGun[i][3][0], turretGun[i][3][1]);

        if (turret[i][9] == 0) {
          fill (100 + 0.2*(255-100)*turret[i][12], 100 - 0.2*100*turret[i][12], 100 - 0.2*100*turret[i][12]);
        } else if (turret[i][9] == 1) {
          fill (200 + 0.2*(255-200)*turret[i][12], 200 - 0.2*200*turret[i][12], 200 - 0.2*200*turret[i][12]);
        } else {
          fill (0 + 0.2*(255-0)*turret[i][12], 200 - 0.2*200*turret[i][12], 200 - 0.2*200*turret[i][12]);
        }
        ellipse (turret[i][0], turret[i][1], 50, 50);
        rect (turret[i][0] - 37, turret[i][1] - 55, 75, 15);
      } else {
        turret[i][10] = 0;
        turret[i][11] = random(90, 450);
        turret[i][12] = 0;
      }
    }
  }
}

void turretPrep(int x) {
  if (RNG < 0.25) {
    turret[x][0] = random(0, 1340);
    turret[x][1] = -50;
  }
  if (RNG >= 0.25 && RNG < 0.5) {
    turret[x][0] = random(0, 1340);
    turret[x][1] = 735;
  }
  if (RNG >= 0.5 && RNG < 0.75) {
    turret[x][0] = -50;
    turret[x][1] = random(100, 700);
  }
  if (RNG >= 0.75 && RNG <= 1) {
    turret[x][0] = 1465;
    turret[x][1] = random(100, 700);
  }
  if (dificulty == 3) {
    turret[x][9] = floor(random(0, 2.5));
  } else {
    turret[x][9] = floor(random(0, 2.2));
  }
  turret[x][10] = 1.5;
  turret[x][11] = 35;
  if (turret[x][9] == 1 || turret[x][9] == 0) {
    turret[x][13] = 150;
  } else {
    turret[x][13] = 500;
  }
  rotateRand (x);
}

void rotateRand (int x) {
  turret[x][6] = random(0, 360);
  if (turret[x][9] == 2) {
    if (RNG >0.5) {
      turret[x][7] = random(1, 2);
    } else {
      turret[x][7] = random(-1, -2);
    }
  } else {
    if (RNG >0.5) {
      turret[x][7] = random(2.5, 4);
    } else {
      turret[x][7] = random(-2.5, -4);
    }
  }
}

void turrerMove (int x) {

  rotator (x);

  if (turret[x][9] == 2) {
    if (10* -(turret[x][0] - turret[x][4])/ sqrt(sq(turret[x][1] - turret[x][5])+ sq(turret[x][0] - turret[x][4]))<turret[x][2]) {
      turret[x][2]-=1;
    }
    if (10* -(turret[x][0] - turret[x][4])/ sqrt(sq(turret[x][1] - turret[x][5])+ sq(turret[x][0] - turret[x][4]))>turret[x][2]) {
      turret[x][2]+=1;
    }
    if (10* -(turret[x][1] - turret[x][5])/ sqrt(sq(turret[x][1] - turret[x][5])+ sq(turret[x][0] - turret[x][4]))<turret[x][3]) {
      turret[x][3]-=1;
    }
    if (10* -(turret[x][1] - turret[x][5])/ sqrt(sq(turret[x][1] - turret[x][5])+ sq(turret[x][0] - turret[x][4]))>turret[x][3]) {
      turret[x][3]+=1;
    }
  } else {
    if (20* -(turret[x][0] - turret[x][4])/ sqrt(sq(turret[x][1] - turret[x][5])+ sq(turret[x][0] - turret[x][4]))<turret[x][2]) {
      turret[x][2]-=1.5;
    }
    if (20* -(turret[x][0] - turret[x][4])/ sqrt(sq(turret[x][1] - turret[x][5])+ sq(turret[x][0] - turret[x][4]))>turret[x][2]) {
      turret[x][2]+=1.5;
    }
    if (20* -(turret[x][1] - turret[x][5])/ sqrt(sq(turret[x][1] - turret[x][5])+ sq(turret[x][0] - turret[x][4]))<turret[x][3]) {
      turret[x][3]-=1.5;
    }
    if (20* -(turret[x][1] - turret[x][5])/ sqrt(sq(turret[x][1] - turret[x][5])+ sq(turret[x][0] - turret[x][4]))>turret[x][3]) {
      turret[x][3]+=1.5;
    }
  }

  turret[x][0] += turret[x][2];
  turret[x][1] += turret[x][3];

  if (main[0]-turret[x][0] < 0) {
    turret[x][14] = degrees (atan ((main[1]-turret[x][1])/(main[0]-turret[x][0])));
  } else {
    turret[x][14] = degrees (atan ((main[1]-turret[x][1])/(main[0]-turret[x][0])) - PI);
  }
  if (turret[x][14] < 0) {
    turret[x][14] = 360 + turret[x][14];
  }
  turret[x][14] = 180 - turret[x][14];

  turretGun[x][0][0] = sin (radians (110+turret[x][14])) * 40 + turret[x][0]; 
  turretGun[x][0][1] = cos (radians (110+turret[x][14])) * 40 + turret[x][1]; 

  turretGun[x][1][0] = sin (radians (70+turret[x][14])) * 40 + turret[x][0]; 
  turretGun[x][1][1] = cos (radians (70+turret[x][14])) * 40 + turret[x][1]; 

  turretGun[x][2][0] = sin (radians (turret[x][14])) * 6 + turret[x][0]; 
  turretGun[x][2][1] = cos (radians (turret[x][14])) * 6 + turret[x][1]; 

  turretGun[x][3][0] = sin (radians (-180+turret[x][14])) * 6 + turret[x][0]; 
  turretGun[x][3][1] = cos (radians (-180+turret[x][14])) * 6 + turret[x][1];

  if (turret[x][10] == 2) {
    if (turret[x][11]>turret[x][12]) {
      turret[x][12]++;
    } else {
      turret[x][12] = 0;

      if (turret[x][9] == 1) {
        turret[x][11] = 60;
      } else if (turret[x][9] == 0) {
        turret[x][11] = 35;
      } else {
        turret[x][11] = 35;
      }


      turret[x][10] = 3;
    }
  }
  if (turret[x][10] == 3) {
    if (turret[x][9] == 0) {
      if (turret[x][11]>turret[x][12]) {
        turret[x][12]++;
        if (turret[x][12] == 30) {
          turretShoot ((turretGun[x][0][0] + turretGun[x][1][0])*0.5, (turretGun[x][0][1] + turretGun[x][1][1])*0.5, main[0]+random(-100, 100), main[1]+random(-75, 75), 0);
          turretShoot ((turretGun[x][0][0] + turretGun[x][1][0])*0.5, (turretGun[x][0][1] + turretGun[x][1][1])*0.5, main[0]+random(-100, 100), main[1]+random(-75, 75), 0);
          turretShoot ((turretGun[x][0][0] + turretGun[x][1][0])*0.5, (turretGun[x][0][1] + turretGun[x][1][1])*0.5, main[0]+random(-100, 100), main[1]+random(-75, 75), 0);
          turretShoot ((turretGun[x][0][0] + turretGun[x][1][0])*0.5, (turretGun[x][0][1] + turretGun[x][1][1])*0.5, main[0]+random(-100, 100), main[1]+random(-75, 75), 0);
          turretShoot ((turretGun[x][0][0] + turretGun[x][1][0])*0.5, (turretGun[x][0][1] + turretGun[x][1][1])*0.5, main[0]+random(-100, 100), main[1]+random(-75, 75), 0);
          turretShoot ((turretGun[x][0][0] + turretGun[x][1][0])*0.5, (turretGun[x][0][1] + turretGun[x][1][1])*0.5, main[0]+random(-100, 100), main[1]+random(-75, 75), 0);
        }
      } else {
        turret[x][12] = 0;
        turret[x][10] = 2;
        turret[x][11] = 30;
        if (random(1)<0.1) {
          rotateRand (x);
        }
      }
    }
    if (turret[x][9] == 1) {
      if (turret[x][11]>turret[x][12]) {
        turret[x][12]++;
        if (turret[x][12] == 30 || turret[x][12] == 35 || turret[x][12] == 40 || turret[x][12] == 45 || turret[x][12] == 50 || turret[x][12] == 55) {
          turretShoot ((turretGun[x][0][0] + turretGun[x][1][0])*0.5, (turretGun[x][0][1] + turretGun[x][1][1])*0.5, main[0]+random(-100, 100), main[1]+random(-100, 100), 0);
        }
      } else {
        turret[x][12] = 0;
        turret[x][10] = 2;
        turret[x][11] = 60;
        if (random(1)<0.1) {
          rotateRand (x);
        }
      }
    }
    if (turret[x][9] == 2) {
      if (turret[x][11]>turret[x][12]) {
        turret[x][12]++;
        if (turret[x][12] == 30) {
          turretShoot ((turretGun[x][0][0] + turretGun[x][1][0])*0.5, (turretGun[x][0][1] + turretGun[x][1][1])*0.5, main[0]+random(-20, 20), main[1]+random(-20, 20), 1);
        }
      } else {
        turret[x][12] = 0;
        turret[x][10] = 2;
        turret[x][11] = 120;
        if (random(1)<0.1) {
          rotateRand (x);
        }
      }
    }
  }

  if (turret[x][13] <=0 || dist (turret[x][0], turret[x][1], main[0], main[1])<70) {
    turret[x][13] = 0;
    turret[x][10] = 4;
  }

  turretDraw (x);
}


void turretDraw (int x) {
  if (turret[x][10] == 3) {
    fill (255, 0, 0);
  } else {
    fill (150);
  }
  stroke (100);
  strokeWeight (3);
  quad (turretGun[x][0][0], turretGun[x][0][1], turretGun[x][1][0], turretGun[x][1][1], turretGun[x][2][0], turretGun[x][2][1], turretGun[x][3][0], turretGun[x][3][1]);

  if (turret[x][9] == 0) {
    fill (150);
  } else if (turret[x][9] == 1) {
    fill (200);
  } else {
    fill (0, 200, 200);
  }
  ellipse (turret[x][0], turret[x][1], 50, 50);

  strokeWeight(3);

  rect (turret[x][0] - 37, turret[x][1] - 55, 75, 15);
  strokeWeight(0);
  if (turret[x][9] != 2) {
    fill (255, 0, 0);
    rect (turret[x][0] - 36, turret[x][1] - 54, 73*turret[x][13]*0.0066666, 13);
  } else {
    fill (255, 0, 0);
    rect (turret[x][0] - 36, turret[x][1] - 54, 73*turret[x][13]*0.002, 13);
  }
}

void turretShoot(float x, float y, float tx, float ty, float exp) {
  for (int i = 0; i<shots; i++) {
    if (turretBullet[i][4] == 0) {
      pew.play(1, 0.3);
      turretBullet[i][4] = 1;
      turretBullet[i][0] = x;
      turretBullet[i][1] = y;
      turretBullet[i][2] = -40*(x-tx)/ sqrt(sq((x-tx))+(sq(y-ty)));
      turretBullet[i][3] = -40*(y-ty)/ sqrt(sq((x-tx))+(sq(y-ty)));
      if (exp == 1) {
        turretBullet[i][5] = 1;
      } else {
        turretBullet[i][5] = 0;
      }
      break;
    }
  }
}


void turretFire () {
  for (int i = 0; i<shots; i++) {
    if (turretBullet[i][4] == 1) {
      if (turretBullet[i][5] == 1) {
        fill (200, 0, 0);
        ellipse (turretBullet[i][0], turretBullet[i][1], 20, 20);
      } else {
        fill (150);
        ellipse (turretBullet[i][0], turretBullet[i][1], 10, 10);
      }
      if (turretBullet[i][0]<0 || turretBullet[i][0]>1440 || turretBullet[i][1]<0 || turretBullet[i][1] > 700) {
        if (turretBullet[i][5] == 1) {
          boomCheck (turretBullet[i][0], turretBullet[i][1], 0.3, 200);
        }
        turretBullet[i][0] = 0;
        turretBullet[i][1] = 0;
        turretBullet[i][2] = 0;
        turretBullet[i][3] = 0;
        turretBullet[i][4] = 0;
      } else {
        turretBullet[i][0] += turretBullet[i][2];
        turretBullet[i][1] += turretBullet[i][3];
        if ((dist (turretBullet[i][0], turretBullet[i][1], main[0], main[1]) < 50) || ((dist (turretBullet[i][0], turretBullet[i][1], main[0], main[1]) < 80) && turretBullet[i][5] == 1)) {
          health-=30;
          if (turretBullet[i][5] == 1) {
            boomCheck (turretBullet[i][0], turretBullet[i][1], 0.3, 200);
          }
          turretBullet[i][4]=0;
        }
      }
    }
  }
}

void rotator (int x) {
  if (turret[x][6]< 360) {
    turret[x][6]+=turret[x][7];
  } else {
    turret[x][6] = 0;
  }
  if (turret[x][9] == 2) {
    turret[x][4] = (cos (radians(turret[x][6]))*350)+ main[0];
    turret[x][5] = (sin (radians(turret[x][6]))*350)+ main[1];
  } else {
    turret[x][4] = (cos (radians(turret[x][6]))*200)+ main[0];
    turret[x][5] = (sin (radians(turret[x][6]))*200)+ main[1];
  }
}


void boomCheck (float x, float y, float size, float dmg) {
  for (int i = 0; i<50; i++) {
    if (expVar[i][4] == 0) {
      expVar[i][0] = x;
      expVar[i][1] = y;
      expVar[i][2] = size;
      expVar[i][3] = 0;
      expVar[i][4] = 1;
      expVar[i][5] = dmg;
      break;
    }
  }
}

void explode () {
  for  (int i = 0; i<50; i++) {
    if (expVar[i][4] == 1) {
      if (expVar [i][3] == 0 && stage == 1) {
        explody.play(1, 0.3);
      }
      if (expVar[i][3] < 29) {
        image(explode[round(expVar[i][3])], expVar[i][0], expVar[i][1], expVar[i][2]*explode[round(expVar[i][3])].width*2.25, expVar[i][2]*explode[round(expVar[i][3])].height*2.25);
        expVar[i][3]++;
        if (expVar[i][3] == 3) {
          if (dist(expVar[i][0], expVar[i][1], main[0], main[1])<expVar[i][2]*500 && expImmune == 0) {
            health-=expVar[i][5];
          }
          for (int a = 0; a<turretAmount; a++) {
            if (dist(expVar[i][0], expVar[i][1], turret[a][0], turret[a][1])<expVar[i][2]*480 && (turret[a][10] == 2 || turret[a][10] == 3 )) {
              turret[a][13]-=expVar[i][5];
              if (turret[a][13]<0) {
                turret[a][13]=-1;
              }
            }
          }
          for (int a = 0; a<missleAmount; a++) {
            if (dist(expVar[i][0], expVar[i][1], missle[a][0], missle[a][1])<expVar[i][2]*480 && missle[a][7] == 4) {
              missle[a][7] = 5;
            }
          }
          for (int a = 0; a<swingerAmount; a++) {
            if (dist(expVar[i][0], expVar[i][1], swinger[a][0], swinger[a][1])<expVar[i][2]*480 && (swinger[a][10] == 2 || swinger[a][10] == 3 || swinger[a][10] == 4)) {
              swinger[a][13]-=expVar[i][5];
              if (swinger[a][13]<0) {
                swinger[a][13]=-1;
              }
            }
          }
        }
      } else {
        expVar[i][4] = 0;
      }
    }
  }
}

void missleMain () {
  for (int i = 0; i<missleAmount; i++) {
    if (missle[i][7] == 0) {
      if (missle[i][5]>missle[i][6]) {
        missle[i][6]++;
      } else {
        missle[i][7] = 1;
      }
    }
    if (missle[i][7] == 1) {
      missleStart (i);
    }
    if (missle[i][7] == 2) {
      missleWarn (i);
    }
    if (missle[i][7] == 3) {
      misslePrep (i);
    }
    if (missle[i][7] == 4) {
      missleFly (i);
    }
    if (missle[i][7] == 5) {
      boomCheck (missle[i][0], missle[i][1], 0.5, 125);
      missle[i][7] = 6;
      missle[i][6]= 0;
      missle[i][5]= random(90, 450);
      missle[i][7] = 6;
    }
    if (missle[i][7] == 6) {
      misslePreExp (i);
    }
  }
}

void missleStart (int x) {
  if (RNG < 0.25) {
    missle[x][0] = random(0, 1340);
    missle[x][1] = -50;
    warningMissle[x][0] = missle[x][0]-50;
    warningMissle[x][1] = -80;
  }
  if (RNG >= 0.25 && RNG < 0.5) {
    missle[x][0] = random(0, 1340);
    missle[x][1] = 850;
    warningMissle[x][0] = missle[x][0]-50;
    warningMissle[x][1] = 680;
  }
  if (RNG >= 0.5 && RNG < 0.75) {
    missle[x][0] = -50;
    missle[x][1] = random(100, 700);
    warningMissle[x][0] = -80;
    warningMissle[x][1] = missle[x][1]-50;
  }
  if (RNG >= 0.75 && RNG <= 1) {
    missle[x][0] = 1500;
    missle[x][1] = random(100, 700);
    warningMissle[x][0] = 1420;
    warningMissle[x][1] = missle[x][1]-50;
  }
  missle[x][7] = 2;
}

void missleWarn(int x) {
  warningMissle[x][2]++;
  fill (160);
  if (warningMissle[x][2]>=15 && warningMissle[x][2]<30) {
    rect (warningMissle[x][0], warningMissle[x][1], 100, 100);
  }
  if (warningMissle[x][2]>=45 && warningMissle[x][2]<60) {
    rect (warningMissle[x][0], warningMissle[x][1], 100, 100);
  }
  if (warningMissle[x][2]>=75 && warningMissle[x][2]<90) {
    rect (warningMissle[x][0], warningMissle[x][1], 100, 100);
  }
  if (warningMissle[x][2] == 100) {
    missle[x][7] = 3;
    warningMissle[x][2] = 0;
  }
}

void misslePrep (int x) {
  missle[x][2] = 35* -(missle[x][0] - main[0])/ sqrt(sq(missle[x][1] - main[1])+ sq(missle[x][0] - main[0]));
  missle[x][3] = 35* -(missle[x][1] - main[1])/ sqrt(sq(missle[x][1] - main[1])+ sq(missle[x][0] - main[0]));
  missle[x][7] = 4;
}

void missleFly (int x) {
  fill (160);
  strokeWeight (0);

  if (35* -(missle[x][0] - main[0])/ (abs(missle[x][1] - main[1])+ abs(missle[x][0] - main[0]))<missle[x][2]) {
    missle[x][2]-=2;
  }
  if (35* -(missle[x][0] - main[0])/ (abs(missle[x][1] - main[1])+ abs(missle[x][0] - main[0]))>missle[x][2]) {
    missle[x][2]+=2;
  }
  if (35* -(missle[x][1] - main[1])/ (abs(missle[x][1] - main[1])+ abs(missle[x][1] - main[1]))<missle[x][3]) {
    missle[x][3]-=2;
  } 
  if (35* -(missle[x][1] - main[1])/ (abs(missle[x][1] - main[1])+ abs(missle[x][1] - main[1]))>missle[x][3]) {
    missle[x][3]+=2;
  }

  missle[x][0] += missle[x][2];
  missle[x][1] += missle[x][3];

  if (missle[x][2] < 0) {
    if (missle[x][3]<0) {
      missle[x][4] = ((atan (missle[x][2]/missle[x][3])) * 180) / PI + 90;
    } else {
      missle[x][4] = ((atan (missle[x][2]/missle[x][3])) * 180) / PI + 270;
    }
  } else {
    if (missle[x][3]<0) {
      missle[x][4] = ((atan (missle[x][2]/missle[x][3])) * 180) / PI + 90;
    } else {
      missle[x][4] = ((atan (missle[x][2]/missle[x][3])) * 180) / PI - 90;
    }
  }

  missleDir[x][0][0] = sin (radians (110+missle[x][4])) * 60 + missle[x][0]; 
  missleDir[x][0][1] = cos (radians (110+missle[x][4])) * 60 + missle[x][1]; 

  missleDir[x][1][0] = sin (radians (70+missle[x][4])) * 60 + missle[x][0]; 
  missleDir[x][1][1] = cos (radians (70+missle[x][4])) * 60 + missle[x][1]; 

  missleDir[x][2][0] = sin (radians (-70+missle[x][4])) * 60 + missle[x][0]; 
  missleDir[x][2][1] = cos (radians (-70+missle[x][4])) * 60 + missle[x][1]; 

  missleDir[x][3][0] = sin (radians (-110+missle[x][4])) * 60 + missle[x][0]; 
  missleDir[x][3][1] = cos (radians (-110+missle[x][4])) * 60 + missle[x][1];

  quad (missleDir[x][0][0], missleDir[x][0][1], missleDir[x][1][0], missleDir[x][1][1], missleDir[x][2][0], missleDir[x][2][1], missleDir[x][3][0], missleDir[x][3][1]);

  missleTop[x][0][0] = missleDir[x][0][0];
  missleTop[x][0][1] = missleDir[x][0][1];
  missleTop[x][1][0] = missleDir[x][1][0];
  missleTop[x][1][1] = missleDir[x][1][1];
  missleTop[x][2][0] = 45*sin(radians(90+missle[x][4])) + (missleTop[x][0][0]+ missleTop[x][1][0])/2;
  missleTop[x][2][1] = 45*cos(radians(90+missle[x][4])) + (missleTop[x][0][1]+ missleTop[x][1][1])/2;
  fill (160);
  triangle (missleTop[x][0][0], missleTop[x][0][1], missleTop[x][1][0], missleTop[x][1][1], missleTop[x][2][0], missleTop[x][2][1]);
  missleCheck (x);
}

void missleCheck (int x) {
  if (dist (missle[x][0], missle[x][1], main[0], main[1])<100) {
    missle[x][7] = 5;
  }
}

void misslePreExp (int x) {
  fill (160+9.5*missleFade, 160-16*missleFade, 160-16*missleFade);
  strokeWeight (0);
  quad (missleDir[x][0][0], missleDir[x][0][1], missleDir[x][1][0], missleDir[x][1][1], missleDir[x][2][0], missleDir[x][2][1], missleDir[x][3][0], missleDir[x][3][1]);
  triangle (missleTop[x][0][0], missleTop[x][0][1], missleTop[x][1][0], missleTop[x][1][1], missleTop[x][2][0], missleTop[x][2][1]);
  if (missleFade<=9) {
    missleFade+=2;
  } else {
    missleFade = 0;
    missle[x][7] = 0;
  }
}

void mainPanel () {
  fill (150); 
  stroke (100);
  strokeWeight (3);
  rect (-10, 810, 1540, -110); 
  for (int i=0; i<30; i++) {
    gunAmount (i);
  }
  reloadVisual (); 
  abilityVisual();
  timer (); 
  heathBar ();
}

void heathBar () {
  fill (120);
  rect (925, 725, 475, 50);
  fill (255, 0, 0);
  rect (930, 730, health*0.31, 40);
  fill (0);
  textSize (20);
  text (round(health), 1125, 757);
  if (health<1500) {
    health+=0.1;
  }
  healAbility ();
}

void healAbility () {
  fill (200); 
  rect (850, 725, 50, 50); 
  fill (100);
  rect (850, 725, 50, (0.128)*healTimer[0]);
  fill (150); 
  textSize(30);
  text ("E", 865, 757); 
  textSize(9); 
  text ("to heal up", 853, 767);
  if (control[6] == 1 && healTimer[1] == 0) {
    healTimer[1] = 1;
    healTimer[0] = 390;
    if (health+300<1500) {
      health+= 300;
    } else {
      health = 1500;
    }
  }
  if (healTimer[1] == 1) {
    if (healTimer[0]>0) {
      healTimer[0]--;
    } else {
      healTimer[1] = 0;
    }
  }
}

void abilityVisual() {
  fill (200); 
  rect (350, 725, 50, 50); 
  fill (100);
  rect (350, 725, 50, (0.333333333)*abilityTimer[0][0]);
  fill (150); 
  textSize(30);
  text ("1", 365, 757); 
  textSize(9); 
  text ("for fireball", 352, 767);

  fill (200); 
  rect (425, 725, 50, 50); 
  fill (100);
  rect (425, 725, 50, (0.166666666)*abilityTimer[1][0]);
  fill (150); 
  textSize(30);
  text ("2", 440, 757); 
  textSize(9); 
  text ("for burst", 431, 767);

  fill (200); 
  rect (500, 725, 50, 50); 
  fill (100);
  rect (500, 725, 50, (0.1041)*abilityTimer[2][0]);
  fill (150); 
  textSize(30);
  text ("3", 515, 757); 
  textSize(9); 
  text ("360 shots", 502, 767);
}

void abilityMain() {


  if (control[7] == 1 && abilityTimer[0][1] == 0) {
    abilityTimer[0][1] = 1;
    abilityTimer[0][0] = 150;
    abilityCall (0, mouseX, mouseY);
  }
  if (abilityTimer[0][1] == 1) {
    if (abilityTimer[0][0]>0) {
      abilityTimer[0][0]--;
    } else {
      abilityTimer[0][1] = 0;
    }
  }

  if (control[8] == 1 && abilityTimer[1][1] == 0) {
    abilityTimer[1][1] = 1;
    abilityTimer[1][0] = 300;
    abilityCall (1, mouseX+random(-50, 50), mouseY+random(-50, 50));
  }
  if (abilityTimer[1][1] == 1) {
    if (abilityTimer[1][0]>0) {
      abilityTimer[1][0]--;
      if (abilityTimer[1][0]%2 == 0 && abilityTimer[1][0] > 269) {
        abilityCall (1, mouseX+random(-50, 50), mouseY+random(-50, 50));
      }
    } else {
      abilityTimer[1][1] = 0;
    }
  }

  if (control[9] == 1 && abilityTimer[2][1] == 0) {
    abilityTimer[2][1] = 1;
    abilityTimer[2][0] = 480;

    expImmune = 1;

    abilityCall (2, main[0] + 100, main[1]);
    abilityCall (2, main[0] - 100, main[1]);

    abilityCall (2, main[0], main[1] + 100);
    abilityCall (2, main[0], main[1] - 100);

    abilityCall (2, main[0] + 200, main[1] + 100);
    abilityCall (2, main[0] + 100, main[1] + 200);

    abilityCall (2, main[0] + 200, main[1] - 100);
    abilityCall (2, main[0] + 100, main[1] - 200);

    abilityCall (2, main[0] - 200, main[1] + 100);
    abilityCall (2, main[0] - 100, main[1] + 200);

    abilityCall (2, main[0] - 200, main[1] - 100);
    abilityCall (2, main[0] - 100, main[1] - 200);
  }
  if (abilityTimer[2][1] == 1) {
    if (abilityTimer[2][0]>0) {
      if (abilityTimer[2][0] == 450 || abilityTimer[2][0] == 420) {
        abilityCall (2, main[0] + 100, main[1]);
        abilityCall (2, main[0] - 100, main[1]);

        abilityCall (2, main[0], main[1] + 100);
        abilityCall (2, main[0], main[1] - 100);

        abilityCall (2, main[0] + 200, main[1] + 100);
        abilityCall (2, main[0] + 100, main[1] + 200);

        abilityCall (2, main[0] + 200, main[1] - 100);
        abilityCall (2, main[0] + 100, main[1] - 200);

        abilityCall (2, main[0] - 200, main[1] + 100);
        abilityCall (2, main[0] - 100, main[1] + 200);

        abilityCall (2, main[0] - 200, main[1] - 100);
        abilityCall (2, main[0] - 100, main[1] - 200);
      }

      if (abilityTimer[2][0] == 390) {
        expImmune = 0;
      }

      abilityTimer[2][0]--;
    } else {
      abilityTimer[2][1] = 0;
    }
  }
  abilityShoot ();
}

void abilityCall(int a, float tx, float ty) {
  for (int i = 0; i<150; i++) {
    if (ability[i][4] == 0) {
      if (a == 2) {
        pew.play(1, 0.02);
      } else {
        pew.play(1, 0.3);
      }
      ability[i][0] = main[0];
      ability[i][1] = main[1];
      ability[i][2] = -40*(ability[i][0] - tx)/sqrt( sq(ability[i][0] - tx) + sq (ability[i][1] - ty));
      ability[i][3] = -40*(ability[i][1] - ty)/sqrt( sq(ability[i][0] - tx) + sq (ability[i][1] - ty));
      ability[i][4] = 1;
      ability[i][5] = a;
      break;
    }
  }
}

void abilityShoot () {
  for (int i = 0; i<150; i++) {
    if (ability[i][4] == 1) {
      if (((ability[i][0] < 10 || ability[i][0] >1430 || ability[i][1] < 15 || ability[i][1]>680) && ability [i][5] != 1) || ((ability[i][0] < -10 || ability[i][0] >1450 || ability[i][1] < -10 || ability[i][1]>710) && ability [i][5] == 1)) {
        if (ability[i][5] == 0) {
          boomCheck (ability[i][0], ability[i][1], 0.35, 310);
        } else if (ability[i][5] == 2) {
          boomCheck (ability[i][0], ability[i][1], 0.2, 140);
        }
        ability[i][0] = 0;
        ability[i][1] = 0;
        ability[i][2] = 0;
        ability[i][3] = 0;
        ability[i][4] = 0;
        ability[i][5] = 0;
      } else {
        for (int a = 0; a<max(turretAmount, missleAmount, swingerAmount); a++) {
          if (a<turretAmount) {
            if (dist(ability[i][0], ability[i][1], turret[a][0], turret[a][1])<100 && (turret[a][10] == 2 || turret[a][10] == 3) && ability[i][5] == 0) {
              boomCheck (ability[i][0], ability[i][1], 0.35, 310);
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
            if (dist(ability[i][0], ability[i][1], turret[a][0], turret[a][1])<50 && (turret[a][10] == 2 || turret[a][10] == 3) && ability[i][5] == 1) {
              turret[a][13] -=75;
              if (turret[a][13]<0) {
                turret[a][13]=-1;
              }
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
            if (dist(ability[i][0], ability[i][1], turret[a][0], turret[a][1])<75 && (turret[a][10] == 2 || turret[a][10] == 3) && ability[i][5] == 2) {
              boomCheck (ability[i][0], ability[i][1], 0.2, 140);
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
          }

          if (a<missleAmount) {
            if (dist (ability[i][0], ability[i][1], missle[a][0], missle[a][1])<50 && missle[a][7] == 4 && ability[i][5] == 0) {
              boomCheck (ability[i][0], ability[i][1], 0.35, 310);
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
            if (dist (ability[i][0], ability[i][1], missle[a][0], missle[a][1])<50 && missle[a][7] == 4  && ability[i][5] == 1) {
              missle[a][7] = 5;
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
            if (dist (ability[i][0], ability[i][1], missle[a][0], missle[a][1])<50 && missle[a][7] == 4  && ability[i][5] == 2) {
              boomCheck (ability[i][0], ability[i][1], 0.2, 140);
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
          }
          if (a<swingerAmount) {
            if (dist (ability[i][0], ability[i][1], swinger[a][0], swinger[a][1])<50 && (swinger[a][10] == 4 || swinger[a][10] == 3 || swinger[a][10] == 2) && ability[i][5] == 0) {
              boomCheck (ability[i][0], ability[i][1], 0.35, 310);
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
            if (dist (ability[i][0], ability[i][1], swinger[a][0], swinger[a][1])<50 && (swinger[a][10] == 4 || swinger[a][10] == 3 || swinger[a][10] == 2) && ability[i][5] == 1) {              
              swinger[a][13] -=75;
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
            if (dist (ability[i][0], ability[i][1], swinger[a][0], swinger[a][1])<50 && (swinger[a][10] == 4 || swinger[a][10] == 3 || swinger[a][10] == 2) && ability[i][5] == 2) {
              boomCheck (ability[i][0], ability[i][1], 0.2, 140);
              ability[i][0] = 0;
              ability[i][1] = 0;
              ability[i][2] = 0;
              ability[i][3] = 0;
              ability[i][4] = 0;
              ability[i][5] = 0;
              break;
            }
          }
        }
      }

      ability[i][0] += ability[i][2];
      ability[i][1] += ability[i][3];

      if (ability[i][5] == 1) {
        fill (#00FFFF);
      } else {
        fill (200, 0, 0);
      }
      strokeWeight (3);
      ellipse (ability[i][0], ability[i][1], 20, 20);
    }
  }
}

void timer () {
  time[0]++; 
  if (time[0] == 30) {
    time[0] = 0; 
    time[1] ++;
  }
  if (time[1] == 60) {
    time[1] = 0; 
    time[2] ++;
  }
  if (time[1] < 10) {
    realTime = "0" + time[1];
  } else {
    realTime = str (time[1]);
  }
  textSize (50); 
  fill (0); 
  text (time[2] + ":" + realTime, 650, 770);
}

void gunAmount (int x) {
  strokeWeight (0); 
  if (bullet[cmag[0]][x][4]==0) {
    fill (255, 255, 0);
  } else {
    fill (200);
  }

  if (x>= 20) {
    rect (40+21*(x-20), 759, 20, 16);
  } else if (x>= 10) {
    rect (40+21*(x-10), 742, 20, 16);
  } else {
    rect (40+21*x, 725, 20, 16);
  }
}

void reloadVisual () {

  fill (200); 
  if (reload[0] == 1 || reloadTime[1] == 1) {
    fill (100);
  }
  rect (275, 725, 50, 50); 

  fill (150); 
  textSize(30); 
  text ("R", 290, 757); 
  textSize(9); 
  text ("to reaload", 278, 767);
}

void gunTimer () {
  shootTimer++; 
  if (shootTimer == 5) {
    shootTimer = 0;
  }
  if (control[5] == 0) {
    shootTimer = 0;
  }
}

void reloadMain () {
  if ((control[4] == 1 || runOut == 1) && reload[0] == 0 && reloadTime[0] == 0) {
    reload[0] = 1; 
    reloadStart ();
  }
  if (reload[0] == 1) {
    reloadWait();
  }
  for (int i = 0; i<30; i++) {
    if (bullet[cmag[0]][i][4] == 1) {
      runOut = 1;
    } else {
      runOut = 0;
    }
  }
  reloadTimer ();
}

void reloadStart () {
  for (int i = 0; i<30; i++) {
    if (bullet[cmag[0]][i][4] == 1) {
      reload[2] += 3;
    }
  }
  reload[0] = 1;
}

void reloadWait () {
  if (reload[1] < reload[2]) {
    reload[1]++; 
    for (int i = (reload[2]/3-reload[1]/3); i<30; i++) {
      fill (255, 255, 0);
      if (i>= 20) {
        rect (40+21*(i-20), 759, 20, 16);
      } else if (i>= 10) {
        rect (40+21*(i-10), 742, 20, 16);
      } else {
        rect (40+21*i, 725, 20, 16);
      }
    }
  } else {
    reloaded();
  }
}

void reloaded () {
  if (cmag[0] == 0) {
    cmag[0] = 1;
  } else {
    cmag[0] = 0;
  }

  for (int i = 0; i<30; i++) {
    bullet[cmag[0]][i][4] = 0; 
    bullet[cmag[0]][i][2] = 0; 
    bullet[cmag[0]][i][3] = 0;
  }
  reload[2] = 0; 
  reload[1] = 0; 
  reload[0] = 0; 
  for (int i = 0; i<30; i++) {
    fill (255, 255, 0);
    if (i>= 20) {
      rect (40+21*(i-20), 759, 20, 16);
    } else if (i>= 10) {
      rect (40+21*(i-10), 742, 20, 16);
    } else {
      rect (40+21*i, 725, 20, 16);
    }
  }
  reloadTime[1] = 1;
}

void reloadTimer () {
  if (reloadTime[1] == 1) {
    reloadTime[0]++;
  }
  if (reloadTime[0] == 45) {
    reloadTime[0] = 0; 
    reloadTime[1] = 0;
  }
}

void shoot () {
  for (int i = 0; i<30; i++ ) {
    if (bullet[cmag[0]][i][4] == 0) {
      bullet[cmag[0]][i][4] = 1; 
      bullet[cmag[0]][i][2] = 40*(mouseX - main[0])/sqrt( sq(mouseX - main[0])+sq(mouseY - main[1])); 
      bullet[cmag[0]][i][3] = 40*(mouseY - main[1])/sqrt( sq(mouseX - main[0])+sq(mouseY - main[1])); 
      break;
    }
  }
}

void bulletMain () {
  for (int x = 0; x<2; x++) {
    for (int i = 0; i<30; i++) {
      if (bullet[x][i][4] == 1) {
        bulletFly (i, x);
      } else {
        bullet[x][i][0] = main[0]; 
        bullet[x][i][1] = main[1];
      }
    }
  }
}

void bulletFly (int x, int y) {
  bullet[y][x][0] += bullet[y][x][2]; 
  bullet[y][x][1] += bullet[y][x][3];

  for (int i = 0; i<turretAmount; i++) {
    if (dist(bullet[y][x][0], bullet[y][x][1], turret[i][0], turret[i][1])<50 && (turret[i][10] == 2 || turret[i][10] == 3)) {
      if (dificulty == 3) {
        turret[i][13]-=40;
      } else {
        turret[i][13]-=50;
      }
      bullet[y][x][0] = 9999;
      bullet[y][x][1] = 9999;
      bullet[y][x][2] = 0;
      bullet[y][x][3] = 0;
    }
  }


  for (int i = 0; i<missleAmount; i++) {
    if (dist (bullet[y][x][0], bullet[y][x][1], missle[i][0], missle[i][1])<50 && missle[i][7] == 4) {
      missle[i][7] = 5;
      bullet[y][x][0] = 9999;
      bullet[y][x][1] = 9999;
      bullet[y][x][2] = 0;
      bullet[y][x][3] = 0;
    }
  }

  for (int i = 0; i<swingerAmount; i++) {
    if (dist (bullet[y][x][0], bullet[y][x][1], swinger[i][0], swinger[i][1])<50 && (swinger[i][10] == 2 || swinger[i][10] == 3 || swinger[i][10] == 4)) {
      if (dificulty == 3) {
        swinger[i][13]-=40;
      } else {
        swinger[i][13]-=50;
      }
      bullet[y][x][0] = 9999;
      bullet[y][x][1] = 9999;
      bullet[y][x][2] = 0;
      bullet[y][x][3] = 0;
    }
  }
}

void bulletDraw () {
  for (int x = 0; x<2; x++) {
    for (int i = 0; i<30; i++) {
      fill (150);
      ellipse (bullet[x][i][0], bullet[x][i][1], 15, 15);
    }
  }
}

void mainDraw () {
  strokeWeight (5); 
  stroke (150); 
  fill (0, 130, 0); 
  if (expImmune == 1) {
    fill (130, 130, 0);
  }
  ellipse (main[0], main[1], 100, 100);
}

void mainTdraw () {
  fill (0, 175, 0); 
  if (expImmune == 1) {
    fill (175, 175, 0);
  }
  strokeWeight (2); 
  stroke (125); 
  mainRotete (); 
  quad (gun[0][0], gun[0][1], gun[1][0], gun[1][1], gun[2][0], gun[2][1], gun[3][0], gun[3][1]); 

  strokeWeight (3); 
  stroke (100); 
  fill (0, 200, 0); 


  if (warningVal > 0 ) {
    fill (warningVal, 200-(200*warningVal*0.003921), 0);
    warningVal -= 10;
  }
  if (expImmune == 1) {
    fill (200, 200, 0);
  }
  ellipse (main[0], main[1], 50, 50);
}

void mainRotete () {
  if (main[0]-mouseX < 0) {
    main[4] = degrees (atan ((main[1]-mouseY)/(main[0]-mouseX)));
  } else {
    main[4] = degrees (atan ((main[1]-mouseY)/(main[0]-mouseX)) - PI);
  }
  if (main[4] < 0) {
    main[4] = 360 + main[4];
  }
  main[4] = 360 - main[4]; 

  gun[0][0] = sin (radians (110+main[4])) * 40 + main[0]; 
  gun[0][1] = cos (radians (110+main[4])) * 40 + main[1]; 

  gun[1][0] = sin (radians (70+main[4])) * 40 + main[0]; 
  gun[1][1] = cos (radians (70+main[4])) * 40 + main[1]; 

  gun[2][0] = sin (radians (main[4])) * 6 + main[0]; 
  gun[2][1] = cos (radians (main[4])) * 6 + main[1]; 

  gun[3][0] = sin (radians (-180+main[4])) * 6 + main[0]; 
  gun[3][1] = cos (radians (-180+main[4])) * 6 + main[1];
}


void mainVar () {
  if (control[0] == 1 && main[3] > -25) {
    main[3] -= 3;
  }
  if (control[1] == 1 && main[2] > -25) {
    main[2] -= 3;
  }
  if (control[2] == 1 && main[2] < 25) {
    main[2] += 3;
  }
  if (control[3] == 1 && main[3] < 25) {
    main[3] += 3;
  }
  if (main[0] < 25) {
    main[0] = 25; 
    main[2] = -main[2]/2;
  }
  if (main[0] > 1415) {
    main[0] = 1415; 
    main[2] = -main[2]/2;
  }
  if (main[1] < 25) {
    main[1] = 25; 
    main[3] = -main[3]/2;
  }
  if (main[1] > 675) {
    main[1] = 675; 
    main[3] = -main[3]/2;
  }
  main[0] += main[2]; 
  main[1] += main[3];
}

void mainStb () {
  if (main[2] > 0) {
    main[2]-= 1;
  }
  if (main[2] < 0) {
    main[2]+= 1;
  }
  if (-1 < main[2] && main[2] < 1) {
    main[2] = 0;
  }
  if (main[3] > 0) {
    main[3]-= 1;
  }
  if (main[3] < 0) {
    main[3]+= 1;
  }
  if (-1 < main[3] && main[3] < 1) {
    main[3] = 0;
  }
}

void randomNumberGenerator () {
  RNG = random(1);
}

void keyPressed () {
  if (keyCode == UP || key == 'w') {
    control[0] = 1;
  }
  if (keyCode == LEFT || key == 'a') {
    control[1] = 1;
  }
  if (keyCode == RIGHT || key == 'd') {
    control[2] = 1;
  }
  if (keyCode == DOWN || key == 's') {
    control[3] = 1;
  }
  if (key == 'r') {
    control[4] = 1;
  }
  if (key == 'e') {
    control[6] = 1;
  }
  if (key == '1') {
    control[7] = 1;
  }
  if (key == '2') {
    control[8] = 1;
  }
  if (key == '3') {
    control[9] = 1;
  }
  if (key == 'f') {
    control[10] = 1;
  }
  if (key == 'l') {
    control[11] = 1;
  }
  if (key == 'k') {
    control[12] = 1;
  }
}

void mouseReleased () {
  control[5] = 0;
}

void keyReleased () {
  if (keyCode == UP || key == 'w') {
    control[0] = 0;
  }
  if (keyCode == LEFT || key == 'a') {
    control[1] = 0;
  }
  if (keyCode == RIGHT || key == 'd') {
    control[2] = 0;
  }
  if (keyCode == DOWN || key == 's') {
    control[3] = 0;
  }
  if (key == 'r') {
    control[4] = 0;
  }
  if (key == 'e') {
    control[6] = 0;
  }
  if (key == '1') {
    control[7] = 0;
  }
  if (key == '2') {
    control[8] = 0;
  }
  if (key == '3') {
    control[9] = 0;
  }
  if (key == 'f') {
    control[10] = 0;
  }
  if (key == 'l') {
    control[11] = 0;
  }
  if (key == 'k') {
    control[12] = 0;
  }
}
