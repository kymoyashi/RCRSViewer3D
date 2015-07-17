import processing.core.PApplet;

import java.util.Map;
import java.util.HashMap;

import org.jfree.data.general.DefaultPieDataset;

import java.math.BigDecimal;
import java.math.RoundingMode;

class InformationManager extends PApplet {
  public static final int NO_CHANGE = -1;

  public static final int BUILDING_HEATING = 0; 
  public static final int BUILDING_BURNING = 1; 
  public static final int BUILDING_INFERNO = 2;
  public static final int BUILDING_EXTINGUISH = 3;
  public static final int BUILDING_BURNT_OUT = 4;

  public static final int HUMAN_DEAD = 5;

  private double[] score;
  private double[] population;
  private double[] numBurnedBuilding;
  private double[] blockadeCounts;
  
  private int livePopulation = 0;
  private int deadPopulation = 0;
  
  private int heatingBuilding = 0;
  private int burntoutBuilding = 0;
  private int unBurntBuilding = 0;
  
  private int allPopulation = 0;
  private int refugePopulation = 0;
  private int evacuationPopulation = 0;
  
  //private int blockadeCount = 0;

  private int currentTime;
  private int maxTime;
  private int startTime;
  
  private double maxScore = 0;

  CreateLineChart gc = new CreateLineChart(this);
  
  DefaultPieDataset populationData;
  DefaultPieDataset buildingData;
  DefaultPieDataset refugeData;
    
  PImage chartImage;
  

  private Button button;

  public InformationManager()
  {
    button = new Button(0, 0, 225, 30, true);
    populationData = new DefaultPieDataset();      
    buildingData = new DefaultPieDataset();      
    refugeData = new DefaultPieDataset();
  }

  void draw() {
    /*
    textSize(50);
     fill(255,120,0);
     text(width,50,50);
    */
    background(128);
    pushStyle();
    textAlign(CENTER, TOP);
    textSize(10);
    button.draw(this);
    popStyle();

    pushStyle();
    //score darw Graph

    switch(button.getFlag()) {
    case 0 :
      translate(0,40);
      gc.setVMax(score);
      BigDecimal now = new BigDecimal(score[currentTime]);
      BigDecimal max = new BigDecimal(gc.getVMax());
      gc.setLabelName("Time", "Score");
      gc.setTittle("Score  " + String.valueOf(now.setScale(3, RoundingMode.CEILING)) + "/" + max.setScale(3, RoundingMode.CEILING));
      gc.setData(score, currentTime);
      gc.draw(score, currentTime, 400, 200);
      
      translate(0,230);
      gc.setVMax(population);
      gc.setLabelName("Time", "population");
      gc.setTittle("Population  " + String.valueOf((int)population[currentTime - 1]) + "/" + String.valueOf(allPopulation));
      gc.setData(population, currentTime);
      gc.draw(population, currentTime, 400, 200);
      
      translate(0,230);
      gc.setLabelName("Time", "Burned Building");
      gc.setTittle("Burned Building  " + String.valueOf((int)numBurnedBuilding[currentTime - 1]));
      gc.setVMax(numBurnedBuilding);
      gc.setData(numBurnedBuilding, currentTime);
      gc.draw(numBurnedBuilding, currentTime, 400, 200);
      
      translate(0,230);
      gc.setVMax(blockadeCounts);
      gc.setLabelName("Time", "Blockade Count");
      gc.setTittle("Blockade Count  " + String.valueOf((int)blockadeCounts[currentTime - 1]) + "/" + String.valueOf(gc.getVMax()));
      gc.setData(blockadeCounts, currentTime);
      gc.draw(blockadeCounts, currentTime, 400, 200);
      break;
    case 1 :
      translate(0,40);
      refugeData.clear();
      refugeData.setValue("Refuge\n"+ refugePopulation, refugePopulation);
      evacuationPopulation = allPopulation - refugePopulation - deadPopulation;
      refugeData.setValue("Evacuation\n"+ evacuationPopulation, evacuationPopulation);
      refugeData.setValue("Dead\n"+ deadPopulation, deadPopulation);
      image(new createChartImage(refugeData).getPieChartPImage(400, 200, "Refuge"),0,30);
      
      translate(0,230);
      buildingData.clear();
      buildingData.setValue("HeatingBuilding\n"+ heatingBuilding, heatingBuilding);
      buildingData.setValue("BurntOutBuilding\n"+ burntoutBuilding, burntoutBuilding);
      buildingData.setValue("unBurntBuilding\n"+ unBurntBuilding, unBurntBuilding);
      image(new createChartImage(buildingData).getPieChartPImage(400, 200, "BurnedBuilding"),0,30);
      break;
    }
    popStyle();
  }

