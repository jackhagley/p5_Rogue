void keyReleased()
{
  if (game.state == STATE.HERO_TURN)
  {
    hero.command();
    return;
  }

  if (game.state == STATE.CURSOR)
  {
    cursor.command();
    return;
  }

  if (game.state == STATE.MENU)
  {
    println("menu command");
    cursor.menucommand();
    return;
  }
}
//////PLAY////////
