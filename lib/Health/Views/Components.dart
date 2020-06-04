import 'package:flutter/material.dart';
import 'dart:math';


// 自定义SliverPersistentHeaderDelegate
class HealthSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  
  HealthSliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(HealthSliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}


class GlobalListHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final cellWidth = (MediaQuery.of(context).size.width - 6*5) / 5;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: cellWidth,
          alignment: Alignment.center,
          child: Text('地区'),
          ),
        
        Container(
          width: cellWidth,
          alignment: Alignment.center,
          child: Text('新增确诊', style: TextStyle(
              color: Colors.red
            ),
          ),
        ),
        
        Container(
          width: cellWidth,
          alignment: Alignment.center,
          child: Text('确诊'),),
        
        Container(
          width: cellWidth,
          alignment: Alignment.center,
          child: Text('死亡'),),
        
        Container(
          width: cellWidth,
          alignment: Alignment.center,
          child: Text('治愈'),),
      ],
    );
  }
}


class ListFooter extends StatelessWidget{

final String lastUpdateTime;
  ListFooter(this.lastUpdateTime);

  @override
  Widget build(BuildContext context){
    return SliverToBoxAdapter(child: 
      Container(
        margin: EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.copyright),
            Expanded(child: 
              Text('数据来源：网易 -【截至$lastUpdateTime】', 
                softWrap: false,
                style: TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis
              ),
            ),
          ],
        ),
      ),
    );
  }
}


enum PlaceholderType {
  Placeholder_Error,   // 错误
  Placeholder_loading, // 加载中
}

//请求数据时显示"正在加载中..
class NetPlaceHolder extends StatelessWidget{
  final topHeight, bottomHeight;
  final PlaceholderType type;
  final String adaportKey;

  NetPlaceHolder(this.type, this.adaportKey, this.topHeight, this.bottomHeight);

  Widget build(BuildContext context){
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          key: Key(adaportKey),
          child: Container(
            //color: Colors.orange,
            height: MediaQuery.of(context).size.height - topHeight - bottomHeight,
            child: (type == PlaceholderType.Placeholder_Error) ? 
            // 出错
            Center(
              child: Text('请求数据出错~'),
            ) 
            :
            //正在加载
            Center(child: 
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right:10),
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator()
                  ),
                  Text('正在努力加载数据中...'),
                ]
              ),
            ),
          ),
        ),
    ]
    );
  }
}


// 应用导航栏
class HealthAppBar extends StatefulWidget {
  
  static const kSliverAppBarHeight = 150.0;
  final String title;
  
  // 构造函数
  HealthAppBar({this.title});
  
  @override
  State<StatefulWidget> createState() => HealthAppBarState();
}

class HealthAppBarState extends State<HealthAppBar>{
  Widget build(BuildContext context){
    return SliverAppBar(
      floating: false,
      pinned: false,
      expandedHeight: HealthAppBar.kSliverAppBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        title: Text((widget.title.length == 0 ? '未知' : '${widget.title}'),
          style: TextStyle(
            shadows: [
              Shadow(color: Colors.black, offset: Offset(0, 1), blurRadius: 1)
            ],
          ),
        ),
        background: Image(image: AssetImage('assets/images/4131.jpg'),fit: BoxFit.cover),
      ),
    );
  }
}

// 报错时的视图
class ErrorPage extends StatelessWidget{
  Widget build(BuildContext context){
    return CustomScrollView(
      slivers: <Widget>[
        HealthAppBar(title:'数据出错了~'),
      ],
    );
  }
}