import processing.core.PApplet;

import rescuecore2.misc.gui.ScreenTransform;
import rescuecore2.worldmodel.Entity;
import rescuecore2.worldmodel.EntityID;
import rescuecore2.standard.entities.Civilian;

class CivilianShape extends HumanShape{
  private boolean isRoadOrBuild;//Road is true, build is false
  private float red,green,blue;
  public CivilianShape(Entity entity, ScreenTransform transform, int scale)
  {
    super(entity,transform,scale);
  }
  
  public void drawShape(int count, int animationRate, PApplet applet, ViewerConfig config)
  {
    if(!config.getFlag("Civilian")) return;
    
    
    float messageHeight;
    if(this.isRoadOrBuild) messageHeight = scale+50;//Road
    else messageHeight = super.markHeight +50; //Build
    red = super.HP/100;
    green = (super.HP/100)*(2.55);
    blue = super.HP/100;
    
    applet.ambient((int)red,(int)green,(int)blue);
    applet.fill(255);
    applet.stroke(200);
    super.drawShape(count,animationRate,applet,config);
    
    if(config.getFlag("AgentEffect") && sayMessage != null){
      applet.pushStyle();
      applet.ambient(255,240,220);
      applet.stroke(80);
      applet.strokeWeight(3);
      applet.pushMatrix();
      applet.translate(moveX,moveY,messageHeight);
      applet.rotateZ((float)(Math.PI*2-config.getRoll()));
      applet.rotateX((float)(Math.PI*2-config.getYaw()));
      applet.textSize(20);
      applet.textAlign(CENTER,TOP);
      applet.beginShape();
      applet.vertex(-30,30);
      applet.vertex(-30,-30);
      applet.vertex(50,-30);
      applet.vertex(50,30);
      applet.vertex(15,30);
      applet.vertex(0,50);
      applet.vertex(5,30);
      applet.endShape();
      applet.ambient(10,10,10);
      applet.text(sayMessage,10,-10,0);
      applet.popMatrix();
      applet.popStyle();
    }
  }
  
  public int update(Entity entity,ScreenTransform transform)
  {
    return super.update(entity,transform);
  }
  
  public void setPosition(String position)
  {
    if("urn:rescuecore2.standard:entity:road".equals(position)) this.isRoadOrBuild = true;
    else if("urn:rescuecore2.standard:entity:building".equals(position)) this.isRoadOrBuild = false;
    }
}
