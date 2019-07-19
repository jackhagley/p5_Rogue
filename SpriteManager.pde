class SpriteManager
{
  /*
  Serves Sprites
  
  Sprites are built from pieces
  Colours are chosen by materials and by lighting
  
  
  
  */
  
  
  
  String name_of_folder = "sprites/";
  HashMap<String, PImage> sprites;

  SpriteManager()
  {
    sprites = new HashMap<String, PImage>();
    loadSprites();
  }

  void loadSprites()
  {
    java.io.File folder = new java.io.File(dataPath("sprites/"));
    String[] filenames = folder.list();
    println("loading "+filenames.length+" sprites");
    for (int i = 0; i < filenames.length; i++) { 
      String filename = filenames[i];
      if (filename.equals(".DS_Store")) {
        i--;
        continue;
      }
      String name = filename.substring(0, filename.length()-4);
      PImage sprite = loadImage(name_of_folder+filename);
      //println(name +" sprite loaded");
       //sprite.resize(64, 64);
      sprites.put(name, sprite);
    }//for loop
  }

  PImage getSprite(String n)
  {

    PImage sprite = sprites.get(n);

    if (sprite!=null)
    {
      //if (sprite.width - tile_size != 0 || sprite.height - tile_size != 0)
      //{
       
      //}
      //println(n);
      return sprite;
    }
    println("no sprite :(");
    return null;
  }

  void printSprite(Thing t)
  {
    
    //float offset = tile_size / 2;
    
    /////rotate with camera is broken
    //if (t.sprite_rotates)
    //{
    //  //pushMatrix();
    //  ////rotate(-view.rot);
    //  //translate(offset, offset ,10);
      
    //  //fill(200, 0, 0);
    // //// rect(0,0,10,10);
    
    //}
    ////noStroke();
    //PImage sprite = sprites.get(t.sprite_name);
    //if(sprite!=null)
    //{
    ////image(sprite, -offset, -offset);
    //image(sprite, 0, 0);
    //}
    
    //  //box(tile_size);

    //if (t.sprite_rotates)
    //{
    //  //popMatrix();
    //}
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
