import processing.core.PApplet;

import rescuecore2.worldmodel.Entity;

import rescuecore2.misc.gui.ScreenTransform;

interface EntityShape{
  void drawShape(int count, int animationRate, PApplet applet, ViewerConfig config);
  int update(Entity entity, ScreenTransform transform);
  
  int getID();
}
