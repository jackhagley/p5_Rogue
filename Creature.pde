//class Wanderer extends Creature
//{
//  Wanderer(Level l, Tile t)
//  {
//    super(l, t, "wanderer");
//    BASE_COLOUR = color(200, 0, 200);

//    move_action_points = 100;
//  }

//  void display(float light_level)
//  {
//    fill(BASE_COLOUR, map(light_level, 0, 1, 0, 255));
//    noStroke();
//    ellipse(1+(tile_size/2), 1+(tile_size/2), tile_size-4, tile_size-4);
//  }

//  void act()
//  {

//    //println("wanderer is moving");
//    int direction = int (random(3) );
//    switch(direction)
//    {
//    case 0:
//      super.move(0, 1);
//      break;

//    case 1:
//      super.move(-1, 0);
//      break;

//    case 2:
//      super.move(0, -1);
//      break;

//    case 3:
//      super.move(1, 0);
//      break;
//    }
//  }

//  void update()
//  {
//  }
//}

class Creature extends Thing implements Comparable<Creature>
{
  FOV fov;

  int action_points;
  int move_action_points;
  int turn_action_points;
  float dface = PI/2;
  ArrayList<PVector>path;
  
  
  //Creature()
  //{
  //  super();
  //}
  
  

  Creature(Level l, Tile t, String label)
  {
    super(l, t, label);
    l.addCreature(this);
    fov = new FOV(this);
    path = new ArrayList<PVector>();
  }

  void turn(float amount)
  {
    dface=translateHeading(dface+amount);
    action_points=turn_action_points;
    level.sortCreatures();
  }

  void update()
  {
    super.update();
    face = dface;
    //if (abs(face-dface)>.1)
    //{
    //  face = lerp(face, dface, .5);
      
    //} else
    //{
    //  face = dface;
    //}
  }

  void act()
  {
  }

  void deductActionPoints(int amount_to_minus)
  {
    action_points -=  amount_to_minus;
  }

  //void display()
  //{
  //  stroke(c);

  //  for (int i = 1; i<path.size(); i++)
  //  {
  //    PVector start = path.get(i-1);
  //    PVector stop = path.get(i);

  //    line(start.x*til,start.y,stop.x,stop.y);

  //  }

  //}

  boolean canMove(int x_, int y_)
  {
    if (level.is_tile(x_+x, y_+y) )
    {
      if (level.getTile(x_+x, y_+y).is_passable( (Thing) this ) )
      {
        return true;
      }
    }
    return false;
  }
  
  boolean canMove(PVector input)
  {
   return canMove(int(input.x),int(input.y)); 
    
  }

  void move(int x_, int y_)
  {

    if (canMove(x_, y_))
    {
      //path.add(new PVector(x, y));//broken for now
      super.move(x_, y_);
      action_points=move_action_points;
      level.sortCreatures();
    }
    //    if (x_<0)
    //    {
    //      //facing = 0;
    //    }

    //    if (x_>0)
    //    {
    //      //facing = 2;
    //    }

    //    if (y_<0)
    //    {
    //      //facing = 3;
    //    }

    //    if (y_>0)
    //    {
    //      //facing = 1;
    //    }
  }

  boolean isReady()
  { 
    if (action_points>0)
    {
      action_points--;
    }
    return(action_points<=0);
  }

  int compareTo(Creature c)
  {

    if (action_points == c.action_points)
    {
      return 0;
    } 

    if (action_points > c.action_points)
    {
      return -1;
    }

    if (action_points < c.action_points)
    {
      return 1;
    } 

    return int(action_points - c.action_points);
  }
}
