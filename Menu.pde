class MenuManager {

  HashMap<String, Menu> menus;

  String currentMenu;


  boolean showGrid = false;

  ////Standardised to make it easier
  ////grids
  int n_grid_x=10;
  int n_grid_y=10;

  //border is around everything
  float border_x=50;
  float border_y=50;

  //gutter is between grid squares
  float gutter_x=5;
  float gutter_y=5;



  MenuManager()
  {
    menus = new HashMap<String, Menu>();
  }

  void toggleGrid()
  {
    showGrid =!showGrid;
  }

  void update()
  {
    menus.get(currentMenu).update();
  }

  void buildMenus()
  { 
    //println("Building Menus…");
    ///start menu
    Menu startMenu = newMenuScreen("start");
    startMenu.setGrid(3, 5);

    MenuItem start = new MenuItem (startMenu, "start", 1, 1, 1, 1);
    start.addAction(new unPauseGameAction());

    MenuItem quit = new MenuItem (startMenu, "quit", 1, 3, 1, 1);
    quit.addAction(new quitGameAction());


    ///pause
    Menu pauseMenu = newMenuScreen("pause");
    pauseMenu.setGrid(3, 5);
    MenuItem unpause = new MenuItem(pauseMenu, "unpause", 1, 1, 1, 1);
    unpause.addAction(new unPauseGameAction());

    MenuItem reset = new MenuItem(pauseMenu, "reset", 1, 3, 1, 1);
    reset.addAction(new resetGameAction());



    ///////

    //println("Menus built!");
    currentMenu = "start";
  }

  Menu newMenuScreen(String title)
  {
    Menu newMenu = new Menu(title, this);
    menus.put(title, newMenu);
    return newMenu;
  }


  Menu getCurrentMenu()
  {
    return menus.get(currentMenu);
  }

  void display()
  {
    Menu menu = menus.get(currentMenu);



    menu.display();

    if (showGrid)
    {
      menu.showGrid();
    }
  }

  void closeMenu()
  {
    menus.get(currentMenu).exit();
  }

  void goToMenu(String destination)
  {
    game.state = STATE.MENU;
    currentMenu = destination;
  }

  void run()
  {
    update();
    display();
  }
}

class Menu
{
  String title;
  ArrayList<MenuItem> items;

  color bg = color(255);

  ///GRID
  //number of grid squares
  int n_grid_x;
  int n_grid_y;

  //size of grid squares
  float size_grid_x;
  float size_grid_y;

  //border is around everything
  float border_x;
  float border_y;

  //gutter is between grid squares
  float gutter_x;
  float gutter_y;

  Menu(String title_, MenuManager mm)
  {
    this.title = title_;
    items = new ArrayList<MenuItem>();
    this.border_x = mm.border_x;
    this.border_y = mm.border_y;
    this.gutter_x = mm.gutter_x;
    this.gutter_y = mm.gutter_y;
    this.n_grid_x = mm.n_grid_x;
    this.n_grid_y = mm.n_grid_y;

    updateGridSizes();
  }

  void updateGridSizes()
  {
    size_grid_x = (width-(2*border_x)-((n_grid_x-1)*gutter_x)) /n_grid_x;
    size_grid_y = (height-(2*border_y)-((n_grid_y-1)*gutter_y)) /n_grid_y;
  }

  void addItem(String label, int x, int y, int w, int h)
  {
    MenuItem newItem = new MenuItem(this, label, x, y, w, h);
    items.add(newItem);
  }

  void addItem(MenuItem i)
  {
    items.add(i);
  }

  MenuItem checkClick()
  {
    for (MenuItem mi : items)
    {
      if (mi.mouseOver())
      {
        return mi;
      }
    }

    return null;
  }

  void update()
  {
    for (MenuItem mi : items)
    {
      mi.update();
    }
  }

  void display()
  {
    background(bg);
    for (MenuItem mi : items)
    {
      mi.display();
    }
  }

  void setBorder(float newX, float newY) {
    this.border_x = newX;
    this.border_y = newY;
    updateGridSizes();
  }

  void setGrid(int newX, int newY) {
    this.n_grid_x = newX;
    this.n_grid_y = newY;
    updateGridSizes();
  }

  void setGutter(float newX, float newY) {
    this.gutter_x = newX;
    this.gutter_y = newY;
    updateGridSizes();
  }

  void showGrid()
  {

    strokeWeight(1);
    stroke(#FF0000, 50);
    noFill();

    rect(border_x, border_y, width-(border_x*2), height-(border_y*2) );

    for (int i=0; i<n_grid_x; i++)
    {
      float x = border_x + (i*size_grid_x) + (i * gutter_x);
      for (int j=0; j<n_grid_y; j++)
      {
        float y = border_y + (j*size_grid_y) + (j * gutter_y);

        rect(x, y, size_grid_x, size_grid_y);
      }
    }
  }

  void exit()
  {
  }
}



class MenuItem
{
  String label;
  Menu parent;

  ArrayList<MenuAction> actions;

  ///position
  int x, y;

  ///size (in grid)
  int w, h;

  ///size (for display)
  float xx, yy, ww, hh;

  MenuItem(Menu m_, String label_, int x_, int y_, int w_, int h_)
  {
    parent = m_;
    this.x = x_;
    this.y = y_;
    this.w = w_;
    this.h = h_;
    this.label = label_;
    actions = new ArrayList<MenuAction>();

    xx = parent.border_x+(x*parent.size_grid_x)+(x*parent.gutter_x);
    yy = parent.border_y+(y*parent.size_grid_y)+(y*parent.gutter_y);
    ww = w*parent.size_grid_x+(w*parent.gutter_x)-parent.gutter_x;
    hh = h*parent.size_grid_y+(h*parent.gutter_y)-parent.gutter_y;

    parent.items.add(this);
  }

  void addAction(MenuAction a)
  {
    actions.add(a);
  }

  void click()
  {
    ///do something!
    for (MenuAction a : actions)
    {
      a.act();
    }
  }

  void update()
  {
  }

  boolean mouseOver() {
    if (
      mouseX>= xx
      &&mouseX<= xx+ww
      &&mouseY>= yy
      &&mouseY<= yy+hh)
    {
      return true;
    } else {
      return false;
    }
  }

  void display()
  {

    textAlign(CENTER, CENTER);


    if (!mouseOver())
    {
      strokeWeight(1);
      stroke(menu_unhighlight);
      fill(menu_fill);
      rect(xx, yy, ww, hh);
      fill(menu_unhighlight);
      text(label, xx, yy, ww, hh);
    } else
    {
      //stroke(menu_unhighlight);
      noStroke();
      fill(menu_unhighlight);
      rect(xx, yy, ww, hh);
      fill(menu_fill);
      text(label, xx, yy, ww, hh);
    }
  }
}

class resetGameAction extends MenuAction {
  void act()
  {
    game.reset();
    game.state = STATE.PLAYER_TURN;
  }
}

class quitGameAction extends MenuAction {
  void act()
  {
    exit();
  }
}

class unPauseGameAction extends MenuAction {

  void act()
  {
    println("pause is currently broken as it defaults to player turn");
    game.state = STATE.PLAYER_TURN;
  }
}

class MenuAction {


  void act()
  {
  }
}
