import 'dart:async';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';

class AMap {
  
  static final _controller = StreamController.broadcast(sync: false);
  static get _sink => _controller.sink;
  static get stream => _controller.stream;

  static _close(){
    _controller.close();
  }

  static setAmapKey(){
    AmapCore.init('c9c896d95f855ca996a6b3b74afbbde6');
  }
  
  static fetchLocation() async {

    //获取定位
    Location location = await AmapLocation.fetchLocation(
      needAddress:true,
      mode: LocationAccuracy.Low,
    );
    // print("""
    // ++++++++++++++++++++++++++
    // 信息：$location
    // """);

    _sink.add(location);
  }

  static Future<Location> getLocation() async {

    //获取定位
    Location location = await AmapLocation.fetchLocation(
      needAddress:true,
      mode: LocationAccuracy.Low,
    );
    // print("""
    // ++++++++++++++++++++++++++
    // 信息：$location
    // """);

    _sink.add(location);

    return location;
  }

  //监听位置的变化
  static listenLocationUpdate(){
    
    AmapLocation.listenLocation().listen((Location location) {
      // print("""
      // ++++++++++++++++++++++++++
      // 信息：$location}
      // """);
     });
  }

  //请求授权
  static requireAlwaysAuth(){
    AmapLocation.requireAlwaysAuth();
  }

  static stopLocation() {
    AmapLocation.stopLocation();
  }

  static dispose() {
    _close();
    AmapLocation.dispose();
  }
}