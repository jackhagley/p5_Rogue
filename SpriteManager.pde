class SpriteManager
{
  /*
 stores different sizes of sprites
   */



  String name_of_folder = "sprites/";
  HashMap<String, PShape> environment_sprites;

  SpriteManager()
  {
    //environment_sprites = loadSprites("environment");
    environment_sprites = new HashMap<String, PShape>();
  }


  void printSprite(Thing thing)
  {
    String sp_label = thing.sprite_name;
    String category = thing.category;


    if (category.equals("environment"))
    {
      //println("environment sprite");
      PShape shape = getSprite(sp_label);
      shape.applyMatrix(view.matrix);
      shape(shape);
    } else
    {
      println( sp_label);
      println( category);
    }
  }

  void setSprite(Thing thing, JSONObject recipe)
  {
    String sp_name = "no_sprite";

    if (recipe!=null&&recipe.hasKey("obj_name")&&recipe.hasKey("category"))
    {
      sp_name = recipe.getString("obj_name");
      String category = recipe.getString("category");
      String lookup = name_of_folder+category+"/"+sp_name;

      if (category.equals("environment"))
      {
        if (!environment_sprites.containsKey(sp_name))
        {
          PShape shape = loadShape(lookup);
          shape.resetMatrix();
          shape.rotateX(PI/2);
          //shape.applyMatrix(view.matrix);
          //shape.scale(64/13f);
          //shape.translate(-view.ts2(), -view.ts2(), -view.ts()*1.2 );

          println(lookup);
          environment_sprites.put(sp_name, shape);
        }
      }

      thing.sprite_name = sp_name;
      thing.category = category;
    }
  }

  HashMap<String, PShape> loadSprites(String sub_folder)
  {
    HashMap<String, PShape> output = new HashMap<String, PShape>();
    java.io.File folder = new java.io.File(dataPath(name_of_folder+sub_folder+"/"));
    String[] filenames = folder.list();
    println("loading "+filenames.length+" sprites");
    for (int i = 0; i < filenames.length; i++) { 
      String filename = filenames[i];
      if (filename.equals(".DS_Store")) {
        i--;
        continue;
      }
      String name = filename.substring(0, filename.length()-4);
      PShape sprite = loadShape(name_of_folder+filename);
      //println(name +" sprite loaded");
      //sprite.resize(64, 64);
      environment_sprites.put(name, sprite);
    }//for loop

    return output;
  }

  PShape getSprite(String n)
  {

    PShape sprite = environment_sprites.get(n);

    if (sprite!=null)
    {
      //println("I got yer sprite riiiight here");
      return sprite;
    }
    println("no sprite :(");
    return null;
  }




  //void printSprite(String n, boolean rotate_with_camera)
  //{

  //  ///rotate with camera is broken
  //  if (rotate_with_camera)
  //  {
  //    pushMatrix();
  //    translate(tile_size / view.zoom /2 , tile_size / view.zoom /2);
  //    fill(200,0,0);
  //    box(0,0,0);
  //    rotate(-view.rot);



  //  }
  //  noStroke();
  //  PImage sprite = sprites.get(n);
  //  image(sprite,0,0);
  //  //float size = tile_size/sprite.width;
  //  //for (int i = 0; i< sprite.pixels.length; i++)
  //  //{
  //  //  fill(sprite.pixels[i]);
  //  //  int x = i % sprite.width;
  //  //  int y = (i-x)/sprite.width;

  //  //  rect(x*size, y*size, size, size);
  //  //}
  //  if (rotate_with_camera)
  //  {
  //    popMatrix();
  //  }
  //}//
}//SpriteManager
