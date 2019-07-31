class Attribute
{
  ////certain attributes are given to an item because of it’s material
  ////eg wood gets the Burnable, Kill It With Fire attributes 

  ////Lockable is an attribute
  ////Openable is an attribute
  ////UNFORGETTABLE IS AN ATTRIBUTE
  JSONObject props;

  String label;
  String type;
  ////according to type, different attributes are applied at different times

  //int cooldown
  //int duration

  //float size_mod = 1;

  //boolean active = true;

  float test_fail=0;


  Thing thing;

  Attribute(Thing t, String label_)
  {
    this.label = label_;


    
    //println("debug");

    ///gets the properties from the thing directory
    props = thingfactory.getAttribute(label);
    init(t);


    //////copy over all of the properties to the attribute
    //try {
    //  active = props.getBoolean("active");
    //  size_mod = props.getFloat("size_mod");
    //  t.setColour(props);


    //  //test_fail = props.getFloat("test_fail");
    //}
    //catch(Exception e) {
    //  println("Trying to build an attribute property for "+label+" that doesn’t exist");
    //}

    //setActive(props);
    //setSizeMod(props);
    //setColour(props);
  }

  boolean isActive()
  {
    return getABoolean("active");
  }

  boolean getABoolean(String input)
  {
    if (props!=null)
    {

      if (props.hasKey(input))
      {
        return props.getBoolean(input);
      }
      println("Attribute "+input+" not defined for "+label+" in "+thing.label);
    }
    else
    {
      ///props are null
      //println(thing.label+" attribute props are null");
    }
    return false;
  }


  float getAFloat(String input)
  {
    if (props!=null&&props.hasKey(input))
    {
      return props.getFloat(input);
    }
    println("Attribute "+input+" not defined for "+label+" in "+thing.label);
    return -1;
  }

  String getAString(String input)
  {
    if (props!=null&&props.hasKey(input))
    {
      return props.getString(input);
    }
    println("Attribute "+input+" not defined for "+label+" in "+thing.label);
    return "";
  }


  //void setColour(JSONObject props)
  //{
  //  thing.setBaseColour(props);///probably useless but might fuck things up in the future, who fucking knows
  //}


  //void setSizeMod(JSONObject props)
  //{
  //  if (props!=null && props.hasKey("size_mod"))
  //  {
  //    size_mod= props.getFloat("size_mod");
  //  }
  //}




  //void setActive(JSONObject props)
  //{

  //  if (props!=null && props.hasKey("active"))
  //  {
  //    active = props.getBoolean("active");
  //  }
  //}


  //void toggle()
  //{
  //  active=!active;
  //}

  //void activate()
  //{
  //  active = true;
  //}

  //void deactivate()
  //{
  //  active = false;
  //}



  Attribute(Thing t)
  {
    this.thing = t;
    t.attributes.add(this);
  }

  void init(Thing t)
  {
    this.thing = t;
    t.attributes.add(this);
  }

  void apply()
  {
  }
}




class LightSource extends Attribute
{

  color COLOUR = color(255);
  float radius;
  boolean from_player = false;


  LightSource(Thing t)
  {
    super(t);
    from_player  = t.is_player;
  }

  void setColour(color c)
  {
    COLOUR = c;
  }

  void setRadius(float f)
  {
    radius = f;
  }

  void apply()
  {
    game.sc.computeVisibility(thing.x, thing.y, radius, COLOUR, from_player);
  }
}
