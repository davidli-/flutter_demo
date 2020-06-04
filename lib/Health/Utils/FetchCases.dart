import 'dart:math';
import 'dart:async';
import 'package:dio/dio.dart';
import '../Models/Models.dart';

class Fetch {

  static final _controller = StreamController<DatasModel>.broadcast(sync: false);
  static get _sink => _controller.sink;
  static get stream => _controller.stream;
  static DatasModel model;

  static close(){
    _controller.close();
  }

  // 获取数据并通过流广播数据
  static fetchData() async {
    
    Response response = await Dio().get('https://c.m.163.com/ug/api/wuhan/app/data/list-total');
    int code = response.data['code'];
    // 错误码
    if (code != 10000) {
      _sink.add(null);
    }
    model = DatasModel.fromJson(response.data['data']);
    
    _sink.add(model);
  }

  static Future<DatasModel> reqData() async {
    
    Response response = await Dio().get('https://c.m.163.com/ug/api/wuhan/app/data/list-total');
    int code = response.data['code'];
    // 错误码
    if (code != 10000) {
      return null;
    }
    model = DatasModel.fromJson(response.data['data']);

    _sink.add(model);

    return model;
  }

  static List<Province> getChinaData() {
    if (model == null) {
      return null;
    }
    var p = List<Province>();
    model.areaTree.forEach((element) {
      if (element.id == '0' && element.name.contains('中国')) {
        Country c = element;
        c.children.forEach((province) {
          p.add(province);
        });
      }
    });
    return p;
  }

  static List<Country> getGlobalData(){
    if (model == null) {
      return null;
    }
    var countries = List<Country>();
    model.areaTree.forEach((element) {
      if (element.id != '0' && !element.name.contains('中国')) {
        countries.add(element);
      }
    });
    return countries;
  }

  static List<InListDay> getChinaDayList(){
    if (model == null || model.chinaDayList.length == 0) {
      return null;
    }
    var chinaDayList = List<InListDay>();
    var length = model?.chinaDayList?.length;
    var index = min(length, 30);
    
    model?.chinaDayList?.reversed?.take(index)?.forEach((element) {
      chinaDayList.add(element);
    });
    return chinaDayList;
  }
}