  void mousePressed() {
    button.push();
  }

  public void init(int maxTime, int startTime, int population)
  {
    this.currentTime = 0;
    this.maxTime = maxTime;
    this.startTime = startTime;

    this.score = new double[maxTime-startTime];
    this.population = new double[maxTime-startTime];
    this.numBurnedBuilding = new double[maxTime-startTime];
    this.blockadeCounts = new double[maxTime-startTime];

    this.score[0] = 0;
    this.population[0] = population;
    this.numBurnedBuilding[0] = 0;
    this.blockadeCounts[0] = 0;
    
    this.livePopulation = 0;
    this.deadPopulation = 0;
    
    this.heatingBuilding = 0;
    this.burntoutBuilding = 0;
    this.unBurntBuilding = 0;

    
    this.allPopulation = population;
    this.refugePopulation = 0;

    for (int i = 1; i < maxTime-startTime; ++i) {
      this.score[i] = -1;
      this.population[i] = -1;
      this.numBurnedBuilding[i] = -1;
      this.blockadeCounts[i] = -1;
    }
  }
  
  public void setBurnedBuilding(int time, int fire_count)
  {
    this.numBurnedBuilding[time] = fire_count;
  }
  
  public void setPopulation(int time, int livePopulation)
  {
    this.population[time] = livePopulation;
  }
  
  public void setBlockadeCount(int time, int blockadeCount)
  {
    this.blockadeCounts[time] = blockadeCount;
  }
  
  public void setPopulationData(int live, int dead)
  {
    this.livePopulation = live;
    this.deadPopulation = dead;
  }
  
  public void setBuildingData(int heating, int burnt_out, int unburnt)
  {
    this.heatingBuilding = heating;
    this.burntoutBuilding = burnt_out;
    this.unBurntBuilding = unburnt;
  }
  
  public void setRefugeData(int refugepopulation)
  {
    this.refugePopulation = refugepopulation;
  }
  

  public void nextTime(int t)
  {
    int time = t - this.startTime;
    if (time <= 0 || time >= maxTime) return;
    
    this.currentTime = time;
    this.population[time] = this.population[time-1];
    this.numBurnedBuilding[time] = this.numBurnedBuilding[time-1];
    this.blockadeCounts[time] = this.blockadeCounts[time-1];
  }

  public void setScore(int t, double score)
  {
    int time = t-this.startTime;
    if (time <= 0 || time >= maxTime) return;

    this.score[time] = score;
  }

  public boolean checkMousePos(int x, int y, int width, int height)
  {
    if ((this.mouseX >= x && x+width >= this.mouseX) && (this.mouseY >= y && y+height >= this.mouseY)) return true;
    return false;
  }

  private class Button {
    private String label1;
    private String label2;
    private int x;
    private int y;
    private int width;
    private int height;

    private boolean on1;
    private boolean on2;

    public Button(int x, int y, int width, int height, boolean b) {
      this.label1 = "LineChart";
      this.label2 = "PieChart";
      this.x = x;
      this.y = y;
      this.width = width;
      this.height = height;

      this.on1 = b;
      this.on2 = false;
    }

    public void draw(PApplet p) {
      int tempH = this.width/3;
      p.pushStyle();
      p.stroke(100);
      p.strokeWeight(5);
      if (on1)p.fill(180); 
      else p.fill(20);
      p.rect(x, y, tempH, this.height);
      if (on1)p.fill(50); 
      else p.fill(200);
      p.text(label1, x+tempH/2, y);
      if (on2)p.fill(180); 
      else p.fill(20);
      p.rect(tempH, y, tempH, this.height);
      if (on2)p.fill(50); 
      else p.fill(200);
      p.text(label2, tempH+tempH/2, y);
      p.popStyle();
    }

    public void push() {
      int tempH = this.width/3;
      if (checkMousePos(this.x, this.y, tempH, this.height) && !on1) {
        on1 = true; 
        on2 = false;
      }
      else if (checkMousePos(tempH, this.y, tempH, this.height) && !on2) {
        on1 = false;
        on2 = true;
      }
    }

    public int getFlag() {
      int result = 0;
      
      if (on2) result = 1;

      return result;
    }
  }
}

class CreateLineChart {

  
  private PApplet applet;
  private Scrollbar bar;
  
  private double[] data;
  private  int time = 0;

