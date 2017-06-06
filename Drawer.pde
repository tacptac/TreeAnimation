class Drawer
{
  private int E, x, y;
  private int dx, dy;//2点間距離
  private int sx, sy;//増分
  private float ang;
  void drawline(int x0, int y0, int x1, int y1, int size)
  {
    sx = (x1 > x0) ? 1 : -1;
    dx = (x1 > x0) ? x1 - x0 : x0 - x1;
    sy = (y1 > y0) ? 1 : -1;
    dy = (y1 > y0) ? y1 - y0 : y0 - y1;

    x = x0;
    y = y0;

    if (dx >= dy) {//傾きが１よりおおきいかどうか
      E = -dx;
      for (int i = 0; i <= dx; i++) {
        fill(153,102,0);
        noStroke();
        //drawCircle((float)x, (float) y, (int)size);
        ellipse(x,y,size,size);
        //point(x,y);
        x = x+sx;
        E = E + 2 * dy;
        if (E >= 0) {
          y = y + sy;
          E = E + 2 * dx;
        }
      }
    } else {
      E = -dy;
      for (int i = 0; i <= dy; i++) {
        fill(153,102,0);
        noStroke();
        //drawCircle((float)x, (float) y, (int)size);
        ellipse(x,y,size,size);
        y = y + sy;
        E = E + 2 * dx;
        if (E >= 0) {
          x = x + sx;
          E = E + 2 * dy;
        }
      }
    }
  } 

  void drawCircle(float x, float y, int radius)
  {
    ang = 0;
    pushMatrix();
    translate(x, y);
    while (ang <= 2*PI) {
      ang+=0.01;
      //fill(153,102,0);
      stroke(153,102,0);
      point((float)(cos(ang)*radius), (float)(sin(ang)*radius));
    }
    popMatrix();
  }
}