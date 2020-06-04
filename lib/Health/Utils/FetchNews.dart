import 'dart:async';
import 'package:dio/dio.dart';
import '../Models/Models.dart';

class FetchNews {
  static final _controller = StreamController<List<NewsModel>>(sync: false);
  static get _sink => _controller.sink;
  static get stream => _controller.stream;
  static List<NewsModel> newsArr = <NewsModel>[];

  static close(){
    _controller.close();
  }

  // 获取数据并通过流广播数据
  static fetchData() async {
    Response response = await Dio().get('http://49.232.173.220:3001/data/getTimelineService');
    List<dynamic> items = response.data;

    items.forEach((element) {
      NewsModel model = NewsModel.fromJson(element);
      if (newsArr.length < 100) {
        newsArr.add(model);
      }
    });
    
    _sink.add(newsArr);
  }

  static Future<List<NewsModel>> reqData() async {
    
    Response response = await Dio().get('http://49.232.173.220:3001/data/getTimelineService');
    List<Map> items = response.data;

    items.forEach((element) {
      NewsModel model = NewsModel.fromJson(element);
      newsArr.add(model);
    });
    
    _sink.add(newsArr);

    return newsArr;
  }
}