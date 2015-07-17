import processing.core.PApplet;
import processing.core.PImage;

import java.util.Iterator;
import java.awt.geom.Rectangle2D;

import rescuecore2.misc.gui.ScreenTransform;
import rescuecore2.worldmodel.Entity;
import rescuecore2.worldmodel.EntityID;
import rescuecore2.standard.entities.Building;
import rescuecore2.standard.entities.StandardEntityConstants.Fieryness;

class BuildingShape extends AreaShape
{ 
  private PImage[] image;
  private PImage[] fireImage;
  private PImage[] smokeImage;
  
  private float bHeight;
  private int scale;
  
  private Fieryness fieryness;
  
  private int fireCount;
  private int smokeCount,smokedelate;
  
  private float x,y;
  
  private int burning;
  private int smoking;

  public BuildingShape(Entity entity, ScreenTransform transform, float bHeight, int scale,PImage[] image, PImage[] fireImage, PImage[] smokeImage, PImage[] icons)
  {
    super(entity,transform,scale,icons, bHeight);
    this.fieryness = Fieryness.UNBURNT;
    
    Building b = (Building)entity;
    
    this.image = image;
    this.fireImage = fireImage;
    this.smokeImage = smokeImage;
    
    this.bHeight = bHeight;
    this.scale = 50;//agent size
    
    this.fieryness = b.getFierynessEnum();
    
    this.x = transform.xToScreen(b.getX());
    this.y = transform.yToScreen(b.getY());
    
    this.fireCount = 0;
    this.smokeCount = 0;
    this.smokedelate = 0;
    this.burning = 0;
    this.smoking = 0;
  }
  public int update(Entity entity, ScreenTransform transform)
  {
    super.update(entity,transform);
    Building b = (Building)entity;
    
    Fieryness f = b.getFierynessEnum();
    
    if(this.fieryness.equals(f)){
      return InformationManager.NO_CHANGE;
    }else{
      this.fieryness = f;
      
      switch(f){
        case BURNING :
          //On fire a bit more.
          return InformationManager.BUILDING_BURNING;
        case BURNT_OUT :
          //Completely burnt out.
          return InformationManager.BUILDING_BURNT_OUT;
        case HEATING :
          //On fire a bit.
          return InformationManager.BUILDING_HEATING;
        case INFERNO :
          //On fire a lot.
          return InformationManager.BUILDING_INFERNO;
        case MINOR_DAMAGE :
          //Extinguished but minor damage.
          return InformationManager.BUILDING_EXTINGUISH;
        case MODERATE_DAMAGE :
          //Extinguished but moderate damage.
          return InformationManager.BUILDING_EXTINGUISH;
        case SEVERE_DAMAGE :
          //Extinguished but major damage.
          return InformationManager.BUILDING_EXTINGUISH;
        case UNBURNT :
          //Not burnt at all.
          break;
        case WATER_DAMAGE :
          //Not burnt at all, but has water damage.
          break;
      }
    }
    return InformationManager.NO_CHANGE;
  }

