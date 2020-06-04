import 'package:flutter/material.dart';
import '../Views/WebView.dart';
import '../Utils/FetchNews.dart';
import '../Models/Models.dart';
import '../Views/Components.dart';

class News extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => NewsState();
}

class NewsState extends State<News> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    if (FetchNews.newsArr.length == 0) {
      FetchNews.fetchData();
    }
    super.initState();
  }

  @override
  void dispose() {
    FetchNews.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: FetchNews.stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return _buildContent();
        }else{
          return _buildLoadData();
        }
      }
    );
  }

  // 2.数据列表
  Widget _buildContent(){
    return CustomScrollView(
      slivers: <Widget>[
        // 1.导航栏
        HealthAppBar(title:'实时新闻'),
        
        // 2.数据列表
        SliverFixedExtentList(
          itemExtent: 160.0, //预估行高
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              
              NewsModel model = FetchNews.newsArr[index];

              return Card(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                elevation: 5.0, //z轴
                child: InkWell( //带点击事件的cell
                child: Container(
                  color: Colors.white,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row( // 时间所在行
                          children: <Widget>[
                            Icon(Icons.timeline),
                            Text('${DateTime.fromMillisecondsSinceEpoch(model?.pubDate)}', 
                              style: TextStyle(
                                color: Colors.grey
                              )
                            ),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                        
                        // 内容
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(model?.summary,
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        
                        //来源
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(model?.pubDateStr),
                              Text('来源：${model?.infoSource}'),
                            ],
                          ),
                        ),

                      ],
                    ),
                    )
                  ),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_){
                      return HealthWebView(model?.title , model?.sourceUrl);
                    })
                  );
                },
              ),
              );
            },
          childCount: FetchNews.newsArr.length,
        ),
      ),
      ],
    );
  }

  Widget _buildLoadData(){
    return CustomScrollView(
      slivers: <Widget>[
        // 1.导航栏
        HealthAppBar(title:'实时新闻'),
        SliverToBoxAdapter(
          child:
            Container(
              //color: Colors.orange,
              height: MediaQuery.of(context).size.height - HealthAppBar.kSliverAppBarHeight - kBottomNavigationBarHeight,
              child: Center(child: 
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
          key: Key('local'),
        ),
      ],
    );
  }

}