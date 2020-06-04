import 'package:flutter/material.dart';
import '../Utils/FetchCases.dart';
import '../Utils/AMap.dart';
import '../Models/Models.dart';
import '../Views/LocalScrollView.dart';
import '../Views/Components.dart';

class Local extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> LocalState();
}

class LocalState extends State<Local> with AutomaticKeepAliveClientMixin{  
  
  String _localProvinceName;
  String _localCityName;

  @override
  void initState(){
    
    //先监听流
    AMap.stream.listen((location){
      setState(() {
        _localProvinceName = location.province;
        _localCityName = location.city;
      });
    });

    //获取位置，数据返回时会通知上面的监听block
    AMap.fetchLocation();
    // 获取疫情数据
    Fetch.fetchData();
    super.initState();
  }

  @override
  void dispose() {
    AMap.dispose();
    Fetch.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  // 请求数据时显示"正在加载中..
  Widget _onLoadData(){
    return 
    CustomScrollView(
      slivers: <Widget>[
        HealthAppBar(title:'今日'),
        
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
        )
      ],
    );
  }

  // 从json中查询所在城市对应的信息
  City _prepareData(DatasModel model){
    Country china;            //中国
    Province locatedProvince; //省份
    City locatedCity;         //市
    var _areaTree = model.areaTree;
    _areaTree.forEach((element) { //中国的编码==0
      if (element.id == '0') {
        china = element;
      }
    });
    if (_localProvinceName != null && _localCityName != null) {
      china?.children?.forEach((element) {
        if (_localProvinceName.contains(element.name)) {
          locatedProvince = element;
        }
      });
      locatedProvince?.children?.forEach((element) {
        if (_localCityName.contains(element.name)) {
          locatedCity = element;
        }
      });
    }
    return locatedCity;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: Fetch.stream,
      builder: (BuildContext context, AsyncSnapshot<DatasModel> snapshot) {
        if (snapshot.hasData) {
          DatasModel model = snapshot.data;
          int code = model.areaTree.length;
          if (code == 0) {
            return ErrorPage();
          }else{
            return LocalScrollView(
              city: _prepareData(model), 
              dataModel: model,
            );
          }
        } else {
          return _onLoadData(); //进度圈
        }
      }
    );
  }
}
