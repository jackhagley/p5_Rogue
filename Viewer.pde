class Viewer
{
  PVector loc;//this is the GRID reference!
  float zoom;
  float rot;

  PVector dloc;//this is the GRID reference!
  float dzoom;
  float stored_zoom;

  int tile_size  = 64;
  float ts;

  float drot;
  float z_speed;

  float min_zoom = .2;
  float max_zoom = 2;
  float zoom_increment = .1;

  PMatrix3D matrix;
  PMatrix3D matrix2;

  int n_tiles_draw_x;
  int n_tiles_draw_y;

  float speed;

  boolean needs_light_update = true;
  //boolean zoom_changed = true;

  Viewer()
  {
    loc = new PVector(0, 0);
    zoom = 2f;
    rot = 0;

    matrix = new PMatrix3D();
    matrix2 = new PMatrix3D();

    dloc = new PVector(0, 0);
    dzoom = 2f;
    drot = rot;

    storeZoom();

    //println("ready to update viewer");
    update();
    //println("viewer updated");
    speed = .1;
    z_speed = .1;
    //println("viewer ready");
    setTileDrawLimits();
  }

  void setZoom(float amount)
  {
    dzoom = amount;

  }

  void zoomAtMax()
  {
    dzoom=max_zoom;

  }


  float ts()
  {
    return ts;
  }


  float ts2()
  {
    return ts()*.5;
  }

  void rotate(float amount)
  {
    //if(drot+amount>TWO_PI)
    //{
    //  drot=0;
    //}


    drot += amount;
    needs_light_update = true;
  }

  void storeZoom()
  { 
    stored_zoom = zoom;
  }

  void loadZoom()
  {
    dzoom = stored_zoom;

  }


  boolean withinZoomBounds(float amount)
  {
    if (amount < min_zoom)
    {
      return false;
    }

    if (amount > max_zoom)
    {
      return false;
    }

    return true;
  }

  void centreToHero()
  {
    centreView(hero);
  }

  void centreView(Hero p)
  {
    dloc.set(p.x, p.y);
  }

  void setView(float x, float y)
  {
    dloc.set(x, y);
  }

  void startView()
  {
    loc = hero.vectorLoc().copy();
  }


  void zoomIn(float amount)
  {
    if (zoom<max_zoom)
    {
      dzoom+=amount;
      setTileDrawLimits();

    }
  }
  void zoomOut(float amount)
  {
    if (zoom>min_zoom)
    {
      dzoom-=amount;
      setTileDrawLimits();

    }
  }


  void zoomIn()
  {
    zoomIn(zoom_increment);
  }

  void zoomOut()
  {
    zoomOut(zoom_increment);
  }


  void setTileDrawLimits()
  {
    ///this is kind of fucked
    if (game_is_ready)
    {
      n_tiles_draw_x = int(width / view.ts())+10;
      n_tiles_draw_y = int(height / view.ts())+10;
      needs_light_update = true;
    }
  }

  void update()
  {
    ts = tile_size*zoom;

    matrix.reset();
    matrix2.reset();

    ///this should update if the view is rotated, so that the corners are drawn
    loc.lerp(dloc, speed);
    zoom = lerp(zoom, dzoom, z_speed);

    rot = lerp(rot, drot, speed);
    //rot = drot;

    if (game_is_ready && needs_light_update)
    {
      game.updateView();
      needs_light_update = false;
    }

    float zoom_rot = map(zoom, min_zoom-zoom_increment, max_zoom, 0, PI/6);
    float cam_height = map(zoom, min_zoom-zoom_increment, max_zoom, 300, 150);

    float x = 150*sin(rot+zoom_rot);
    float y = 150*cos(rot+zoom_rot);

    if (game_is_ready && ddd)
    {
 
      //pushMatrix();
      //rotateZ(.1);
      perspective();
      //ortho(); 
      camera(x, y, cam_height, 
        0, 0, 0, 
        0, 0, -1);

      //popMatrix();
    }
    matrix.scale(ts());
    matrix2= matrix.get();
    //matrix2.scale(.625);//for 16
    matrix2.scale(.4);//for 25
  }

  float xx()
  {
    return loc.x;
  }

  float yy()
  {
    return loc.y;
  }

  int x()
  {
    return (int) loc.x;
  }

  int y()
  {
    return (int) loc.y;
  }
}
