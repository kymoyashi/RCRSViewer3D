import java.lang.Thread;
import java.util.ArrayList;
import rescuecore2.config.Config;


class BlockadeDraw extends Thread{
  private ArrayList<EntityShape> blockadeShapeList;
  private ViewerConfig viewerConfig;
  private PApplet applet;
  private int count,beforecount;
  private int animationRate;
  
  public BlockadeDraw(){
    this.blockadeShapeList = null;
    this.count = 0;
    this.beforecount = 0;
    this.applet = null;
    this.viewerConfig = null;
  }
  
  public void run(){
    while(true){
      try{
        Thread.sleep(1);
        if(beforecount != count)
        try{
          beforecount = count;
          if(this.blockadeShapeList != null && this.blockadeShapeList.size() != 0){
            for(int i = 0; i < blockadeShapeList.size(); i++){
              EntityShape bShape = blockadeShapeList.get(i);
              bShape.drawShape(count, animationRate, applet, viewerConfig);
            }
          }
        }
        catch(NullPointerException npe){
        }
      }
      catch(InterruptedException ie) {
        ie.printStackTrace();
        //System.exit(-1);
      }
    }
  }
  
  public void setBlockadeList(ArrayList<EntityShape> bl)
  {
    
    if(!(bl.isEmpty()) && bl.size() != 0){
      blockadeShapeList = bl;
    }
    
  }
  public void setAnimationConfig(int count, int animationRate, ViewerConfig config, PApplet applet){
    this.count = count;
    this.animationRate = animationRate;
    this.applet = applet;
    this.viewerConfig = config;
  }
}
