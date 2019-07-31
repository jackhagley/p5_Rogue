  float translateHeading(float f)
  {
    if (f<=0)
    {
      f+=TWO_PI;
    }

    if (f>=TWO_PI)
    {
      f-=TWO_PI;
    }
    return f;
  }



boolean A_in_B_chance(float a, float b)
{
 return (a/b) > random(1); 
  
}


color colorFromString(String input)
{
 return unhex(input); 
  
}
