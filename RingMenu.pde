class RingMenu
{
  /////Theres a game inside the menus
  /////they must be fun to use

  float ring_size = 3; ///multiplies by tile_size
  float display_ring_size;
  float line_thickness = 3f;


  Tile tile;

  RingMenu(Tile t)
  {
    ///loads straight from tile
    this.tile = t;
    game.menu = this;
    display_ring_size = tile_size*ring_size;
  }

  void command()
  {
    if (key == CODED)
    {

      if (keyCode == UP)
      {
        //cursor.move('n');
      }
      if (keyCode == DOWN)
      {
        //cursor.move('s');
      }
      if (keyCode == LEFT)
      {
        //cursor.move('w');
      }
      if (keyCode == RIGHT)
      {
        //cursor.move('e');
      }
    }

    switch(key)
    {
    case ' ':
      cancel();
      break;

    case 'r':

      break;

    case 'a':
      close();
      break;

    case 'd':

      break;

    case 'w':

      break;

    case 's':
      //close();
      break;
    }
  }

  void update()
  {
  }

  void display()
  {

    noFill();
    stroke(255);
    strokeWeight(line_thickness/view.zoom);
    ellipse(0, 0, display_ring_size, display_ring_size);

    pushMatrix();
    rotate(-view.rot-PI/2);
    translate(-tile_size/2,-tile_size/2);

    float angle = TAU/tile.things.size();

    for (int i = 0; i<tile.things.size(); i++)
    {
      //rect(0, 0, 100, 100);


      float x = display_ring_size/2*cos(angle);
      float y = display_ring_size/2*sin(angle);

      pushMatrix();

      translate(x, y);
      //fill(255);
      //noStroke();

      tile.things.get(i).display();

      popMatrix();
    }
    popMatrix();///rotation
  }

  void cancel()
  {
    game.cursorToggle();
    view.loadZoom();
    game.menu = null;
  }

  void close()
  {
    cursor.closeRingMenu();
    view.loadZoom();
    game.menu = null;
  }



  void open()
  {
    //view.storeZoom();
    for (Thing thing : tile.things)
    {
      println(thing.label);
    }
  }

  void run()
  {
    update();
    display();
  }
}
