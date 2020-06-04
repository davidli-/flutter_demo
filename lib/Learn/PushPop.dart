import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => MyPage(title: 'A'),
      '/b': (BuildContext context) => MyPage(title: 'B'),
      '/c': (BuildContext context) => MyPage(title: 'C'),
    },
  ));
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>MyAppState();
}

class MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Opacity(opacity: 0.8,
          child: Text("Flutter~"),
          ),
        ),
        body: Center(
        child: RaisedButton(
          child: Text('Push'), 
          onPressed: () async {
            print('++++push');
            // push时不带参数
            //Navigator.pushNamed(context, '/b', arguments: 'Title:B');
            // push时带参数，返回时带返回值
            Map result = await Navigator.push(
              context, 
              MaterialPageRoute(builder: (BuildContext context){
                return MyPage(title:"D");
              }),
            );
            print("+++++++popedWithValue:${result['title']}");
          }),
        ),
      );
    }
}

class MyPage extends StatefulWidget {
  MyPage({this.title});
  final String title;
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Opacity(opacity: 0.8,
          child: Text("${widget.title}"),
          ),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Back'),
            onPressed: () { 
              print('++++++pop~');
              final dic = {'title':widget.title};
              Navigator.pop(context, dic); //pop使用的泛型，可以返回任意类型的返回值
            }
          )
        ),
      ),
    );
  }
}
