boolean bug =  true;

class Level
{
  int x_size, y_size;
  Tile [][] tiles;
  ArrayList<Tile> visible_tiles;
  ArrayList<Tile> known_tiles;
  ArrayList<Thing> things;
  ArrayList<Creature> creatures;
  ArrayList<Creature> visible_creatures;
  ArrayList<Creature> ready_creatures;


  ArrayList<Tile> stairs_down;
  ArrayList<Tile> stairs_up;

  color BASE_FLOOR;
  color BASE_LINES;

  float ambient_light_level = .5;

  Level(int x_size_, int y_size_)
  {
    this.x_size = x_size_;
    this.y_size = y_size_;

    tiles = new Tile [x_size][y_size];
    stairs_down = new ArrayList<Tile>();
    stairs_up = new ArrayList<Tile>();
    visible_tiles = new ArrayList<Tile>();
    known_tiles = new ArrayList<Tile>();
    things = new ArrayList<Thing>();
    creatures = new ArrayList<Creature>();
    visible_creatures = new ArrayList<Creature>();
    ready_creatures = new ArrayList<Creature>();

    BASE_FLOOR = #21590E;
    BASE_LINES = 255;
  }

  void increaseActionPointsOfKnownTiles(int amount)
  {
    for (Tile tile : known_tiles)
    {
      tile.increaseActionPoints(amount);
    }
  }


  void clearTile(int x, int y)
  {
    Tile t = getTile(x, y);
    t.clearTile();
  }

  void registerCreatures()
  {

    visible_creatures.clear();
    ready_creatures.clear();

    for (Tile tile : visible_tiles)
    {
      tile.unhighlight();
    }

    for (Creature creature : creatures)
    {
      if ( hero.vectorLoc().dist(creature.vectorLoc()) < hero.fov.radius )
      {
        visible_creatures.add(creature);
      }
    }
  }

  void addCreature(Creature c)
  {
    creatures.add(c);
  }


  void sortCreatures()
  {
    Collections.sort(visible_creatures, new CreatureComp());
  }

  class CreatureComp implements Comparator <Creature> {

    int compare(Creature e1, Creature e2)
    {

      if (e1.action_points == e2.action_points)
      {
        return 0;
      } 

      if (e1.action_points < e2.action_points)
      {
        return -1;
      }

      if (e1.action_points > e2.action_points)
      {
        return 1;
      } 

      return int(e2.action_points-e1.action_points);
    }
  }

  void readyCreatureAct()
  {
    if (game.state==STATE.GAME_TURN)
    {
      for (Creature creature : ready_creatures)
      {
        creature.act();
      }
    }
  }

  void update()
  {


    ///separate update and update view so that it saves processing all the light all the time

    boolean finding_next_ready_creature = true;

    while (finding_next_ready_creature)
    {

      for (Creature creature : visible_creatures)
      {
        if (creature.isReady())
        {
          if (creature.is_player)
          { 
            game.state= STATE.HERO_TURN;
            finding_next_ready_creature  = false;
          } else {
            game.state= STATE.GAME_TURN;
            ready_creatures.add(creature);
            finding_next_ready_creature  = false;
          }
        }
      }
      if (ready_creatures.size()==0 && !hero.isReady() )
      {
        int amount_to_minus = visible_creatures.get(0).action_points;
        for (Creature creature : visible_creatures)
        {
          creature.deductActionPoints(amount_to_minus);
        }
      }
    }
  }

  void updateLight()
  {
    for (Tile tile : visible_tiles)
    {
      tile.noLongerSeen();
    }

    visible_tiles.clear();

    for (int x = 0; x < view.n_tiles_draw_x; x++)
    {
      for (int y = 0; y < view.n_tiles_draw_y; y++)
      {
        int x_off = int (view.x()+x- (view.n_tiles_draw_x/2) );
        int y_off = int (view.y()+y- (view.n_tiles_draw_y/2) );
        if (x_off > 0 && x_off < x_size && y_off > 0 && y_off < y_size) 
        { 
          Tile t = tiles[x_off][y_off];      
          visible_tiles.add(t);
        }
      }
    }

    for (Tile t : visible_tiles)
    {
      t.update();//clears the light level
    }

    for (Thing t : things)
    {
      t.update();
    }
  }

  boolean blocksLight(int x, int y)
  {
    Tile t = getTile(x, y);

    if (check_tile(x, y))
    {
      return t.blocksLight();///a hack!
    }
    return false;
  }

  //boolean isWall(int x, int y)
  //{
  //  Tile t = getTile(x, y);

  //  if (check_tile(x, y))
  //  {
  //    return t.hasWall();///a hack!
  //  }
  //  return false;
  //}

  //void setLight(float x, float y, color c, float l)
  //{
  //  Tile t = getTile(x, y);
  //  if (t!=null)
  //  {
  //    t.setLight(amount);
  //  }
  //}

  //void addLight(float x, float y, color c, float l)
  //{
  //  Tile t = getTile(x, y);
  //  if (t!=null)
  //  {
  //    t.addLight(c, l);
  //  }
  //}



  Tile getTile(int x, int y)
  {
    if (is_tile (x, y) ) 
    {
      return tiles[x][y];
    }
    return null;
  }

  Tile getTile(float x_, float y_)
  {
    int x = int(x_);
    int y = int(y_);
    if (is_tile (x, y) ) 
    {
      return tiles[x][y];
    }
    return null;
  }

  boolean check_tile(float x, float y)
  {
    return check_tile(int(x), int(y));
  }

  boolean check_tile(int x, int y)
  {

    Tile tile = getTile(x, y);

    if (tile==null)
    {
      return false;
    }
    return true;
  }

  boolean is_tile(float x_, float y_)
  {
    int x = int(x_);
    int y = int(y_);

    if (x > 0 && x < x_size && y > 0 && y < y_size) 
    {
      Tile tile = getTile(x, y);

      if (tile==null)
      {
        return false;
      }

      return true;
    }
    return false;
  }


  boolean is_tile(int x, int y)
  {
    if (x > 0 && x < x_size && y > 0 && y < y_size) 
    {
      return true;
    }
    return false;
  }



  void display()
  {

    pushMatrix();

    if (!ddd)
    {
      scale(view.zoom, view.zoom);

      if (iso)
      {
        scale(1, 0.707106781186548);
      }

      translate( (centre.x )/view.zoom, (centre.y )/view.zoom);///centred
      rotate(view.rot);
      if (iso)
      {
        rotate(TAU/8f);
      }

      translate(-view.ts2(), -view.ts2() );///centred
      //for (Tile t : known_tiles)
      //{
      //  if (visible_tiles.contains(t))
      //  {
      //    t.knowndisplay();
      //  }
      //}
    }


    for (Tile t : visible_tiles)
    {
      t.display();
    }

    //for (Tile t : visible_tiles)
    //{
    //  if (t.is_known_to_player)
    //  {
    //    t.displayThings();
    //  }
    //}


    popMatrix();

    //mouse.display();
  }
}//class
