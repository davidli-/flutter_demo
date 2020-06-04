import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'DataListCell.dart';
import 'Components.dart';
import '../Utils/FetchCases.dart';
import '../Models/Models.dart';

class DataList extends StatefulWidget{

  final List<Province> provinces;
  final List<Country> countries;
  final bool isGlobal;
  final String lastUpdateTime;

  // 构造函数
  DataList(this.isGlobal, this.lastUpdateTime, {this.provinces, this.countries});

  @override
  State<StatefulWidget> createState() => DataListState();
}

class DataListState extends State<DataList> {
  
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    if (Fetch.model == null) {
      Fetch.fetchData();
    }
    super.initState();
  }

  void _onRefresh() async{
    // monitor network fetch
    Fetch.fetchData();
    // if failed,use refreshFailed()
    // _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    _refreshController.loadComplete();
  }

  Widget _buildContent(){
    return CustomScrollView(
          slivers: <Widget>[
          // 1.TableHeader悬停
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: HealthSliverAppBarDelegate(
              minHeight: 40.0, // 最小高度
              maxHeight: 40.0, // 最大高度（与最小高度相等，所以看上去会是一个固定高度，否则会根据滑动出现缩放效果）
              child: Container(
                color: Colors.grey[350],
                child: GlobalListHeader(),
                // margin: EdgeInsets.fromLTRB(12, 0, 10, 0),
                ),
            ),
          ),
          
          // 2.真正的列表
          SliverFixedExtentList(
            itemExtent: 40.0, //预估行高
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell( //带点击事件的cell
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      color: index.isOdd? Colors.white : Colors.grey[200],
                      child: DataListCell(
                        district: (widget.isGlobal ? widget.countries[index]?.name : widget.provinces[index]?.name), 
                        nowConfirmed: (widget.isGlobal ? widget.countries[index]?.today?.confirm : widget.provinces[index]?.today?.confirm),
                        totoalConfrirmed: (widget.isGlobal ? widget.countries[index]?.total?.confirm : widget.provinces[index]?.total?.confirm),
                        death: (widget.isGlobal ? widget.countries[index]?.total?.dead : widget.provinces[index]?.total?.dead),
                        cured: (widget.isGlobal ? widget.countries[index]?.total?.heal : widget.provinces[index]?.total?.heal),
                        )
                      )
                    ),
                  onTap: (){
                  },
                );
              },
              childCount: (widget.isGlobal ? widget.countries?.length : widget.provinces?.length),
            ),
          ),
          
          ListFooter(widget.lastUpdateTime),
        ],
      );
  }

  Widget _buildWithRefresher(Widget child){
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: ClassicHeader(
        refreshStyle: RefreshStyle.Follow,
      ),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus mode){
          Widget body;
          if(mode==LoadStatus.idle){
            body =  Text("pull up to load~");
          }
          else if(mode==LoadStatus.loading){
            body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
          }
          else{
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: child,
    );
  }

  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Fetch.stream,
      initialData: Fetch.model,
      builder: (BuildContext context, AsyncSnapshot<DatasModel> snapshot) {
        if (snapshot.hasData) {
          _refreshController.refreshCompleted();
          DatasModel model = snapshot.data;
          int code = model.areaTree.length;
          if (code == 0) {
            return _buildWithRefresher(NetPlaceHolder(
              PlaceholderType.Placeholder_Error, 
              widget.isGlobal ? 'china1' : 'global1',
              kToolbarHeight, 
              kBottomNavigationBarHeight
            )); //进度圈
          }else{
            _refreshController.refreshCompleted();
            return _buildWithRefresher(_buildContent());
          }
        } else {  
          return _buildWithRefresher(NetPlaceHolder(
            PlaceholderType.Placeholder_loading, 
            widget.isGlobal ? 'china2' : 'global2',
            kToolbarHeight, 
            kBottomNavigationBarHeight
          )); //进度圈
        }
      }
    );
  }
}