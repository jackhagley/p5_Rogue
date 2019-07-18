void keyReleased()
{

  //////MENU////////
  if (game.state == STATE.CURSOR)
  {
    switch(key)
    {
    }
  }
  //////MENU////////


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



    switch(key)
    {

    case ' ':

      break;

    case 'r':
      game.reset();
      break;

    case 'a':
      hero.turn(-PI/2);
      view.rotate(PI/2);
      break;

    case 'd':
      hero.turn(PI/2);
      view.rotate(-PI/2);
      break;

    case 'w':
      view.zoomIn(1);
      break;

    case 's':
      view.zoomOut(1);
      break;
    }
  }
  //////PLAY////////
}////keyreleased
