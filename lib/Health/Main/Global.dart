import 'package:flutter/material.dart';
import '../Views/DataList.dart';
import '../Utils/FetchCases.dart';

class Global extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> GlobalState();
}

class GlobalState extends State<Global> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  
  TabController _tabController;
  List tabs = ['中国','全球'];
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState(){
    _tabController = TabController(length: tabs.length, vsync: this, initialIndex: 0);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('最新'),
        bottom: TabBar(
            tabs: tabs.map((e) => Tab(text: e)).toList(), 
            controller: _tabController,
        ),
      ),
      body: Container( //使用container只是为了添加背景色
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: TabBarView(
        controller: _tabController, //与顶部TabBar共用一个_tabController
        children: [
          DataList(false, Fetch.model?.lastUpdateTime, provinces: Fetch.getChinaData()),
          DataList(true, Fetch.model?.lastUpdateTime, countries: Fetch.getGlobalData()),
        ],
      ),
      )
    );
  }
}
