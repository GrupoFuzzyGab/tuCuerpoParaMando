import ddf.minim.*; 
Minim minim; 
AudioSnippet player;

void setup() { 
  minim = new Minim(this);
  player = minim.loadSnippet("coro.mp3");
  player.play();
}
void draw() {
}
void stop() 
{
  player.close();
  minim.stop();
  super.stop();
}

