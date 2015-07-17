import processing.core.PApplet;

import rescuecore2.misc.gui.ScreenTransform;
import rescuecore2.worldmodel.Entity;
import rescuecore2.worldmodel.EntityID;
import rescuecore2.standard.entities.FireBrigade;

class FireBrigadeShape extends HumanShape{
    
  public FireBrigadeShape(Entity entity, ScreenTransform transform, int scale, PImage[] images)
  {
    super(entity,transform,scale,images);
  }
  public FireBrigadeShape(Entity entity, ScreenTransform transform, int scale, PImage[] images, OBJLoader firebrigade)
  {
    super(entity,transform,scale,images,firebrigade);
  }
  
  
  public void drawShape(int count, int animationRate, PApplet applet, ViewerConfig config)
  {
    if(!config.getFlag("FireBrigade")) return;
    
    if(super.action){
      applet.stroke(188,226,255,230);
      switch(config.getDetail()){
        case ViewerConfig.HIGH :
        case ViewerConfig.LOW :
          applet.pushStyle();
          applet.noFill();
          applet.strokeWeight(15);
          applet.bezier(posX,posY,0,
                        targetX-((targetX-posX)/4),targetY-((targetY-posY)/4),targetZ+(targetZ/5),
                        targetX-((targetX-posX)/2),targetY-((targetY-posY)/2),targetZ+(targetZ/10),
                        targetX,targetY,targetZ-(targetZ/10));
          applet.popStyle();
          break;
        default :
          applet.line(posX,posY,targetX,targetY);
          break;
      }
    }
    
    //applet.ambient(255,255,255);
    //applet.ambient(255,100,100);
    //applet.stroke(200);
    //applet.noLights();
    //applet.noStroke();
    applet.ambient(255,255,255);
    //super.drawShape(count,animationRate,applet,config);
    super.drawObj(count,animationRate,applet,config);
  }
}
