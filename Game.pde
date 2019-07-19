enum STATE 
{
  HERO_TURN, 
    GAME_TURN, 
    CURSOR,
}

class Game
{
  STATE state;
  World world;
  ShadowCast sc;
  HUD hud;

  Game()
  {
    state = STATE.HERO_TURN;
    hud = new HUD();
    reset();
  }

  void reset()
  {
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

    if (state == STATE.CURSOR)
    {
      cursor.run();
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

    if (
      state == STATE.CURSOR)
    {
      state = STATE.HERO_TURN;
      cursor.deactivate();
      view.centreToHero();
      updateView();
      println("cursor off");
      return;
    }
  }

  void start()
  {
  }
}
