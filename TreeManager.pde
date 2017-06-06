//TreeManagerは分岐点、自分から生えるBranchを管理する
//Branchのアニメーションが終わり次第その終点にTreeManagerを生成して以下ループ
//指定回数ループしたら葉っぱを描画する
class TreeManager
{
  public CVertex position;
  private ArrayList<Branch> list = new ArrayList<Branch>();//自分から生える枝
  private ArrayList<TreeManager> childs = new ArrayList<TreeManager>();//自分の子供(自分より上にあるTreeManager)
  private ArrayList<CVertex> leafPos = new ArrayList<CVertex>();//葉っぱの位置
  private int count;//現在が何ループ目か
  private float height;//枝の長さ
  private int weight;//枝の太さ
  private color col;//葉っぱの色
  private boolean isDrawLeaf = false;//葉っぱを描画するべきか否か(指定ループ目でtrueになる)
  private CVertex leafpos;//葉っぱのポジション
  private float leafsize;//葉っぱの大きさ
  private int BRANCH_NUM = 2;//枝の数
  private int COUNT_NUM = 5;//何回ループするか
  TreeManager(CVertex _pos,int _count,float _height)//分岐点の位置、ループ数、枝の長さ
  {
    position = _pos;
    count = _count;
    height = _height;
    weight = 8;
    col = color(20,random(100,250),20,90);
    
    if(count >= 7)return;
    switch(count){//ループ数に応じて太さを帰る
      case 1:weight = 8;
        break;
      case 2:weight = 6;
        break;
      case 3:weight = 4;
        break;
      case 4:weight = 3;
        break;
      case 5:weight = 2;
        break;
      case 6:weight = 1;
        break;
       default:
         weight = 1;
    }
    for(int i = 0;i < BRANCH_NUM;i++)
    {
      float rotate;
      if(i  == 0)rotate = random(-10,55);
      else rotate = random(-55,10);
      list.add(new Branch(height,radians(rotate),weight));
    } 
  }
  public void update(float _rotate_ratio,CVertex _begin)
  {
    position = _begin;
    
    for(int i = 0;i < list.size();i++)
    {
      list.get(i).update(_rotate_ratio,_begin);
      if(list.get(i).isAnimationEnd == true)//枝のアニメーションが終わってるかどうか
      {
        if(list.get(i).isCalled == false)//多重呼び出し防止
        {
           if(count <= COUNT_NUM)//ループ数が規定回数か否か
          {
            childs.add(new TreeManager(list.get(i).endPos,count+1,height*0.87));
          }
          else{
            childs.add(new TreeManager(list.get(i).endPos,count+1,height*0.87));
            isDrawLeaf = true;
            leafpos = list.get(i).endPos;
            leafsize = random(20,60);
            leafPos.add(leafpos);
          }
          list.get(i).isCalled = true;
        }
        childs.get(i).update(_rotate_ratio,list.get(i).endPos);
      }
    }
  }
  private void drawLeaf(CVertex pos)
  {
    fill(col);
    noStroke();
    ellipse(pos.x,pos.y,leafsize,leafsize);
  }
  public void draw()
  {
    stroke(153,102,0);
    for(int i = 0;i < list.size();i++)
    {
      list.get(i).draw();//枝を描画
    } 
    for(int i = 0;i < childs.size();i++)
    {
      if(count <= COUNT_NUM)childs.get(i).draw();//子供のTreeManagerを描画
    }
    if(isDrawLeaf){
      for(int i = 0;i < leafPos.size();i++)
      {
        drawLeaf(childs.get(i).position);//葉っぱを描画
      }
    }
  } 
}