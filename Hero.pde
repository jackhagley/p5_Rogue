
PImage hero_sprite;

class Hero extends Creature
{
  int memory_size = int(random(30000, 100000)); //in action points
  PVector north;
  PVector east;
  PVector south;
  PVector west;
  Hero(Level l, Tile t)
  {
    super(l, t, "hero");

    ////all below will be hel  d in the json I think

    base_size = 10;
    LightSource torch = new LightSource(this);
    //InvisibleLight torch = new InvisibleLight(this);
    torch.setRadius(100);
    //torch.setColour(color(255));
    is_known_to_player = true;
    fov.setRadius(100);
    setMoves();
    move_action_points = 10;
    turn_action_points = 1;
    is_player = true;
    t.becomeKnown();
    sprite_name = "hero";
    hero_sprite = loadImage("sprites/hero.png");
  }



  void update()
  {
    super.update();
    //tile.highlight();


    game.sc.computeVisibility(fov, x, y, fov.radius);


    //needs_light_update = false;
  }


  void needsLightUpdate()
  {
    //needs_light_update = true;
  }


  void display(float light, boolean visible)
  {
    noStroke();
    fill(222, 0, 0);
    ellipse(tile_size/2, tile_size/2, tile_size, tile_size);
    //sm.printSprite(this);

    //image(sm.getSprite(sprite_name),200,200);
    image(hero_sprite, tile_size/2, tile_size/2);
    //image(hero_sprite,height/2,width/2);
  }

  void turn(float amount)
  {
    super.turn(amount);
    game.world.current_level.increaseActionPointsOfKnownTiles(turn_action_points);
    //game.state = STATE.GAME_TURN;
  }

  void setMoves()
  {
    north = new PVector(0, 1);
    east = new PVector(-1, 0);
    south = new PVector(0, -1);
    west = new PVector(1, 0);
  }

  void move(char c)
  {


    PVector moveVector = new PVector(0, 0);

    switch(c)
    {
    case 'n':
      moveVector=new PVector(north.x, north.y);
      break;

    case 'e':
      moveVector=new PVector(east.x, east.y);
      break;

    case 's':
      moveVector=new PVector(south.x, south.y);
      break; 

    case 'w':
      moveVector=new PVector(west.x, west.y);
      break;
    }

    moveVector = moveVector.rotate(-view.drot);

    if (canMove(moveVector))
    {

      super.move( int(moveVector.x), int(moveVector.y) );
      tile.becomeKnown();
     
      view.needs_light_update = true;
      game.world.current_level.increaseActionPointsOfKnownTiles(move_action_points);
       view.centreView(this);
      game.state = STATE.GAME_TURN;
    }


    //game.updateView();
  }
}
