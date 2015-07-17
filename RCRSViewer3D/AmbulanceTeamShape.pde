import processing.core.PApplet;

import rescuecore2.misc.gui.ScreenTransform;
import rescuecore2.worldmodel.Entity;
import rescuecore2.worldmodel.EntityID;
import rescuecore2.standard.entities.AmbulanceTeam;

class AmbulanceTeamShape extends HumanShape{
  public AmbulanceTeamShape(Entity entity, ScreenTransform transform, int scale, PImage[] images)
  {
    super(entity,transform,scale,images);
  }
  public AmbulanceTeamShape(Entity entity, ScreenTransform transform, int scale, PImage[] images, OBJLoader ambulanceteam)
  {
    super(entity,transform,scale,images,ambulanceteam);
  }
  
  public void drawShape(int count, int animationRate, PApplet applet, ViewerConfig config)
  {
    if(!config.getFlag("AmbulanceTeam")) return;
    
    if(super.action){
      applet.stroke(0,255,0);
      switch(config.getDetail()){
        case ViewerConfig.HIGH :
          //applet.line(moveX,moveY,0,0);
          applet.ambient(100,255,100);
          //super.drawMarker(applet,super.moveX,super.moveY,super.markHeight + 40);applet.pushStyle();
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
          //applet.line(moveX,moveY,0,0);
          break;
        default :
          //applet.line(moveX,moveY,0,0);
          //applet.line(posX,posY,targetX,targetY);
          break;
      }
    }
    
    applet.ambient(255,255,255);
    //applet.stroke(100);
    //super.drawShape(count,animationRate,applet,config);
    super.drawObj(count,animationRate,applet,config);
  }
}
