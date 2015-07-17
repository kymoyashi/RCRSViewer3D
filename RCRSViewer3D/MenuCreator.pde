import java.awt.MenuItem;
import java.awt.PopupMenu;
import java.awt.MenuBar;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

class MenuCreator{
  private MenuBar menuBar;
  
  public MenuCreator(String[] menu, ActionListener action)
  {
    menuBar = new MenuBar();
  
    for(int i = 0; i < menu.length; ++i){
      PopupMenu pop = new PopupMenu(menu[i]);
      i++;
      while(i < menu.length && !menu[i].equals("n")){
        if(menu[i].equals("s")){
          pop.addSeparator();
        }else{
          MenuItem item = new MenuItem(menu[i]);
          item.addActionListener(action);
          pop.add(item);
        }
        i++;
      }
      menuBar.add(pop);
    }
  }
  
  public MenuBar getMenu()
  {
    return menuBar;
  }
}
