import processing.core.PApplet;

import rescuecore2.misc.gui.ScreenTransform;
import rescuecore2.worldmodel.Entity;
import rescuecore2.worldmodel.EntityID;
import rescuecore2.standard.entities.Road;

class RoadShape extends AreaShape
{
  
  PImage image;
  
  public RoadShape(Entity entity, ScreenTransform transform, int scale, PImage image, PImage[] icons)
  {
    super(entity,transform,scale,icons,0);
    this.image = image;
  }
  
  public void drawShape(int count, int animationRate, PApplet applet, ViewerConfig config)
  {
    if(!config.getFlag("Road") || nords == null) return;
    
    applet.ambient(100,100,100);
    applet.stroke(150);
    
    super.drawShape(count,animationRate,applet,config);
  }
}
