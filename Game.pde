enum STATE {
  MENU, 
    PLAYER_TURN, 
    GAME_TURN
};

class Game
{
  STATE state;
  World world;
  ShadowCast sc;

  MenuManager menuManager;
  HUD hud;

  Game()
  {
    //state = STATE.MENU;

    state = STATE.PLAYER_TURN;

    menuManager = new MenuManager();

    //build menus
    menuManager.buildMenus();
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

    player = new Player(start_level, player_start_tile);

    view.centreView(player);
    player.display(100, true);

    game_is_ready=true;
    //updateView();
  }

  void updateView()
  {
    world.current_level.updateView();
  }

  void run()
  {
    //updateView();

    view.update();



    if (state == STATE.MENU)
    {
      //camera(width/2.0,height/2.0,(height/2.0) / tan(PI*30.0 / 180.0), width/2.0, 0, height/2.0, 0, 1, 0);
      menuManager.run();
    } else
    {  
      //camera(width/2.0,height/2.0,(height/2.0) / tan(PI*30.0 / 180.0), width/2.0, 300, height/2.0, 0, 1, 0);
      world.run();
    }
    //hud.display();

    // world.run();
  }

  void start()
  {
  }
}
