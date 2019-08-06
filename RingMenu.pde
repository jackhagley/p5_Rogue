class RingMenu
{
  /////Theres a game inside the menus
  /////they must be fun to use

  float ring_size = 3; ///multiplies by tile_size
  float display_ring_size;
  float line_thickness = 3f;
  
  Thing pointed_at;


  Tile tile;

  RingMenu(Tile t)
  {
    ///loads straight from tile
    this.tile = t;
    game.menu = this;
    display_ring_size = view.ts()*ring_size;
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
    
        if (iso)
    {
      rotate(-TAU/8f);
    }

    
    translate(-view.ts2(), -view.ts2() );

    float angle = TAU/tile.things.size();
    float offset = 0;

    for (int i = tile.things.size(); i>0; i--)
    {
      //rect(0, 0, 100, 100);


      float x = display_ring_size/2*cos(offset+angle*i);
      float y = display_ring_size/2*sin(offset+angle*i);

      pushMatrix();

      translate(x, y);
      //fill(255);
      //noStroke();

      tile.things.get(i-1).display();



      popMatrix();
    }

    noFill();
    stroke(255);
    strokeWeight(line_thickness/view.zoom);


    popMatrix();///rotation

    pushMatrix();
    rotate(-view.rot-PI/2);
    ellipse(display_ring_size/2, 0, view.ts()*1.3, view.ts()*1.3);
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