  private int vMax = 0;
  private int vMin = 0;

  private int labelSize;
  private int costSize;

  private int xScale;
  private int yScale;

  private int showDisplayData;

  private String xName;
  private String yName;
  private String title;

  public CreateLineChart(PApplet applet) {
    this.applet = applet;
    this.defaultApp();
  }
  public void defaultApp() {
    //this.bar = bar = new Scrollbar(this.applet,width - width / 2.0, height / 12, 200, 10, 10, 50);
    
    this.vMax = 100;
    this.vMin = 0;
    this.labelSize = 13;
    this.costSize = 10;
    this.xScale = 12;
    this.yScale = 10;
    this.showDisplayData = this.xScale;

    this.xName = "xxx";
    this.yName = "yyy";
    this.title = "test";

    this.data = new double[0];
  }
  public void setVMax(double[] data) {
    double max = 0;
    for (int i = 0; i < data.length; i++) {
      if (max < data[i]) {
        max = data[i];
      }
    }
    this.vMax = (int)max;
  }
  public int getVMax() {
    return this.vMax;
  }
  public void setData(double[] data, int time) {
    try {
      int dataSize = 0;
      for (int i = 0; i < data.length; i ++) {
        if (data[i] != -1) {
          dataSize ++;
        }
      }
      this.data = new double[dataSize - 1];
      for (int i = 0; i < this.data.length; i++) {
        this.data[i] = data[i];
      }
      /*
      List<Double> list = new ArrayList();
       for(int i = 0; i < data.length; i++) {
       list.add(data[i]);
       }
       this.data = new double[list.size()];
       for(int i = 0; i < list.size(); i++) {
       this.data[i] = list.get(i);
       }*/
      this.time = time;
    } 
    catch(Exception e) {
      //System.out.println("data is null");
    }
  }
  public void setScale(int x, int y) {
    this.xScale = x;
    this.yScale = y;
  }
  public void setShowDisplayData(int s) {
    this.showDisplayData = s;
  }
  public void setMaxMin(int max, int min) {
    this.vMax = max;
    this.vMin = min;
  }
  public void setLabelSize(int label, int cost) {
    this.labelSize = label;
    this.costSize = cost;
  }
  public void setTittle(String tit) {
    this.title = tit;
  }
  public void setLabelName(String xLabel, String yLabel) {
    this.xName = xLabel;
    this.yName = yLabel;
  }
  
  public void draw(double[] data,int time, int w, int h) {
    
    //bar.update();
    //bar.display();
    
    //setScale((int)bar.getPos(), 10);
    //setShowDisplayData((int)bar.getPos() / 2);
    
    this.setData(data,time);
    //this.xScale = (((int)((this.data.length+1) / 10)) + 1)*10;
    this.xScale = this.data.length;
    setShowDisplayData(this.xScale);
    this.drawScene(w ,h);
    this.drawDataLine(w ,h);
  }

