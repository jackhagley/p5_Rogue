class Viewer
{
  PVector loc;//this is the GRID reference!
  float zoom;
  float rot;

  PVector dloc;//this is the GRID reference!
  float dzoom;
  float stored_zoom;

  float drot;
  float z_speed;

  float min_zoom = 1;
  float max_zoom = 3;

  int n_tiles_draw_x;
  int n_tiles_draw_y;

  float speed;

  boolean needs_light_update = true;

  Viewer()
  {
    loc = new PVector(0, 0);
    zoom = 2f;
    rot = 0;

    dloc = new PVector(0, 0);
    dzoom = 2f;
    drot = rot;

    storeZoom();

    //println("ready to update viewer");
    update();
    //println("viewer updated");
    speed = .2;
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
    if (withinZoomBounds(zoom))
    {
      stored_zoom = zoom;
    }
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


  void setTileDrawLimits()
  {
    ///this is kind of fucked
    n_tiles_draw_x = int(width / tile_size / zoom)+100;
    n_tiles_draw_y = int(height / tile_size / zoom )+100;
    needs_light_update = true;
  }

  void update()
  {


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
