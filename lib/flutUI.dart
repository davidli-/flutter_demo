import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

// 主界面
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 1.顶部图片控件
    Image _imageSection(){
      return Image.asset("/images/4202.png",);
    }

    // 2.标题控件
    Widget _titleSection() {
      return Container(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            //两个label所在列，因为需要占用row的绝大部分空间，所以使用Expanded控件
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
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
            Text('50'),
          ],
        ),
      );
    }

    // 3.控件：按钮所在列
    Widget _buildButtonColumn(IconData icon, String text){
      Color color = Theme.of(context).primaryColor;
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: color,),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
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
        padding: const EdgeInsets.all(32.0),
        child: Text(
          '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
          ''',
          softWrap: true,
        ),
      );
    }

    // 返回控件与布局
    return new MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(primaryColor: Colors.blue //主题色
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Demo"),
          ),
          body: ListView(
            children: <Widget>[
              _imageSection(), //顶部图片
              _titleSection(), //标题
              _buttonSection(),//按钮
              _textSection(),  //文本
            ],
          ),
        )
        );
  }
}
