import processing.core.PApplet;

import java.util.List;
import java.util.ArrayList;

import rescuecore2.worldmodel.Entity;
import rescuecore2.misc.gui.ScreenTransform;
import rescuecore2.worldmodel.Entity;
import rescuecore2.worldmodel.EntityID;
import rescuecore2.standard.entities.Edge;
import rescuecore2.standard.entities.Area;



abstract class AreaShape implements EntityShape
{
  protected int id;
  
  protected int scale;
  protected float aHeight;
  
  protected float x;
  protected float y;
  
  protected float[] nords;
  protected boolean[] passable;
  
  protected List<EntityID> blockades;
  
  static final int FIRE = 0;
  static final int AMBULANCE = 1;
  static final int POLICE = 2;
  static final int REFUGE = 3;
  static final int GAS = 4;
  static final int HYDRANT = 5;
  
  protected int areaName;
  
  PImage icon;
  
  public AreaShape(Entity entity, ScreenTransform transform, int scale,PImage[] icons, float areaHeight)
  {
    this.id = entity.getID().getValue();
    this.scale = scale;
    this.aHeight = areaHeight;
    
    Area area = (Area)entity;
    
    this.x = transform.xToScreen(area.getX());
    this.y = transform.yToScreen(area.getY());
    
    int size = area.getEdges().size();
    this.nords = new float[size*2];
    this.passable = new boolean[size];
    int i = 0;
    for(Edge edge : area.getEdges()){
      this.passable[i/2] = edge.isPassable();
      nords[i] = transform.xToScreen(edge.getStartX());
      nords[i+1] = transform.yToScreen(edge.getStartY());
      i+=2;
    }
    
    blockades = area.getBlockades();
    
    this.icon = null;
    
    switch (area.getStandardURN()) {
      case REFUGE:
        this.icon = icons[ImageLoader.REFUGE];
        areaName = REFUGE;
        aHeight = 0;
        break;
      case GAS_STATION:
        this.icon = icons[ImageLoader.GAS];
        areaName = GAS;
        break;
      case FIRE_STATION:
        this.icon = icons[ImageLoader.FIRE];
        areaName = FIRE;
        break;
      case AMBULANCE_CENTRE:
        this.icon = icons[ImageLoader.AMBULANCE];
        areaName = AMBULANCE;
        break;
      case POLICE_OFFICE:
        this.icon = icons[ImageLoader.POLICE];
        areaName = POLICE;
        break;
      case HYDRANT:
        this.icon = icons[ImageLoader.HYDRANT];
        areaName = HYDRANT;
        break;
      default:
        break;
    }
  }
  
  public void drawShape(int count, int animationRate, PApplet applet, ViewerConfig config)
  {
    if(nords == null) return;
    //create Road
    if(areaName == REFUGE){
      applet.ambient(125,125,125);
      applet.stroke(100,255,100);
    }
    applet.beginShape();
    for(int i = 0; i < this.nords.length; i+=2){
      applet.vertex(this.nords[i],this.nords[i+1]);
    }
    applet.endShape();
    
    if(config.getFlag("Icon") && icon != null){
      applet.pushStyle();
      applet.ambient(255,255,255);
      applet.noStroke();
      applet.pushMatrix();
      applet.translate(this.x,this.y,(scale/50) + aHeight);
      applet.rotateZ((float)(Math.PI*2-config.getRoll()));
      applet.rotateX((float)(Math.PI*2-config.getYaw()));
      applet.beginShape();
      applet.texture(icon);
      applet.vertex(-50,-50,0,0,0);
      applet.vertex(-50,50,0,0,1);
      applet.vertex(50,50,0,1,1);
      applet.vertex(50,-50,0,1,0);
      applet.endShape();
      applet.popMatrix();
      applet.popStyle();
    }
  }
  
  public int update(Entity entity, ScreenTransform transform)
  {
    Area a = (Area)entity;
    
    blockades = a.getBlockades();
    
    return InformationManager.NO_CHANGE;
  }
  
  public void setBlockade(List<EntityID> blockadelist)
  {
    blockades = blockadelist;
  }
  
  public List<EntityID> getBlockades()
  {
    return blockades;
  }
  
  public int getID()
  {
    return id;
  }
}
