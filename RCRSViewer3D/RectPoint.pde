import processing.core.PApplet;
void RectPoint(int posX, int posY, int targetX, int targetY, PApplet applet){
  int y0 = 0;
  int x0 = 0;
  float x_width = 0, y_height = 0;
  float pointX1, pointX2, pointX3, pointX4;
  float pointY1, pointY2, pointY3, pointY4;
  if((targetY - posY) == 0){
    y0 = 10;
  }
  else if((targetX - posX) == 0){
    x0 = 10;
  }else{
    float hypotenuse = sqrt((targetY - posY) * (targetY - posY) + (targetX - posX) * (targetX - posX));
    x_width = 20 * ((targetY - posY) / hypotenuse);
    y_height = (-1) * (20 * ((targetX - posX) / hypotenuse));
  }
  pointX1 = posX + x0 + x_width;
  pointY1 = posY + y0 + y_height;
  pointX2 = posX - x0 - x_width;
  pointY2 = posY - y0 - y_height;
  pointX3 = targetX - x0 - x_width;
  pointY3 = targetY - y0 - y_height;
  pointX4 = targetX + x0 + x_width;
  pointY4 = targetY + y0 + y_height;
  
  applet.pushMatrix();
  applet.pushStyle();
  applet.noFill();
  applet.translate(0,0,8);
  applet.quad(pointX1, pointY1, pointX2, pointY2, pointX3, pointY3, pointX4, pointY4);
  applet.translate(0,0,0);
  applet.popStyle();
  applet.popMatrix();
}
