class FrameRate {
  
  private long    basetime;
  private int     count;
  private float   framerate;
  
  public FrameRate() {
    basetime = System.currentTimeMillis();
  }

  public float getFrameRate() {
    return framerate;
  }

  public void count() {
    ++count;
    long now = System.currentTimeMillis();
    if (now - basetime >= 1000)
    {
      framerate = (float)(count * 1000) / (float)(now - basetime);
      basetime = now;
      count = 0;
    }
  }
}
