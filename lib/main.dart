import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

// 主界面
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(primaryColor: Colors.blue /*主题色*/),
      home: MainWidget(),
    );
  }
}

// 定义组件
class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainWidgetState();
}

// 定义状态类
class MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
        actions: <Widget>[IconButton(icon:Icon(Icons.list), onPressed: _push)],
      ),
      body: ListView(
          children: <Widget>[
            _imageSection(), //顶部图片
            _titleSection(), //标题
            _buttonSection(),//按钮
            _textSection(),  //文本
          ],
        ),
    );
  }

  // 1.函数->返回顶部图片控件
    Image _imageSection(){
      return Image.asset("/images/4202.png",);
    }

    // 2.函数->返回标题控件
    Widget _titleSection() {
      return Container( // 将Text等需要设置间距的控件放到Container中
        padding: const EdgeInsets.all(32.0),
        color: Colors.blueGrey[100],
        child: Row(
          children: [
            //两个label所在列，因为需要占用row的绝大部分空间，所以使用Expanded控件
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    color: Colors.blueGrey[200],
                    child: Text(
                      'This Text should be bold~',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'This Text should be light',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            //红星图片
            Icon(
              Icons.star,
              color: Colors.red[500],
            ),
            // 数量文本
            Text('100'),
          ],
        ),
      );
    }

    // 3.函数->控件：按钮所在列
    Widget _buildButtonColumn(IconData icon, String text){
      Color color = Theme.of(context).primaryColor;
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: color,),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            color: Colors.blueGrey[300],
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    // 3.1.底部三个按钮控件
    Widget _buttonSection(){
      return Container(
        color: Colors.orange[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Icons.call, 'Call'),
            _buildButtonColumn(Icons.near_me, 'ROUTE'),
            _buildButtonColumn(Icons.share, 'Share'),
          ],
        ),
      );
    }

    // 4.底部文本控件
    Widget _textSection(){
      return Container(
        color: Colors.blue[200],
        padding: const EdgeInsets.all(32.0),
        child: Text(
          '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
          ''',
          softWrap: true,
        ),
      );
    }

    // push到下一页面
    _push(){
      print('++++pushed~');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context){
            return Scaffold(
              appBar: AppBar(
                title: Text('Hello'),
              ),
              body: ListView(),
            );
          },
        ),
      );
  }
}