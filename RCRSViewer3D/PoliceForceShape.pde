import processing.core.PApplet;

import rescuecore2.misc.gui.ScreenTransform;
import rescuecore2.worldmodel.Entity;
import rescuecore2.worldmodel.EntityID;
import rescuecore2.standard.entities.PoliceForce;

class PoliceForceShape extends HumanShape{
  public PoliceForceShape(Entity entity, ScreenTransform transform, int scale, PImage[] images)
  {
    super(entity,transform,scale,images);
  }
  public PoliceForceShape(Entity entity, ScreenTransform transform, int scale, PImage[] images, OBJLoader policeforce)
  {
    super(entity,transform,scale,images,policeforce);
  }
  
  
  public void drawShape(int count, int animationRate, PApplet applet, ViewerConfig config)
  {
    if(!config.getFlag("PoliceForce")) return;
    
    if(super.action){
      applet.stroke(255,0,0);
      switch(config.getDetail()){
        case ViewerConfig.HIGH :
          RectPoint(super.posX,super.posY,super.targetX,super.targetY,applet);
        case ViewerConfig.LOW :
          applet.pushStyle();
          applet.pushMatrix();
          //applet.stroke(80);
          applet.noStroke();
          applet.ambient(255,255,255);
          applet.translate(moveX,moveY,super.markHeight/2);
          applet.rotateZ((float)(Math.PI*2-config.getRoll()));
          applet.rotateX((float)(Math.PI*2-config.getYaw()));
          applet.beginShape(QUAD);
          applet.texture(super.images[5]);
          applet.vertex(-30,30,0,1);
          applet.vertex(-30,-30,0,0);
          applet.vertex(50,-30,1,0);
          applet.vertex(50,30,1,1);
          applet.endShape();
          applet.popMatrix();
          applet.popStyle();
          RectPoint(super.posX,super.posY,super.targetX,super.targetY,applet);
          break;
        default :
          RectPoint(super.posX,super.posY,super.targetX,super.targetY,applet);
          break;
      }
    }
    
    //applet.ambient(255,255,255);
    //applet.ambient(100,100,255);
    //applet.noStroke();
    applet.ambient(255,255,255);
    //super.drawShape(count,animationRate,applet,config);
    super.drawObj(count,animationRate,applet,config);
  }
}
