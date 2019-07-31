class ThingFactory
{
  JSONObject dir;
  JSONObject mat;
  JSONObject att;


  ThingFactory()
  {
    ////build a JSON directory of the possible things
    println("-building things library");
    dir = buildDirectory("things");

    ////build a JSON of the possible materials 
    println("-building materials library");
    mat = buildDirectory("materials");


    ///build a JSON of possible attributes
    println("-building attributes library");
    att = buildDirectory("attributes");

    ////When a thing is made it can only be made out of certain things
    ////certain attributes are given to an item because of it’s material
    ////eg wood gets the Burnable, Kill It With Fire attributes 

    ///sprites are constructed according to materials and attributes etc
    ///but they come from a basic set
  }

  void makeThing(Level level, Tile tile, String label, String material)
  {
    JSONObject recipe = dir.getJSONObject(label);
    JSONObject ingredients = mat.getJSONObject(material);

    if (recipe!=null && material!=null)
    {
      Thing thing = new Thing(level, tile, recipe, ingredients);

      if (recipe==null)
      {
        println("There is no such item as a "+label);
      }

      if (material==null)
      {
        println("There is no such material as "+label);
      }
    }
  }

  JSONObject buildDirectory(String directory)
  {
    JSONObject output = new JSONObject();

    java.io.File folder = new java.io.File(dataPath(directory+"/"));
    String[] filenames = folder.list();
    // println("loading "+filenames.length+" things");
    for (int i = 0; i < filenames.length; i++)
    { 
      String filename = filenames[i];
      if (filename.equals(".DS_Store"))
      {
        //i--;
        continue;
      } else
      {
        JSONObject thing = loadJSONObject(directory+"/"+filename);
        String label = thing.getString("label");
        if (!output.hasKey(label))
        {
          println("--adding "+label);
          output.put(label, thing);
        } else
        {
          println("--ERROR! duplicate "+label);
        }
      }
    }//for loop 

    //print(output.size());
    return output;
  }


  JSONObject getAttribute(String label)
  {
    return att.getJSONObject(label);
  }


  //void makeThing(Level level, Tile tile, String label)
  //{
  //  JSONObject recipe = dir.getJSONObject(label);

  //  if (recipe!=null)
  //  {
  //    Thing thing = new Thing(level, tile, recipe);
  //  } else  
  //  {
  //    println("There is no such thing as a "+label);
  //  }
  //}
}
