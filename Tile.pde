

class Tile 
{

  Level parent;
  color LINE;
  color FILL;
  color TINT_COLOUR;
  int x, y;
  ArrayList<Thing>things;
  //ArrayList<Tint>tints;
  boolean is_known_to_player=false;
  boolean is_lit_by_player = false;
  boolean is_highlighted = false;
  boolean can_be_seen = false;

  int action_points_since_seen = 0;

  float light_level=0;


  Tile(Level l, int x_, int y_)
  {
    parent = l;  
    things = new ArrayList<Thing>();
    this.x =x_;
    this.y =y_;
    //COLOUR = color(random(100), random(100), random(100));
    LINE = l.BASE_LINES;
    FILL = l.BASE_FLOOR;
    light_level = l.ambient_light_level;
  }


  void clearTile()
  {
    things.clear();
  }


  void resetSeenCount()
  {
    action_points_since_seen = 0;
  }


  void increaseActionPoints(int amount)
  {
    if (amount>10)
    {
      println(amount);
    }
    action_points_since_seen+=amount;
  }

  //boolean mouseOver()
  //{
  //  if (mouse.x==x && mouse.y==y)
  //  {

  //    highlight();
  //  }


  //  return false;
  //}

  void noLongerSeen()
  {
    can_be_seen = false;
  }

  void canBeSeen()
  {
    can_be_seen = true;
    resetSeenCount();
  }

  boolean isLit()
  {
    return light_level>0;
  }

  void display()
  {

    //if (is_known_to_player)
    //{
    pushMatrix();



    translate((view.x()-x)*view.ts(), (view.y()-y)*view.ts());

    fill(FILL);


    if (can_be_seen)
    {
      pushStyle();
      noStroke();
      rect(0, 0, view.ts(), view.ts());
      fill(FILL);

      for (Thing t : things)
      {
        t.display();
      }
      popStyle();
    }

    if (!can_be_seen && is_known_to_player)
    {
      pushStyle();
      noStroke();
      rect(0, 0, view.ts(), view.ts());
      fill(FILL);

      for (Thing t : things)
      {
        t.display();
      }

      /////MASK
      int amount = int(map(action_points_since_seen, 0, hero.memory_size, 111, 255));
      fill(22, amount);
      rect(0, 0, view.ts(), view.ts());
      popStyle();
    }




    popMatrix();
  }


  void highlight()
  {
    is_highlighted  = true;
  }

  void unhighlight()
  {
    is_highlighted  = false;
  }

  void setColour(color c)
  {
    LINE = c;
  }

  void addLight(int lx, int ly, color c, float l, boolean from_player)
  {
    ///lx and ly are the location of the light
    ///directional light really applies
    ///to Things, not Tiles.


    //float d = dir.heading();
    ///apply the light to the Things in the Tile according to direction

    //float dir = (PVector.sub( new PVector (x, y), new PVector(lx, ly))).heading();

    //if (dir>TWO_PI)
    //{
    //  dir-=TWO_PI;
    //}



    //for (Thing thing : things)
    //{

    //  //thing.display(l, true);
    //  //if (dir>0 && dir<TWO_PI/4)
    //  //{
    //  //  //thing.sc = lerpColor(thing.nc, c, .5);
    //  //  //thing.nc = c;
    //  //  //thing.ec = c;
    //  //  //thing.sc = c;
    //  //  //thing.wc = c;
    //  //  thing.wc = lerpColor(thing.wc, c, .5);
    //  //}

    //  //if (dir>TWO_PI/4 && dir<TWO_PI/2)
    //  //{
    //  //  //thing.sc = lerpColor(thing.nc, c, .5);
    //  //  //thing.nc = c;
    //  //  thing.nc = lerpColor(thing.nc, c, .5);
    //  //  //thing.ec = c;
    //  //  //thing.sc = c;
    //  //  //thing.wc = c;
    //  //}

    //  //if (dir>TWO_PI/2 && dir<TWO_PI/4*3)
    //  //{
    //  //  //thing.sc = lerpColor(thing.nc, c, .5);
    //  //  //thing.nc = c;
    //  //  //thing.ec = c;
    //  //  thing.ec = lerpColor(thing.ec, c, .5);
    //  //  //thing.sc = c;
    //  //  //thing.wc = c;
    //  //}

    //  //if (dir>TWO_PI/4*3 && dir<TWO_PI)
    //  //{
    //  //  //thing.sc = lerpColor(thing.nc, c, .5);
    //  //  //thing.nc = c;
    //  //  //thing.ec = c;
    //  //  //thing.sc = c;
    //  //  thing.sc = lerpColor(thing.sc, c, .5);
    //  //  //thing.wc = c;
    //  //}
    //}

    //if(!from_player)
    //{
    //TINT_COLOUR = lerpColor(FILL, c, l);
    ////map(light_level, 0, 1, 0, 255)
    light_level += l;
    //}
    //light_level = l;
  }
  void becomeKnown()
  {
    if (!parent.known_tiles.contains(this))
    {
      parent.known_tiles.add(this);
    }


    if (!is_known_to_player)
    {
      is_known_to_player = true;

      for (Thing thing : things)
      {
        thing.becomeKnown();
      }
    }
  }

  void becomeForgotten()
  {
    parent.known_tiles.remove(this);


    if (is_known_to_player)
    {
      is_known_to_player = false;

      for (Thing thing : things)
      {
        thing.becomeForgotten();
      }
    }
  }

  boolean is_passable(Thing thing)
  {
    return getTileContentSize()+thing.getSize()<tile_max_capacity;
  }

  boolean hasWall()
  {
    return ( getTileContentSize()>=100);
  }

  boolean blocksLight()
  {
    return ( blocksLightAmount()>=100);
  }

  float blocksLightAmount()
  {
    float tile_blocks = 0;

    for (Thing t : things)
    {
      tile_blocks+=t.blocks_light;
    }
    return tile_blocks ;
  }

  float getTileContentSize()
  {
    float tile_contents = 0;

    for (Thing t : things)
    {
      tile_contents+=t.getSize();
    }
    return tile_contents ;
  }

  void becomeLitByPlayer()
  {
    is_lit_by_player = true;
  }


  void update()
  {
    ///sunlight etc here
    TINT_COLOUR = LINE;
    light_level = 0;

    is_lit_by_player = false;

    //if(mouseOver())
    //{
    // highlight(); 

    //}

    for (Thing t : things)
    {
      t.update();
    }

    if (action_points_since_seen>hero.memory_size)
    {
      becomeForgotten();
    } 
  }

  void addThing(Thing t)
  {
    //int index = 0;
    
    //for (int i=0; i<things.size(); i++)
    //{
    // if(t.base_size<things.get(i).base_size)
    // {
    //   index=i;
    // }
    // else
    // {
    //  break; 
    // }
    //}
    //things.add(index,t);
    
    things.add(t);
  }

  void removeThing(Thing t)
  {
    if (things.contains(t))
    {
      things.remove(t);
    }
  }


  //void displayThings()
  //{
  //  if (is_known_to_player)
  //  {
  //    pushMatrix();
  //    translate((view.x()-x)*tile_size, (view.y()-y)*tile_size);  
  //    if (hero.fov.isVisible(this) )
  //    {
  //      for (Thing thing : things)
  //      {

  //        thing.display();
  //      }
  //    } else
  //    {
  //      for (Thing thing : things)
  //      {

  //        thing.display();
  //      }
  //    }
  //    popMatrix();
  //  }
  //}
}
