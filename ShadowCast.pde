class ShadowCast {

  OctantTransform[] s_octantTransform ;

  ShadowCast()
  {

    s_octantTransform = new OctantTransform[8];
    s_octantTransform[0] = new OctantTransform( 1, 0, 0, 1 ); // 0 E-NE
    s_octantTransform[1] = new OctantTransform( 0, 1, 1, 0 ); // 1 NE-N
    s_octantTransform[2] = new OctantTransform( 0, -1, 1, 0 ); // 2 N-NW
    s_octantTransform[3] = new OctantTransform(-1, 0, 0, 1 ); // 3 NW-W
    s_octantTransform[4] = new OctantTransform(-1, 0, 0, -1 ); // 4 W-SW
    s_octantTransform[5] = new OctantTransform( 0, -1, -1, 0 ); // 5 SW-S
    s_octantTransform[6] = new OctantTransform( 0, 1, -1, 0 ); // 6 S-SE
    s_octantTransform[7] = new OctantTransform( 1, 0, 0, -1 ); // 7 SE-E
  }

  void computeVisibility(FOV fov, int x_, int y_, float viewRadius)
  {

    //game.world.current_level.clearLight();
    for (int txidx = 0; txidx < s_octantTransform.length; txidx++) {
      castLight(fov, x_, y_, viewRadius, 1, 1.0f, 0.0f, s_octantTransform[txidx]);
    }
  }

  void castLight(FOV fov, int xg, int yg, float viewRadius, 
    int startColumn, float leftViewSlope, float rightViewSlope, OctantTransform txfrm) {

    float viewRadiusSq = viewRadius * viewRadius;
    int viewCeiling = (int) ceil(viewRadius);
    boolean prevWasBlocked = false;
    float savedRightSlope = -1;

    int xDim = game.world. x_size;
    int yDim = game.world. y_size;

    for (int currentCol = startColumn; currentCol <= viewCeiling; currentCol++) {
      int xc = currentCol;

      for (int yc = currentCol; yc >= 0; yc--) {

        int gridX = int (xg + xc * txfrm.xx + yc * txfrm.xy);
        int gridY = int (yg + xc * txfrm.yx + yc * txfrm.yy);
        if (gridX < 0 || gridX >= xDim || gridY < 0 || gridY >= yDim) {
          continue;
        }
        float leftBlockSlope = (yc + 0.5f) / (xc - 0.5f);
        float rightBlockSlope = (yc - 0.5f) / (xc + 0.5f);

        if (rightBlockSlope >= leftViewSlope) {

          continue;
        } else if (leftBlockSlope <= rightViewSlope) {

          break;
        }

        float distanceSquared = xc * xc + yc * yc;
        if (distanceSquared <= viewRadiusSq) {

          Tile t = game.world.current_level.getTile(gridX, gridY);

          if (fov.isVisible(t) && t.isLit() )
          {

            if (fov.creature.is_player)
            {
              t.becomeKnown();////broken!
              t.canBeSeen();
            }
          }
        }

        //boolean curBlocked = game.world.current_level.isWall(gridX, gridY);
        boolean curBlocked = game.world.current_level.blocksLight(gridX, gridY);

        if (prevWasBlocked) {
          if (curBlocked) {

            savedRightSlope = rightBlockSlope;
          } else {

            prevWasBlocked = false;
            leftViewSlope = savedRightSlope;
          }
        } else {
          if (curBlocked) {
            if (leftBlockSlope <= leftViewSlope) {
              castLight(fov, xg, yg, viewRadius, currentCol + 1, 
                leftViewSlope, leftBlockSlope, txfrm);
            }
            prevWasBlocked = true;
            savedRightSlope = rightBlockSlope;
          }
        }
      }
      if (prevWasBlocked) {
        break;
      }
    }
  }


  void computeVisibility(int x_, int y_, float viewRadius, color c, boolean from_player)
  {

    //game.world.current_level.setLight(x_, y_, c, 255);
    for (int txidx = 0; txidx < s_octantTransform.length; txidx++) {
      castLight(x_, y_, viewRadius, c, 1, 1.0f, 0.0f, s_octantTransform[txidx], from_player );
    }
  }

  void castLight(int xg, int yg, float viewRadius, color c, 
    int startColumn, float leftViewSlope, float rightViewSlope, OctantTransform txfrm, boolean from_player) {

    float viewRadiusSq = viewRadius * viewRadius;
    int viewCeiling = (int) ceil(viewRadius);
    boolean prevWasBlocked = false;
    float savedRightSlope = -1;

    int xDim = game.world. x_size;
    int yDim = game.world. y_size;

    for (int currentCol = startColumn; currentCol <= viewCeiling; currentCol++) {
      int xc = currentCol;

      for (int yc = currentCol; yc >= 0; yc--) {

        int gridX = int (xg + xc * txfrm.xx + yc * txfrm.xy);
        int gridY = int (yg + xc * txfrm.yx + yc * txfrm.yy);
        if (gridX < 0 || gridX >= xDim || gridY < 0 || gridY >= yDim) {
          continue;
        }
        float leftBlockSlope = (yc + 0.5f) / (xc - 0.5f);
        float rightBlockSlope = (yc - 0.5f) / (xc + 0.5f);

        if (rightBlockSlope >= leftViewSlope) {

          continue;
        } else if (leftBlockSlope <= rightViewSlope) {

          break;
        }

        float distanceSquared = xc * xc + yc * yc;
        if (distanceSquared <= viewRadiusSq) {

          Tile t = game.world.current_level.getTile(gridX, gridY);

          if (t!=null)
          {

            ///add in the vector so that colours can be added in!
            //t.addLight(xg,yg,c, viewRadius/distanceSquared);

            t.addLight(xg, yg, c, viewRadius/distanceSquared, from_player);
          }
          ////game.world.current_level.addLight(gridX, gridY, c, distanceSquared/1000);
          //game.world.current_level.addLight(gridX, gridY, c, viewRadius/distanceSquared);
        }

        //boolean curBlocked = game.world.current_level.isWall(gridX, gridY);
        boolean curBlocked = game.world.current_level.blocksLight(gridX, gridY);

        if (prevWasBlocked) {
          if (curBlocked) {

            savedRightSlope = rightBlockSlope;
          } else {

            prevWasBlocked = false;
            leftViewSlope = savedRightSlope;
          }
        } else {
          if (curBlocked) {
            if (leftBlockSlope <= leftViewSlope) {
              castLight(xg, yg, viewRadius, c, currentCol + 1, 
                leftViewSlope, leftBlockSlope, txfrm, from_player);
            }
            prevWasBlocked = true;
            savedRightSlope = rightBlockSlope;
          }
        }
      }
      if (prevWasBlocked) {
        break;
      }
    }
  }
  class OctantTransform
  {
    int xx;
    int xy; 
    int yx; 
    int yy;
    public OctantTransform(int xx, int xy, int yx, int yy)
    {
      this.xx = xx;
      this.xy = xy;
      this.yx = yx;
      this.yy = yy;
    }
  }///OctantTransform
}//////shadowcast
