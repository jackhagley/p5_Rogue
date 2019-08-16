
PImage hero_sprite;

interface Controllable 
{


  void setMoves();
  PVector moveDirection(char c);
}


class Hero extends Creature implements Controllable
{
  PVector north;
  PVector east;
  PVector south;
  PVector west;
  
  PShape shape;

  int memory_size = int(random(3000, 10000)); //in action points

  Hero(Level l, Tile t)
  {
    super(l, t, "hero");

    ////all below will be hel  d in the json I think

    base_size = 10;
    LightSource torch = new LightSource(this);
    //InvisibleLight torch = new InvisibleLight(this);
    torch.setRadius(5);
    //torch.setColour(color(255));
    is_known_to_player = true;
    fov.setRadius(100);
    setMoves();
    move_action_points = 10;
    turn_action_points = 1;
    is_player = true;
    t.becomeKnown();
    sprite_name = "hero";
    shape = loadShape("sprites/hero/chr_rain.obj");
    ///hero_sprite = loadImage("sprites/hero.png");
  }

  void command()
  {
    if (key == CODED)
    {
      if (keyCode == UP)
      {
        hero.move('n');
      }
      if (keyCode == DOWN)
      {
        hero.move('s');
      }
      if (keyCode == LEFT)
      {
        hero.move('w');
      }
      if (keyCode == RIGHT)
      {
        hero.move('e');
      }
    }

    switch(key)
    {
    case ' ':
      game.cursorToggle();
      break;

    case 'r':
      game.reset();
      break;

    case 'a':
      turn(-PI/2);
      view.rotate(PI/2);
      break;

    case 'd':
      turn(PI/2);
      view.rotate(-PI/2);
      break;

    case 'w':
      view.zoomIn();
      break;

    case 's':
      view.zoomOut();
      break;
    }
    return;
  }

  void update()
  {
    super.update();
    game.sc.computeVisibility(fov, x, y, fov.radius);
    tile.becomeKnown();
  }

  void display()
  {
    noStroke();
    fill(222, 0, 0);
    ellipse(view.ts2(), view.ts2(), view.ts(), view.ts());
    pushMatrix();

    translate(view.ts2(), view.ts2(), 0);


    noStroke();

    shape.resetMatrix();
    shape.rotateX(PI/2);
    shape.applyMatrix(view.matrix2);
    shape.translate(-view.ts2(), -view.ts2(),-view.ts2());
    
    ////rotates with view
    shape.rotateZ(-view.rot);


    //translate(view.ts2(), view.ts2(), 0);
    //translate(-view.ts(), -view.ts(), view.ts());






    //


    //translate(-view.ts2(), 0, view.ts());

    stroke(255);
    strokeWeight(10);
    point(0, 0, 0);
    noStroke();
    shape(shape);

    popMatrix();
  }

  void turn(float amount)
  {
    super.turn(amount);
    game.world.current_level.increaseActionPointsOfKnownTiles(turn_action_points);
  }

  void move(char c)
  {
    PVector moveVector = moveDirection(c);

    if (canMove(moveVector))
    {

      super.move( int(moveVector.x), int(moveVector.y) );
      tile.becomeKnown();
      view.needs_light_update = true;
      game.world.current_level.increaseActionPointsOfKnownTiles(move_action_points);
      view.centreView(this);
      game.state = STATE.GAME_TURN;
    }
  }

  PVector moveDirection(char c)
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

    return moveVector.rotate(-view.drot);
  }

  void setMoves()
  {
    north = new PVector(0, 1);
    east = new PVector(-1, 0);
    south = new PVector(0, -1);
    west = new PVector(1, 0);
  }
}