  public void drawDataLine(int w, int h) { 
    int behind = 1;
    applet.strokeWeight(2);
    applet.noFill();
    applet.stroke(0, 0, 255);

    applet.beginShape();
    if (data.length > 0) {
      if(data.length <= 10){
        for (int row = 0; row < data.length; row++) {
          float x = row * (w - w / 4) / 10 + w / 8;
          float y = h - h / 8 - (float)(data[row] - vMin) * (h - h / 4) / (vMax - vMin);
          if (data[row] < vMin) {
            applet.vertex(x, h - h / 8);
          } 
          else if (data[row] > vMax) {
            applet.vertex(x, h / 8);
          } 
          else {
            applet.vertex(x, y);
          }
        }
      }else if (data.length <= showDisplayData) {
        for (int row = 0; row < data.length; row++) {
          float x = row * (w - w / 4) / xScale + w / 8;
          float y = h - h / 8 - (float)(data[row] - vMin) * (h - h / 4) / (vMax - vMin);
          if (data[row] < vMin) {
            applet.vertex(x, h - h / 8);
          } 
          else if (data[row] > vMax) {
            applet.vertex(x, h / 8);
          } 
          else {
            applet.vertex(x, y);
          }
        }
      } 
      else {
        for (int row = showDisplayData; row >= 0; row--) {
          float x = row * (w - w / 4) / xScale + w / 8;
          float y = h - h / 8 - (float)(data[data.length - behind] - vMin) * (h - h / 4) / (vMax - vMin);
          if (data[data.length - behind] < vMin) {
            applet.vertex(x, h - h / 8);
          } 
          else if (data[data.length - behind] > vMax) {
            applet.vertex(x, h / 8);
          } 
          else {
            applet.vertex(x, y);
          }
          behind++;
        }
      }
    }
    applet.endShape();
  }
  public void drawScene(int w, int h) {
    applet.fill(255);
    applet.rectMode(applet.CORNERS);
    applet.noStroke();
    applet.rect(w / 8, h / 8, w - w / 8, h - h / 8);

    drawTittle(w, h);
    drawAxisLabels(w, h);
    drawTimeLabel(this.time, w, h);
    drawYLabel(vMax, vMin, w, h);
  }
  public void drawTittle(int w, int h) {
    applet.fill(0);
    applet.textSize(20);
    applet.textAlign(applet.LEFT);

    applet.text(title, w / 8, h / 9);
  }
  public void drawAxisLabels(int w, int h) {
    applet.fill(0);
    applet.textSize(labelSize);
    applet.textLeading(15);

    applet.textAlign(applet.LEFT);
    applet.text(yName, w - (w / 16) + 20, h / 2);
    applet.textAlign(applet.CENTER);
    applet.text(xName, w / 2, h - (h / 10) + labelSize + 5);
  }
  public void drawTimeLabel(int time, int w, int h) {
    applet.fill(0);
    applet.textSize(costSize);
    applet.textAlign(applet.CENTER);

    applet.stroke(224);
    applet.strokeWeight(1);

    for (int row = 0; row <= 10; row++) {
      float x= row * (w - w / 4) / 10 + w / 8;
      String str = "";
      if (row > 0 && row < 10) {
        applet.line(x, h / 8, x, h - h / 8);
      }
      //str = "";
      if(xScale < 10){
        str = "" + row;
      }
      else{
        str = "" + (((int)(xScale* row/10)) );
      }
      applet.text(str, x, h - h / 8 + costSize * 1);
    }
    /*
    for (int row = 0; row <= xScale; row++) {
      float x = row * (w - w / 4) / xScale + w / 8;
      String str = "";
      if (data.length == 0) {
        str = "" + (time + row);
      }
      else if (data.length <= showDisplayData) {
        str = "" + (time + row - (data.length - 1));
      } 
      else {
        str = "" + (time + row - showDisplayData);
      }
      applet.text(str, x, h - h / 8 + costSize * 1);
    }
    */
  }
  public void drawYLabel(int vMax, int vMin, int w, int h) {
    applet.fill(0);
    applet.textSize(costSize);
    applet.textAlign(applet.RIGHT);

    applet.stroke(0);
    applet.strokeWeight(1);

    for (int row = 0; row <= yScale; row++) {
      float y = (-1) * row * (h - h / 4) / yScale + h - h / 8;
      double g = (double)row / yScale;
      String str = String.format("%.0f", vMin + (vMax-vMin)*g);
      applet.text(str, w / 8 - costSize, y + 2);
      if (row != yScale)applet.line(w / 8, y, w / 7, y);
    }
  }
}

class Scrollbar {
  private PApplet applet;
  float x, y; 
  float sw, sh; 
  float pos; 
  float posMin, posMax;
  boolean rollover;
  boolean locked; 
  float minVal, maxVal; 
  
  Scrollbar(PApplet applet, float xp, float yp, float w, float h, float miv, float mav) {
    this.applet = applet;
    x = xp;
    y = yp;
    sw = w;
    sh = h;
    minVal = miv;
    maxVal = mav;
    pos = x + sw / 2 - sh / 2;
    posMin = x;
    posMax = x + sw - sh;
  }

  void update() {
    if (over() == true) {
      rollover = true;
    } else {
      rollover = false;
    }
    if(applet.mousePressed && rollover) {
      locked = true;
    }else{
      locked = false;
    }    
    if (locked) {
      pos = applet.constrain(applet.mouseX - sh / 2, posMin, posMax);
    }
  }
  
  boolean over() {
    if ((applet.mouseX > x) && (applet.mouseX < x + sw) && (applet.mouseY > y) && (applet.mouseY < y + sh)) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    applet.fill(255);
    applet.stroke(0);

    applet.rectMode(applet.CORNER);
    applet.rect(x, y, sw, sh);
    if (rollover || locked) {
      applet.fill(0);
    } else {
      applet.fill(102);
    }
    applet.rect(pos, y, sh, sh);
  }

  float getPos() {
    float scalar = sw / (sw - sh);
    float ratio = (pos - x) * scalar;
    float offset = minVal + (ratio / sw * (maxVal - minVal));
    return offset;
  }
}




