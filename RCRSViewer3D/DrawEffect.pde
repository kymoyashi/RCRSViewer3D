import processing.core.PApplet;
import processing.core.PImage;

void drawFire(float x, float y, float bHeight, int size, float[] nords, int fireCount, int fireInterval, PImage[] fireImage, PApplet applet){      

  //side
  float valueNX,valueNX2;
  float valueNY,valueNY2;//change coordinate 
  int picNum;
  int count = (int)fireCount/2;
  picNum = selectFirePic(count);
  applet.ambient(255,255,255);
  applet.pushMatrix();
  applet.textureMode(NORMAL);
  applet.beginShape(QUADS);
  applet.noStroke();
  for(int i = 0; i < nords.length-2; i+=2){
    valueNX = onNords(nords[i], x, fireInterval);
    valueNY = onNords(nords[i+1], y, fireInterval);
    valueNX2 = onNords(nords[i+2], x, fireInterval);
    valueNY2 = onNords(nords[i+3], y, fireInterval);
    applet.beginShape(QUAD);
    applet.texture(fireImage[picNum]);
    applet.vertex(nords[i],nords[i+1],bHeight / (size+1),0.3,0.7);
    applet.vertex(nords[i+2],nords[i+3],bHeight / (size+1),0.7,0.7);
    applet.vertex(nords[i+2] + valueNX2,nords[i+3] + valueNY2,bHeight + 60*((size+2)/2),0.7,0.2);
    applet.vertex(nords[i] + valueNX,nords[i+1] + valueNY,bHeight + 60*((size+2)/2),0.3,0.2);
    applet.endShape();
  }
  valueNX = onNords(nords[0], x, fireInterval);
  valueNY = onNords(nords[1], y, fireInterval);
  valueNX2 = onNords(nords[nords.length-2], x, fireInterval);
  valueNY2 = onNords(nords[nords.length-1], y, fireInterval);
  applet.beginShape(QUAD);
  applet.texture(fireImage[picNum]);
  applet.vertex(nords[0],nords[1],bHeight / (size+1),0.3,0.7);
  applet.vertex(nords[nords.length-2],nords[nords.length-1],bHeight / (size+1),0.7,0.7);
  applet.vertex(nords[nords.length-2] + valueNX2,nords[nords.length-1] + valueNY2,bHeight + 60*((size+2)/2),0.7,0.2);
  applet.vertex(nords[0] + valueNX,nords[1] + valueNY,bHeight + 60*((size+2)/2),0.3,0.2);
  applet.endShape();
  applet.popMatrix();
}

void drawSmoke(float x, float y, float bHeight,int start_point, int size, float[] nords, int smokeCount, int smokeInterval, PImage[] smokeImage, PApplet applet){      

  //side
  float valueNX,valueNX2;
  float valueNY,valueNY2;
  int picNum;
  int count = (int)smokeCount/2;
  picNum = selectSmokePic(count);
  applet.ambient(255,255,255);
  applet.pushMatrix();
  applet.textureMode(NORMAL);
  applet.beginShape(QUADS);
  applet.noStroke();
  for(int i = 0; i < nords.length-2; i+=2){
    valueNX = onNords(nords[i], x, smokeInterval);
    valueNY = onNords(nords[i+1], y, smokeInterval);
    valueNX2 = onNords(nords[i+2], x, smokeInterval);
    valueNY2 = onNords(nords[i+3], y, smokeInterval);
    applet.beginShape(QUAD);
    applet.texture(smokeImage[picNum]);
    applet.vertex(nords[i],nords[i+1],bHeight / (start_point+1),0.2,0.8);
    applet.vertex(nords[i+2],nords[i+3],bHeight / (start_point+1),0.8,0.8);
    applet.vertex(nords[i+2] + valueNX2,nords[i+3] + valueNY2,bHeight + 60*((size+1)/2),0.8,0);
    applet.vertex(nords[i] + valueNX,nords[i+1] + valueNY,bHeight + 60*((size+1)/2),0.2,0);
    applet.endShape();
    applet.beginShape(QUAD);
  }
  valueNX = onNords(nords[0], x, smokeInterval);
  valueNY = onNords(nords[1], y, smokeInterval);
  valueNX2 = onNords(nords[nords.length-2], x, smokeInterval);
  valueNY2 = onNords(nords[nords.length-1], y, smokeInterval);
  applet.beginShape(QUAD);
  applet.texture(smokeImage[picNum]);
  applet.vertex(nords[0],nords[1],bHeight / (start_point+1),0.2,0.8);
  applet.vertex(nords[nords.length-2],nords[nords.length-1],bHeight / (start_point+1),0.8,0.8);
  applet.vertex(nords[nords.length-2] + valueNX2,nords[nords.length-1] + valueNY2,bHeight + 60*((size+1)/2),0.8,0);
  applet.vertex(nords[0] + valueNX,nords[1] + valueNY,bHeight + 60*((size+1)/2),0.2,0);
  applet.endShape();
  applet.popMatrix();
}

int selectFirePic(int num){
  if(num < 10){
    return num;
  }
  else{
    int i = 0;
    i = (num - 10) % 20;
    i = i + 10;
    return i;
  }
}

int selectSmokePic(int num){
  if(num < 15){
    return num;
  }
  else{
    int i = 0;
    i = (num - 15) % 15;
    i = i + 15;
    return i;
  }
}

float onNords(float buildingPoint, float nordsPoint, int distance){
  float dis;
  if(buildingPoint > nordsPoint){
    dis = (buildingPoint - nordsPoint)/distance;
    return -dis;
  }else if(buildingPoint < nordsPoint){
    dis = (nordsPoint - buildingPoint)/distance;
    return dis;
  }else{
    return 0;
  }
}

public void drawText(float x,float y,float z,String str,ViewerConfig config,PApplet applet){
  applet.pushStyle();
  applet.ambient(255,240,220);
  applet.stroke(80);
  applet.strokeWeight(3);
  applet.pushMatrix();
  applet.translate(x,y,z);
  applet.rotateZ((float)(Math.PI*2-config.getRoll()));
  applet.rotateX((float)(Math.PI*2-config.getYaw()));
  applet.textSize(20);
  applet.textAlign(applet.CENTER,applet.TOP);
  applet.beginShape();
  applet.vertex(-30,30);
  applet.vertex(-30,-30);
  applet.vertex(50,-30);
  applet.vertex(50,30);
  applet.endShape();
  applet.ambient(10,10,10);
  applet.text(str,10,-10,0);
  applet.popMatrix();
  applet.popStyle();
}
