class RingMenu
{
  Tile tile;

  RingMenu(Tile t)
  {
    ///loads straight from tile
    this.tile = t;
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
      game.cursorToggle();
      break;

    case 'r':

      break;

    case 'a':

      break;

    case 'd':

      break;

    case 'w':

      break;

    case 's':
      cursor.closeRingMenu();
      break;
    }
  }

  void display()
  {
  }

  void open()
  {
  }

  void close()
  {
  }
}
