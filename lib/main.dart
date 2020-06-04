import 'package:flutter/material.dart';
import 'Health/Utils/AMap.dart';
import 'Health/Main/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    // 设置高德地图Key
    AMap.setAmapKey();
    
    return MaterialApp(
      title: 'Flutter',
      home: Home(),
    );
  }
}