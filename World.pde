class World
{
  int n_levels = 1;

  ArrayList<Level> levels;
  //int current_level = 0;
  int x_size = 50;
  int y_size = 50;
  ArrayList<Thing> things; //things master list
  Level current_level;

  World()
  {
    levels = new ArrayList<Level>();


    for (int i = 0; i<n_levels; i++)
    {
      Level new_level = levelMaker(x_size, y_size, DUNGEON);
      levels.add(new_level);
    }

    current_level = levels.get(0);

    things = new ArrayList<Thing>();
  }

  void run()
  {
    background(22);
    if (game.state != STATE.CURSOR)
    {
      current_level.registerCreatures();
      current_level.update();
      current_level.readyCreatureAct();
    }
    current_level.display();
  }
}
