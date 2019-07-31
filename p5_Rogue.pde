

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
 
 a room is an oject that can be defined in json
 objects have probalility of generation
 
 rooms have probability
 rooms effect the probability of items/materials appearing
 a kitchen will have knives
 creatures have probability according to the rooms
 hot creatures do not spawn in cold places etc
 
 what if the three factors were red, white and black?
 playing cards (diamonds, hearts, spades, clubs)
 
 or black and white
 chess
 piano
 
 rock paper scissors
 
 red blue green
 
 
 when setting creatures can just label them as SLOW and that will be enough
 
 1000 actions is one second
 
 ring menus like SoM! how to navigate?
 
 keybinding JSON
 
 brain JSON
 behaviours are loaded like attributes, such as Wander, Hunt, Follow, Patrol, Retreat, Form Pack
 Pack Animal Attribute = 
 how does it choose between them? what are the conditions for each behaviour?
 What are the stats that make up a Creature’s 
 
 */


Game game;
Viewer view;
Hero hero;
Cursor cursor;
SpriteManager sm;


ThingFactory thingfactory;

void setup()
{
  size(800, 600); 
  println("loading viewer");
  view = new Viewer();
  centre = new PVector( width/2, (height/2)-(tile_size/2) );

  println("loading things");
  thingfactory = new ThingFactory();

  println("building game");
  game = new Game();



  //  mouse = new Mouse();
  
  cursor = new Cursor();
  println("game ready");

  view.startView();
}


void draw()
{
  game.run();
}
