

/*

Prototype RogueLike Engine in Processing
 
 multiple games against the clock
 - follow the white rabbit
 - retreive the items
 - get to the exit
 
 in the memories of an old woman, a young girl seeks objects to build memories
 
 SpriteBuilder builds sprites from vectors
 Doesn’t use pixels
 
 Menu system, how to have it all on the keyboard?
 
 Sound system, ambience
 Sound by distance
 footsteps echo, but by how much? 
 
 how to measure the size of a room or a space?
 do tiles know how big the room they are in, is?
 how sound reflective are certain materials?
 
 access cursor with space

 
 */


Game game;
Viewer view;
Player player;
Mouse mouse;
SpriteManager sm;

ThingFactory thingfactory;

void setup()
{
  size(800, 600); 
  println("loading viewer");
  view = new Viewer();
  centre = new PVector( width/2 , (height/2)-(tile_size/2) );
  //centre_x = (width/2);
  //centre_y = (height/2)-(tile_size/2);
  println("loading sprites");
  sm = new SpriteManager();

  thingfactory = new ThingFactory();
  println("loading things");
  game = new Game();
  
  println("building game");

  mouse = new Mouse();
  println("game ready");
  
  view.startView();
}


void draw()
{
  game.run();
}
