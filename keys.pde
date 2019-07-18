void keyReleased()
{

  //////MENU////////
  if (game.state == STATE.MENU)
  {
    switch(key)
    {
    }
  }
  //////MENU////////


  //////PLAY////////
  if (game.state == STATE.PLAYER_TURN)
  {
    if (key == CODED)
    {

      if (keyCode == UP)
      {
        player.move('n');
      }
      if (keyCode == DOWN)
      {
        player.move('s');
      }
      if (keyCode == LEFT)
      {
        player.move('w');
      }
      if (keyCode == RIGHT)
      {
        player.move('e');
      }
    }



    switch(key)
    {
    case 'p':
      game.menuManager.goToMenu("pause");
      break;


    case 'l':
      light_debug = ! light_debug;
      break;


    case 'r':
      game.reset();
      break;

    case '=':
      view.zoomIn(.1);
      break;

    case '-':
      view.zoomOut(.1);
      break;

    case 'e':

      break;

    case 'a':
      player.turn(-PI/2);
      view.rotate(PI/2);
      break;

    case 'd':
      player.turn(PI/2);
      view.rotate(-PI/2);
      break;

    case 'w':
      view.zoomIn(.3);
      break;

    case 's':
      view.zoomOut(.3);
      break;
    }
  }
  //////PLAY////////
}////keyreleased
