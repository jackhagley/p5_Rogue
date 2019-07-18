enum STATE {
  CURSOR, 
    HERO_TURN, 
    GAME_TURN
};

class Game
{
  STATE state;
  World world;
  ShadowCast sc;
  HUD hud;


  Game()
  {
    //state = STATE.MENU;

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


    ///find open tile for player to start



    //  while (!tile_found)
    //{
    //  //int x = int(random(0, world.current_level.x_size));
    //  //int y = int(random(world.current_level.y_size*.1, world.current_level.y_size*.9));
    //}



    Tile player_start_tile = start_level.stairs_down.get(0);

    hero = new Hero(start_level, player_start_tile);

    view.centreView(hero);
    hero.display(100, true);

    game_is_ready=true;
    //updateView();
  }

  void updateView()
  {
    world.current_level.updateView();
  }

  void run()
  {
    view.update();

    if (state == STATE.CURSOR)
    {

    } else
    {  
      world.run();
    }
  }

  void start()
  {
  }
}
