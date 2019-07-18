//class Mouse
//{
//  boolean clicked = false;
//  boolean rotating = false;
//  boolean zooming = false;
//  int sensitivity = 30;
//  Tile over_tile;
//  int x, y;

//  PVector rot;

//  float display_tile_size;

//  Mouse()
//  {
//    rot = new PVector(-1, -1);
//    x = 0;
//    y = 0;
//  }

//  void rotate(float amount)
//  {
//    PVector temp_rot = new PVector(rot.x, rot.y);

//    temp_rot.rotate(amount);

//    rot.set( int(temp_rot.x), int(temp_rot.y) );
    
    
//  }

//  int x()
//  {
//    return int( view.xx() - (mouseX-(width/2)) /  display_tile_size   );
//  }

//  int y()
//  {
//    return int( view.yy() - (mouseY-(height/2)) /  display_tile_size  );
//  }

//  void update()
//  {
    
//    display_tile_size = tile_size*view.zoom;

//    x =   int( view.xx() - (mouseX-(width/2)) /  display_tile_size   );
//    y =   int( view.yy() - (mouseY-(height/2)) /  display_tile_size  );
    
    
//    PVector loc = new PVector(x(),y());
//    loc.sub(player.vectorLoc());
    
    
//    loc.rotate(-view.drot);
    
//    loc.add(player.vectorLoc());

//    x = int (mouseX/ (display_tile_size)) ;
//    y = int (mouseY/ (display_tile_size)) ;



//    Tile t = game.world.current_level.getTile(loc.x, loc.y);
//      //Tile t = game.world.current_level.getTile(x, y);

//    if (t!=null)
//    {
//      over_tile = t;
//      t.highlight();
//    }
//  }

//  void display()
//  {
//    textAlign(LEFT);
//    fill(255);
    
//     text("MOUSE: "+x+","+y, 50, 30);
//    if (over_tile!=null)
//    {
//      text("TILE: "+over_tile.x+","+over_tile.y, 50, 50);
//    }
   
//    text("PLAYER: "+player.x+","+player.y, 50, 70);
//    text("VIEW: Z"+view.dloc.x+" R"+view.dloc.y, 50, 90);
    
//    text("ROTATION: "+view.rot,50,110);

//    pushMatrix();

//    float x_off = (width%display_tile_size)*display_tile_size;
//    float y_off = (height%display_tile_size)*display_tile_size;

//    translate(x*display_tile_size  +x_off , y*display_tile_size +y_off);
//    noFill();
//    stroke(255,200);
//    rect(0, 0, display_tile_size, display_tile_size);
//    popMatrix();
//  }
//}



//void mouseDragged()
//{
//  if (game.state == STATE.PLAYER_TURN)
//  {
//    if (mouse.clicked && !mouse.rotating && !mouse.zooming)
//    {
//      //println(pmouseX-mouseX);

//      if (pmouseX-mouseX>mouse.sensitivity)
//      {

//        mouse.rotating = true;
//        mouse.rotate(PI/2);
//        player.turn(-PI/2);
//        view.rotate(PI/2);
//        //println(pmouseX-mouseX);
//      }


//      if (pmouseX-mouseX<-mouse.sensitivity)
//      {

//        mouse.rotating = true;
//        mouse.rotate(-PI/2);
//        player.turn(PI/2);
//        view.rotate(-PI/2);
//        //println(pmouseX-mouseX);
//      }

//      if (pmouseY-mouseY>mouse.sensitivity/2)
//      {

//        mouse.zooming = true;
//        view.zoomIn(.3);
//      }


//      if (pmouseY-mouseY<-mouse.sensitivity/2)
//      {
//        mouse.zooming = true;
//        view.zoomOut(.3);
//      }
//    }
//  }
//}


//void mouseReleased()
//{

//  //////MENU////////
//  if (game.state == STATE.MENU)
//  {
//    Menu menu = game.menuManager.getCurrentMenu();
//    MenuItem mi = menu.checkClick();

//    if (mi!=null)
//    {
//      mi.click();
//    }
//  }
//  //////MENU////////


//  //////PLAY////////
//  if (game.state == STATE.PLAYER_TURN)
//  {
//    mouse.clicked = false;
//    mouse.rotating = false;
//    mouse.zooming = false;
//  }
//  //////PLAY////////
//}

//void mousePressed()
//{

//  //////MENU////////
//  if (game.state == STATE.MENU)
//  {
//  }
//  //////MENU////////


//  //////PLAY////////
//  if (game.state == STATE.PLAYER_TURN)
//  {
//    mouse.clicked = true;
//  }
//  //////PLAY////////
//}
