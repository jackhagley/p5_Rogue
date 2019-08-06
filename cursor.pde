class Cursor implements Controllable
{
  int x, y;

  Tile tile;

  PVector north;
  PVector east;
  PVector south;
  PVector west;

  boolean cursor_active = false;
  boolean menu_open = false;




  RingMenu menu;

  Cursor()
  {
    resetToHero();
    setMoves();
  }

  void update()
  {
    if (cursor_active || menu_open)
    {
      view.setView(x, y);
    }
  }




  void command()
  {
    if (key == CODED)
    {

      if (keyCode == UP)
      {
        cursor.move('n');
      }
      if (keyCode == DOWN)
      {
        cursor.move('s');
      }
      if (keyCode == LEFT)
      {
        cursor.move('w');
      }
      if (keyCode == RIGHT)
      {
        cursor.move('e');
      }
    }

    switch(key)
    {
    case ' ':
      game.cursorToggle();
      break;

    case 'r':

      break;

    case 'a':

      break;

    case 'd':
      openRingMenu();
      break;

    case 'w':
      view.zoomIn(.5);
      break;

    case 's':
      view.zoomOut(.5);
      break;
    }
  }


  void menucommand()
  {

    if (menu!=null)
    {
      menu.command();
    }///menu null
  }


  void move(char c)
  {
    PVector moveVector = moveDirection(c);
    Tile tile_ = game.world.current_level.getTile(moveVector.x+x, moveVector.y+y);
    //if (tile_!=null && game.world.current_level.known_tiles.contains(tile_) )
    //{
    //  x+=moveVector.x;
    //  y+=moveVector.y;
    //  tile = tile_;
    //}
    //if (tile_!=null && game.world.current_level.known_tiles.contains(tile_) )
    //{
    x+=moveVector.x;
    y+=moveVector.y;
    tile = tile_;
    //}
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
    ///mask
    noStroke();
    fill(22, 200);
    rect(0, 0, width, height);



    pushStyle();
    pushMatrix();
    scale(view.zoom, view.zoom);
        if(iso)
    {
     scale(1, 0.707106781186548);
      
    }



    translate( (centre.x )/view.zoom, (centre.y )/view.zoom);///centred

    rotate(view.rot);
    if (iso)
    {
      rotate(TAU/8f);
    }


    if (tile!=null&&!menu_open)
    {
      pushMatrix();
      translate(-view.ts2(), -view.ts2());
      tile.display();
      popMatrix();
    }

    translate((view.x()-x)*view.ts(), (view.y()-y)*view.ts());

    noFill();

    if (menu!=null && menu_open)
    {
      menu.display();
    } else
    {
      stroke(255);
      strokeWeight(3/view.zoom);
      rect(-view.ts2(), -view.ts2(), view.ts(), view.ts());
    }

    popStyle();



    popMatrix();
  }

  void activate()
  {
    resetToHero();
    view.storeZoom();
    cursor_active = true;
  }

  void deactivate()
  {
    cursor_active = false;
    menu_open = false;
    view.loadZoom();
  }

  void openRingMenu()
  {
    if (game.world.current_level.known_tiles.contains(tile))
    {
      menu = new RingMenu(tile);
      game.state = STATE.MENU;
      //view.storeZoom();
      view.zoomAtMax();
      menu_open = true;
      menu.open();
      println("opening ring menu");
    }
  }

  void closeRingMenu()
  {
    menu = null;
    cursor_active = true;
    game.state = STATE.CURSOR;
    view.loadZoom();
    menu_open = false;
    println("closing ring menu");
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
