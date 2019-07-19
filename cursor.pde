class Cursor implements Controllable
{
  int x, y;

  Tile tile;

  PVector north;
  PVector east;
  PVector south;
  PVector west;

  boolean open = false;

  Cursor()
  {
    resetToHero();
    setMoves();
  }

  void update()
  {
    if (open)
    {
      view.setView(x, y);
    }
  }


  void move(char c)
  {
    PVector moveVector = moveDirection(c);

    //Tile t = level.getTile(moveVector.x+x, moveVector.y+y);

    Tile tile_ = game.world.current_level.getTile(moveVector.x+x, moveVector.y+y);


    if (tile_!=null && game.world.current_level.known_tiles.contains(tile_) )
    {

        x+=moveVector.x;
        y+=moveVector.y;
        tile = tile_;
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

  void display()
  {
    pushStyle();
    pushMatrix();

    scale(view.zoom, view.zoom);
    translate( (centre.x )/view.zoom, (centre.y )/view.zoom);///centred
    rotate(view.rot);

    translate((view.x()-x)*tile_size, (view.y()-y)*tile_size);
    noFill();
    stroke(255);
    strokeWeight(3/view.zoom);
    rect(-tile_size/2, -tile_size/2, tile_size, tile_size);
    popStyle();
    popMatrix();
  }

  void activate()
  {
    resetToHero();
    open = true;
  }

  void deactivate()
  {
    open = false;
  }

  void resetToHero()
  {
    x = hero.x;
    y = hero.y;
    north = hero.north.copy();
    east = hero.east.copy();
    south = hero.south.copy();
    west = hero.west.copy();
    tile = hero.tile;
  }

  void run()
  {
    update();
    display();
  }
}
