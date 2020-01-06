PImage bg,start, guy, topPipe, botPipe;  
int bgx, bgy, gx, gy, g, Vgy;
int[] pipeX, pipeY; 
int gameState, score, highScore;

void setup()
{
  size(1000,800);
  bg = loadImage("./img/bg.png");
  start=loadImage("./img/Grames_startScreen.png");
  guy = loadImage("./img/i.png");
  botPipe = loadImage("./img/bottom_Pipe.png");
  topPipe = loadImage("./img/top_Pipe.png");
  gx = 100;
  gy = 50;
  g = 1; 
  pipeX = new int[5];
  pipeY = new int[pipeX.length];
  for(int i = 0; i < pipeX.length; i++)
  {
    pipeX[i] = width + 400*i;
    pipeY[i] = (int)random(-350, 0);
  } 
  gameState = -1;
}

void draw()
{
  if(gameState == -1)
  {
    startScreen();  
  }
  else if(gameState==0)
  {
    setBg();
    setPipes();
    guy(); 
    displayScore();
  }
  else
  {
    endScreen();
    restart();
  }
}

void endScreen()
{
    fill(150, 150, 250, 100);
    if(mouseX > 90 && mouseX < 595 && mouseY > 150 && mouseY < 290)
    {
      fill(150, 250, 150, 100);
    }
    rect(90, 150, 505, 140, 5);
    fill(0);
    textSize(40);
    text("The Football died     : (", 200,200);
    text("Click to play again." , 100, 270);  
}

void restart()
{
   if(mouseX > 90 && mouseX < 595 && mouseY > 150 && mouseY < 290)
   {
     if(mousePressed)
     {
        gy = height/2;
        for(int i = 0; i < pipeX.length; i++)
        {
          pipeX[i] = width + 400*i;
          pipeY[i] = (int)random(-350, 0);
        }      
        score = 0;
        gameState = 0;  
     } 
   }
}
void displayScore()
{
  if(score>highScore)
  {
    highScore = score;
  }
  fill(160,160,160, 200);
  rect(width-175, 10, 155, 80, 5);
  fill(0);
  textSize(32);
  text("Score: " + score, width - 170, 40);  
  text("High:  " + highScore, width - 170, 80);   
}

void startScreen()
{
  image(start, 0,0);
  if(mousePressed)
  {
    gy = height/2;
    gameState = 0;
  }
}
void setPipes()
{
  for(int i = 0; i < pipeX.length; i++)
  {
   image(topPipe, pipeX[i], pipeY[i]);
   image(botPipe, pipeX[i], pipeY[i] + 800);
   pipeX[i]-= 3;
   if(score > 10)
   {
     pipeX[i]--;  
   }
   if(score > 20)
   {
     pipeX[i]--;  
   }
   if(pipeX[i] < -200)
   {
     pipeX[i] = width*2;  
   }
   
   if(gx > (pipeX[i]-55) && gx < pipeX[i] + 55)
   {
     
     if(!(gy > pipeY[i] + 484 && gy < pipeY[i] + (800)))
     {;  
       gameState = 1;
     }
     else if (gx==pipeX[i] || gx == pipeX[i] + 1)
     {
       score++;  
     }
   }
  }  
}


void guy()
{
   image(guy, gx, gy);
   gy = gy + Vgy;
   Vgy = Vgy + g;  
   if(gy > height || gy < 0)
   {
     fill(255, 0, 0, 140);
     textSize(24);
     text("OH NO!!!! THE FOOTBALL FELL OFF THE SCREEN...", 20, 44);
     gameState=1;
   }
}

void mousePressed()
{
   Vgy = -15;  
}

void setBg()
{
  image(bg, bgx, bgy);
  image(bg, bgx + bg.width, bgy);
  bgx--;
  if(bgx < -bg.width)
  {
     bgx = 0; 
  }  
}
