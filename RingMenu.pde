class RingMenu
{
  /////Theres a game inside the menus
  /////they must be fun to use
  
  
  Tile tile;

  RingMenu(Tile t)
  {
    ///loads straight from tile
    this.tile = t;
    game.menu = this;
    
  }

  void command()
  {
    if (key == CODED)
    {

      if (keyCode == UP)
      {
        //cursor.move('n');
      }
      if (keyCode == DOWN)
      {
        //cursor.move('s');
      }
      if (keyCode == LEFT)
      {
        //cursor.move('w');
      }
      if (keyCode == RIGHT)
      {
        //cursor.move('e');
      }
    }

    switch(key)
    {
    case ' ':
      cancel();
      break;

    case 'r':

      break;

    case 'a':
   close();
      break;

    case 'd':

      break;

    case 'w':

      break;

    case 's':
      //close();
      break;
    }
  }

  void update()
  {
  }

  void display()
  {
    ellipse(0, 0, tile_size*2, tile_size*2);
  }

  void cancel()
  {
    game.cursorToggle();
     view.loadZoom();
    game.menu = null;
  }

  void close()
  {
    cursor.closeRingMenu();
    view.loadZoom();
    game.menu = null;
  }



  void open()
  {
    //view.storeZoom();
  }

  void run()
  {
    update();
    display();
  }
}
