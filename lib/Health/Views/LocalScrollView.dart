import 'package:flutter/material.dart';
import 'package:flutter_demo/Health/Views/Components.dart';
import '../Views/DailyTrend.dart';
import '../Views/CityAnalysis.dart';
import '../Models/Models.dart';


class LocalScrollView extends StatefulWidget{
  
  final City city;             //城市
  final DatasModel dataModel;
  
  // 构造器
  LocalScrollView({this.city, this.dataModel});

  @override
  State<StatefulWidget> createState() => LocalScrollViewState();
}

class LocalScrollViewState extends State<LocalScrollView>{

  @override
  void initState(){
    super.initState();
  }

  String _replaceNullArgument(dynamic num){
    return num == null ? '0' : '$num';
  }

  @override
  Widget build(BuildContext context){
    
    var name = ((widget.city?.name?.length == 0 || widget.city?.name == null) ? '未知' : widget.city?.name);

    return CustomScrollView(
      slivers: <Widget>[
        // 1.AppBar导航栏
        HealthAppBar(title:'今日'),
        
        // 2.本地悬停栏
        SliverToBoxAdapter(child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 喇叭
              Icon(Icons.volume_up),
              // 城市名
              (name != '未知') ? //定位成功时返回所在城市
              (Text('$name', style: TextStyle(
                fontSize: 18,
                ),
              )) 
              : // 定位失败则显示进度圈
              Container(
                margin: EdgeInsetsDirectional.only(start:10),
                width: 20,
                height: 10,
                child: LinearProgressIndicator()),
            ],
          ),
        ),
        
        // 3.本地汇总
        SliverFixedExtentList(
          itemExtent: 180.0, //预估行高
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                color: Colors.teal[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 左边第1列
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // 左1列第1行
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // 现有
                            Text('现有', style: TextStyle(
                                fontSize: 16,
                                ),
                            ),
                            // +1 现有
                            Text('+${_replaceNullArgument(widget.city?.today?.storeConfirm)}', 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      
                        // 左1列第2行
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('确诊'),
                            Text('${_replaceNullArgument(widget.city?.today?.confirm)}'),
                          ],
                        ),
                        
                        // 左1列第3行
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('疑似病例'),
                            Text('${_replaceNullArgument(widget.city?.today?.suspect)}'),
                          ],
                        ),
                      ],
                    ),

                    // 右边第2列
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        // 右边第2列第1行
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            // 重症
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // 重症
                                Text('重症', style: TextStyle(
                                  fontSize: 16,
                                ),
                                ),
                              ],
                            ),
                            // 重症
                            Text('${_replaceNullArgument(widget.city?.today?.severe)}', 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      
                      // 右边第2列第2行
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('治愈'),
                          Text('${_replaceNullArgument(widget.city?.today?.heal)}'),
                        ],
                      ),
                      
                      // 右边第2列第3行
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('死亡'),
                          Text('${_replaceNullArgument(widget.city?.today?.dead)}'),
                        ],
                      ),
                      ],
                    )
                  ],
                ),
              ),
            ]
          )
        ),
        
        // 4.中国当天数据Header
        SliverToBoxAdapter(child: 
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.volume_up),
              Text('中国', style: TextStyle(
                fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        
        // 5.中国当天数据
        SliverFixedExtentList(
          itemExtent: 180.0, //预估行高
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                color: Color.fromARGB(255, 247, 192, 66),
                child: DatumLegendWithMeasures.withSampleData(widget.dataModel?.chinaTotal),
              ),
            ]
          )
        ),

        // 6.最近一月Header
        SliverToBoxAdapter(child: 
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.volume_up),
                Text('中国-每日新增确诊趋势图', style: TextStyle(
                  fontSize: 18,
                  ),
                ),
              ],
            ),
        ),

        // 7.中国最近一月数据
        SliverFixedExtentList(
          itemExtent: 280.0, //预估行高
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                color: Color.fromARGB(255, 247, 192, 66),
                child: TimeSeriesBar.withSampleData(widget.dataModel?.chinaDayList)
              ),
            ]
          )
        ),

        // 8.版权
        ListFooter('${widget.dataModel?.lastUpdateTime}'),
      ],
    );
  }
}