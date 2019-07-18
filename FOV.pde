class FOV
{
  /*
  On some levels the tiles get dimmer depending on how far away they are
  Tiles fade according to how long ago they were last seen!!
  
  
  
  
  */
  
  
  Creature creature;
  float radius; 
  float angle;

  FOV(Creature creature_)
  {
    creature = creature_;
    //angle = (7*PI)/8 ;
    angle = PI*.9;
    radius = 20;
  }

  void setRadius(float r)
  {
    radius = r;
  }

  boolean isVisible(Tile tile)
  {
    if (tile!=null)///out of bounds exception
    {
      PVector tileLoc = new PVector(tile.x, tile.y);
      PVector creatureLoc = new PVector(creature.x, creature.y);
      float angleBetween = translateHeading(PVector.sub(tileLoc, creatureLoc).heading() );
      float distance = tileLoc.dist(creatureLoc);
      float start_angle = translateHeading(creature.face-(angle/2));
      float stop_angle =  translateHeading(creature.face+(angle/2));


      if (distance<radius/2)
      {
        if (start_angle<stop_angle)
        {
          if (angleBetween >= start_angle && angleBetween <= stop_angle )
          {
            return true;
          }
        } else
        {
          if (angleBetween >= start_angle && angleBetween >= stop_angle )
          {
            return true;
          }

          if (angleBetween <= start_angle && angleBetween <= stop_angle )
          {
            return true;
          }
        }
      }
    }
    return false;
  }
}
