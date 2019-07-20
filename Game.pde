enum STATE 
{
  HERO_TURN, 
    GAME_TURN, 
    CURSOR, 
    MENU,
}

class Game
{
  STATE state;
  World world;
  ShadowCast sc;

  RingMenu menu;

  Game()
  {
    reset();
  }

  void reset()
  {
    state = STATE.HERO_TURN;
    game_is_ready = false;
    world = new World();
    Level start_level = world.levels.get(0);
    sc = new ShadowCast();
    Tile player_start_tile = start_level.stairs_down.get(0);
    hero = new Hero(start_level, player_start_tile);
    view.centreView(hero);
    hero.display(100, true);
    game_is_ready=true;
  }

  void updateView()
  {
    world.current_level.updateLight();
  }

  void run()
  {
    view.update();
    world.run();

    if (state == STATE.CURSOR || state == STATE.MENU  )
    {
      cursor.run();
    }

    if (state == STATE.MENU && menu!=null )
    {
      menu.run();
    }
  }

  void cursorToggle()
  {
    if (state == STATE.HERO_TURN)
    {
      state = STATE.CURSOR;
      println("cursor on");
      cursor.activate();
      return;
    }

    if (state == STATE.CURSOR || state == STATE.MENU )
    {
      state = STATE.HERO_TURN;
      cursor.deactivate();
      view.centreToHero();
      view.loadZoom();
      updateView();
      println("cursor off");
      return;
    }
  }

  void start()
  {
  }
}
