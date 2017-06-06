
class Branch
{
  private Drawer drawer= new Drawer();
  public boolean isAnimationEnd = false;//アニメーション終了の有無
  public CVertex endPos = new CVertex(0,0);//枝の終端
  private CVertex beginPos;//枝の始点
  private CVertex nextPos;//drawline(beginPos,nextPos)によって枝は描画される nextPosはendPosになるまでインクメントする
  public boolean isCalled = false;//多重呼び出し防止
  private float height;//枝の高さ
  private float rotate;//枝間の幅
  private float rotate_ratio;//枝間の幅の倍率
  private int size;
  private CVertex offset = new CVertex(0,-3);//アニメーションの速度
  Branch(float _height,float _rotate,int _size)
  {
    //begin = _begin;
    height = _height;
    rotate = _rotate;
    size = _size;
    nextPos = new CVertex(0,0);
  } 
  public void update(float _rotate_ratio,CVertex _begin)
  {
    rotate_ratio = _rotate_ratio;
    beginPos = _begin;
    if(-nextPos.y - 0 >= height)
    {
      isAnimationEnd = true;
    }else{
      nextPos.x = nextPos.x + offset.x;
      nextPos.y = nextPos.y + offset.y;
    }
  }
  public void draw()
  {
    pushMatrix();
    translate(beginPos.x,beginPos.y);
    rotate(rotate*rotate_ratio);
    drawer.drawline(0,0,(int)nextPos.x,(int)nextPos.y,size);
    if(-nextPos.y - 0 >= height)
    {
      endPos = localToScreen(nextPos.x,nextPos.y); 
    }
    popMatrix();
    
  }
  CVertex localToScreen(float x, float y)//参考:http://d.hatena.ne.jp/kougaku-navi/20140716/p1
  {
    PVector in = new PVector(x, y);
    PVector out = new PVector();
    PMatrix2D current_matrix = new PMatrix2D();
    getMatrix(current_matrix);  
    current_matrix.mult(in, out);
    return new CVertex((int)out.x,(int)out.y);
  }
}