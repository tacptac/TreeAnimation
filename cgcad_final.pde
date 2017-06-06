Drawer drawer = new Drawer();
TreeManager tm;
float c_ratio = 1;//枝の間の角度 *= c_ratio
CVertex firstPos = new CVertex(320,400);
CVertex basePos = new CVertex(320,480);
void setup()
{
  size(640,480);
  frameRate(100);
  tm = new TreeManager(new CVertex(width/2,400),1,80);
}
void draw()
{
  background(#d8d0a0);
  tm.update(c_ratio,firstPos);
  tm.draw();
  stroke(153,102,0);
  drawer.drawline(basePos.x,basePos.y,basePos.x,400,9);//最初の枝
  fill(0);
  text(frameRate,20,20);
}

void mousePressed()
{
  tm = new TreeManager(new CVertex(mouseX,400),1,80);//クリックされると再生成
  basePos.x = mouseX;
  firstPos.x = mouseX;
  c_ratio = 1;
}
void keyPressed()
{
  if(key == 'w')
  {
    c_ratio *= 1.1;
  }
  if(key == 's')
  {
    c_ratio *= 0.9;
  }
}