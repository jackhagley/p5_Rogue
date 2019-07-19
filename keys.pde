void keyReleased()
{



  //////PLAY////////
  if (game.state == STATE.HERO_TURN)
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
  }

  if (game.state == STATE.CURSOR)
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
    if (game.state == STATE.HERO_TURN)
    {
      hero.turn(-PI/2);
      view.rotate(PI/2);
    }
    break;

  case 'd':
    if (game.state == STATE.HERO_TURN)
    {
      hero.turn(PI/2);
      view.rotate(-PI/2);
    }
    break;

  case 'w':
    view.zoomIn(.5);
    break;

  case 's':
    view.zoomOut(.5);
    break;
  }
}
//////PLAY////////
