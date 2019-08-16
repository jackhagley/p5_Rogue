class Thing {
  String label;

  color BASE_COLOUR = color(255, 0, 255);

  Level level;
  Tile tile;

  int x, y;
  ArrayList<Attribute>attributes;
  int base_size;///kind of a hack for now;
  boolean is_known_to_player = false;
  boolean is_lit_by_player = false;
  boolean sprite_rotates = false;
  float face= PI/2;

  float blocks_light = 0;///a hack for now! one day things will have transparency……


  /// this is for shading with colour
  color nc, ec, sc, wc;///directional colour
  float nl, el, sl, wl;///directional level

  String sprite_name = "no_sprite";
  //PShape shape;
  String category = "category not set";


  boolean is_player = false;

  //ArrayList<Tile>knowledge;

  Thing(Level l, Tile t_, String label_)
  {
    this.level = l;
    this.tile = t_;
    setLoc(tile);
    init(label_);
  }


  //Thing(Thing thing)
  //{
  //  this.level = thing.level;
  //  this.tile = thing.tile;
  //  setLoc(tile);
  //  init(thing.label);
  //}

  //Thing(Level l, Tile t_, JSONObject recipe)
  //{
  //  attributes  = new ArrayList<Attribute>();
  //  label = recipe.getString("label");
  //  setSize(recipe);
  //  //setColour(recipe);
  //  setLightBlock(recipe);
  //  setAttributes(recipe);
  //  this.level = l;
  //  this.tile = t_;
  //  setLoc(tile);
  //  level.things.add(this);
  //  tile.things.add(this);
  //}

  Thing()
  {
    ///not needed, but breaks Creature if removed
  }

  Thing(Level l, Tile t_, JSONObject recipe, JSONObject ingredients)
  {

    label = recipe.getString("label");
    setAttributes(recipe, ingredients);
    setSize(recipe);
    setBlocksLight(recipe);
    //setObj(recipe);
    sm.setSprite(this,recipe);
    this.level = l;
    this.tile = t_;
    setLoc(tile);
    level.things.add(this);
    tile.things.add(this);
  }


  void becomeKnown()
  {
  }

  void becomeForgotten()
  {
  }

  void setAttributes(JSONObject item, JSONObject material)
  {
    attributes  = new ArrayList<Attribute>();
    setBaseColour(item);
    setBaseColour(material);

    ////set the attributes of the item according to the kind of item it is
    JSONArray item_array = item.getJSONArray("attributes");
    for (int i = 0; i<item_array.size(); i++)
    {
      String item_label = (String)item_array.get(i);
      Attribute a = new Attribute(this, item_label);
    }

    ////set the attributes of the item according to the material used to make it
    JSONArray material_array = material.getJSONArray("attributes");
    for (int i = 0; i<material_array.size(); i++)
    {
      String material_label = (String)material_array.get(i);
      Attribute a = new Attribute(this, material.getString("label"));
      Attribute b = new Attribute(this, material_label);
    }

    ////set the qualities of the item according to the kind of item and the material used to make it
  }

  void init(String label_)
  {
    this.label = label_;
    level.things.add(this);
    tile.things.add(this);
    attributes  = new ArrayList<Attribute>();
  }


  void setBaseColour(color c)
  {
    BASE_COLOUR = c;
  }

  void setSize(JSONObject recipe)
  {
    base_size = recipe.getInt("size");
  }

  void setBaseColour(JSONObject ingredient)
  {
    if (ingredient!=null &&  ingredient.hasKey("colour_lerp") && ingredient.hasKey("base_colour") )
    {
      BASE_COLOUR = lerpColor( BASE_COLOUR, unhex("FF"+ingredient.getString("base_colour")), ingredient.getFloat("colour_lerp") )  ;
      return;
    }

    if (ingredient!=null && ingredient.hasKey("base_colour"))
    {
      BASE_COLOUR = unhex("FF"+ingredient.getString("base_colour"));
      return;
    }
  }


  void setBlocksLight(JSONObject recipe)
  {
    blocks_light = recipe.getFloat("blocks_light");
  }

  void setObj(JSONObject recipe)
  {
    println("setObj is no longer used");
    //    if (recipe!=null&&recipe.hasKey("obj_name")&&recipe.hasKey("class"))
    //    {
    //      shape = loadShape( "sprites/"+recipe.getString("class")+"/"+recipe.getString("obj_name" ));
    //    }
  }

  void setAttributes(JSONObject recipe)
  {
    JSONArray attributes_recipe = recipe.getJSONArray("attributes");
  }

  ////BASICS////////////////

  //void display(float light_level, boolean visible)
  //{
  //  fill(BASE_COLOUR);
  //  rect(0, 0, tile_size, tile_size);
  //  //sm.printSprite(this);
  //}

  void display()
  {
    pushStyle();

    pushMatrix();




    if (iso)
    {
      rotate(-TAU/8f);
      scale(1, 1.414213562373095);
    }



    noStroke();
    fill(BASE_COLOUR);

    if (ddd)
    {
      if (!sprite_name.equals("no_sprite"))
      {
        //println("sprites motherfuckers, do you have them??");
        //translate(view.ts2(), view.ts2(), view.ts2());
        sm.printSprite(this);
      } else
      {
        translate(view.ts2(), view.ts2(), view.ts2());
        box(view.ts(), view.ts(), view.ts() );
      }

      //if (shape!=null)
      //{
      //  translate(view.ts2(), view.ts2(), 0);
      //  shape.resetMatrix();
      //  shape.rotateX(PI/2);
      //  shape.applyMatrix(view.matrix2);
      //  shape.translate(-view.ts2(), -view.ts2(), -view.ts()*1.2 );
      //  shape(shape);
      //} else
      //{
      //  translate(view.ts2(), view.ts2(), view.ts2());
      //  box(view.ts(), view.ts(), view.ts() );
      //}
    } else


    {
      rect(0, 0, view.ts(), view.ts());
    }


    popStyle();

    popMatrix();

    //sm.printSprite(this);
  }

  //////GETTERS/////////////


  float getSize()
  {
    float output = base_size;

    for (Attribute a : attributes)
    {
      if (a.isActive())
      {
        output*=a.getAFloat("size_mod");
      }
    }
    return output;
  }


  void update()
  {
    for (Attribute a : attributes)
    {
      a.apply();
    }
  }

  ////MOVEMENT//////////////

  void setLoc(Tile t_)
  {
    this.x = t_.x;
    this.y = t_.y;
  }

  void setLoc(int x_, int y_)
  {
    x = x_;
    y = y_;
  }

  void setLoc(float x_, float y_)
  {
    x = int(x_);
    y = int(y_);
  }
  void move(int move_x, int move_y)
  {

    Tile t = level.getTile(move_x+x, move_y+y);

    if (level.check_tile(move_x+x, move_y+y)&&t.is_passable(this) )
    {
      unregister();
      x+=move_x;
      y+=move_y;
      tile = level.getTile(x, y);
      tile.addThing(this);
    }
  }


  void unregister()
  {
    x = tile.x;
    y = tile.y;
    tile.removeThing(this);
    tile = null;
  }

  PVector vectorLoc()
  {
    return new PVector(x, y);
  }
}
