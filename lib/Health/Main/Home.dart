import 'package:flutter/material.dart';
import 'Local.dart';
import 'Global.dart';
import 'News.dart';
import '../Views/Slide.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState(); 
}

class HomeState extends State<Home>{
  
  int _currentIndex = 0;
  var _controller = PageController(initialPage: 0);
  List<Widget> _views = [];

  @override
  void initState(){
    super.initState();
    _views
    ..add(Local())
    ..add(Global())
    ..add(News());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Slide(),
      body: PageView(
        controller: _controller,
        children: _views,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            title: Text('本地'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text('全球'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('新闻'),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          _controller.jumpToPage(index);
          setState((){
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}