  public void drawShape(int count, int animationRate, PApplet applet, ViewerConfig config)
  {
    if(!config.getFlag("Building") || nords == null) return;
    
    applet.fill(50);
    applet.stroke(200);
    
    switch(this.fieryness){
      case BURNING :
        //On fire a bit more.
        buildingPre(2,2,count);
        applet.ambient(200,100,0);
        break;
      case BURNT_OUT :
        //Completely burnt out.
        buildingPre(0,2,count);
        applet.ambient(50,50,50);
        break;
      case HEATING :
        //On fire a bit.
        buildingPre(1,1,count);
        applet.ambient(125,125,0);
        break;
      case INFERNO :
        //On fire a lot.
        buildingPre(3,3,count);
        applet.ambient(255,50,0);
        break;
      case MINOR_DAMAGE :
        //Extinguished but minor damage.
        buildingPre(0,0,count);
        applet.ambient(25,100,170);
        break;
      case MODERATE_DAMAGE :
        //Extinguished but moderate damage.
        buildingPre(0,0,count);
        applet.ambient(50,100,170);
        break;
      case SEVERE_DAMAGE :
        //Extinguished but major damage.
        buildingPre(0,0,count);
        applet.ambient(100,100,170);
        break;
      case UNBURNT :
        //Not burnt at all.
        buildingPre(0,0,count);
        applet.ambient(150,150,150);
        break;
      case WATER_DAMAGE :
        //Not burnt at all, but has water damage.
        buildingPre(0,0,count);
        applet.ambient(0,100,255);
        break;
    }
    switch(config.getDetail()){
      case ViewerConfig.HIGH:
        createBuilding(applet,this.image,this.bHeight);
        super.drawShape(count,animationRate,applet,config);
        break;
      case ViewerConfig.LOW :    
        createBuilding(applet,this.image,this.bHeight);
        super.drawShape(count,animationRate,applet,config);
        break;
      default :
        //bottom
        super.drawShape(count,animationRate,applet,config);
        break;
    }
  }
  public void createBuilding(PApplet applet, PImage[] img, float buildHeight) {
    if(super.areaName == super.REFUGE) return;
    
    int floorCount = (int)(buildHeight / this.scale);//
    float buildDivideHeight = buildHeight / floorCount;
    float[] vertexPoint = {0,0,1,1};
    //      vertexPoint{x1,y1,x2,y2}
    
    //build top
    applet.pushStyle();
    applet.pushMatrix();
    applet.translate(0,0,bHeight);
    if(super.areaName == super.REFUGE) fill(255,255,255,255);
    applet.noStroke();
    applet.beginShape();
    for(int i = 0; i < this.nords.length; i+=2){
      applet.vertex(this.nords[i],this.nords[i+1]);
    }
    applet.endShape();
    applet.popMatrix();
    //build side
    applet.pushMatrix();
    for(int cnt = 0; cnt < floorCount; cnt++){
      for(int i = 0; i < this.nords.length-2; i+=2){
        applet.beginShape(QUAD);
        if(!passable[i/2]) {
          applet.texture(img[0]);
        } else {
          if(cnt == 0) applet.texture(img[1]);
          else applet.texture(img[0]);
        }
        
        if(super.areaName == super.REFUGE) fill(255,255,255,250);
        applet.vertex(this.nords[i],this.nords[i+1],buildDivideHeight*cnt,                      vertexPoint[0],vertexPoint[3]);
        applet.vertex(this.nords[i+2],this.nords[i+3],buildDivideHeight*cnt,                    vertexPoint[2],vertexPoint[3]);
        applet.vertex(this.nords[i+2],this.nords[i+3],buildDivideHeight*cnt+buildDivideHeight,  vertexPoint[2],vertexPoint[1]);
        applet.vertex(this.nords[i],this.nords[i+1],buildDivideHeight*cnt+buildDivideHeight,    vertexPoint[0],vertexPoint[1]);
        applet.endShape();
      }
    }
    //
    applet.popMatrix();
    applet.pushMatrix();
    applet.beginShape(QUAD);
    for(int cnt = 0; cnt < floorCount; cnt++) {
      if(!passable[passable.length-1]) {
        applet.texture(img[0]);
      } else {
        if(cnt == 0) applet.texture(img[1]);
        else applet.texture(img[0]);
      }
      if(super.areaName == super.REFUGE) fill(255,255,255,250);
      applet.vertex(this.nords[0],this.nords[1],buildDivideHeight*cnt,                                              0,1);
      applet.vertex(this.nords[nords.length-2],this.nords[nords.length-1],buildDivideHeight*cnt,                    1,1);
      applet.vertex(this.nords[nords.length-2],this.nords[nords.length-1],buildDivideHeight*cnt+buildDivideHeight,  1,0);
      applet.vertex(this.nords[0],this.nords[1],buildDivideHeight*cnt+buildDivideHeight,                            0,0);
    }
    applet.endShape();
    applet.popMatrix();
    applet.popStyle();
  }
  
  private void buildingPre(int firelevel,int smokelevel,int count){
    burning = firelevel;
    smoking = smokelevel;
    if(burning > 0){
      if(count%2 == 0){
        fireCount++;
      }
    }else{
      fireCount = 0;
    }
    if(smoking > 0){
      if(burning == 0){
        if(count%30 == 0){
          smokedelate++;
        }
      }
      if(count%3 == 0){
        smokeCount++;
      }
    }else{
      smokeCount = 0;
    }
  }
  public void drawShape(PApplet applet, ViewerConfig config)
  {
    switch(config.getDetail()){
      case ViewerConfig.HIGH:
        if(smokedelate < 20){
          if(smoking > 0){
            //drawSmoke(x,y,bHeight,smoking,2,this.nords,smokeCount,0,smokeImage,applet);
            drawSmoke(x,y,bHeight,0,4,this.nords,smokeCount,2,smokeImage,applet);
          }
          if(burning > 0){
            if(smoking > 0){
              drawSmoke(x,y,bHeight,smoking,3,this.nords,smokeCount,-100,smokeImage,applet);
            }
          drawFire(x,y,bHeight,burning,this.nords,fireCount,-50,fireImage,applet);
          }
        }
        break;
    default :
        break;
    }
      
  }
  
  public void setBHeight(float height)
  {
    this.bHeight = height;
  }
  
  public float getBHeight() 
  {
    return this.bHeight; 
  }
}
