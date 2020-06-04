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
      return 
      // Image.network( //网络图片
      //   'http://t8.baidu.com/it/u=1484500186,1503043093&fm=79&app=86&f=JPEG?w=1280&h=853',
      //   fit: BoxFit.fill,
      // )
      Image.asset( // 本地图片 需要在pubspec.yaml->assets:中配置图片的路径
        "assets/images/4131.jpg",
        fit: BoxFit.fitWidth,
      )
      ;
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
    
    // 3.函数->返回三个按钮及其父容器控件
    Widget _buttonSection(){
      return Container(
        color: Colors.orange[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Icons.call, 'Call', 0),
            _buildButtonColumn(Icons.near_me, 'ROUTE', 1),
            _buildButtonColumn(Icons.share, 'Share', 2),
          ],
        ),
      );
    }

    // 4.函数->返回底部文本控件
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

    // 5.辅助函数->返回单个按钮所在的列
    Widget _buildButtonColumn(IconData icon, String text, int index){
      Color color = Theme.of(context).primaryColor;
      return Container(
        color: Colors.green[500],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(icon:Icon(icon), 
            color: color,
            onPressed: (){  // 按钮点击事件
              _clickedBtn(index);
            }),
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
        ),
      );
    }

    // 按钮响应函数->push到下一页面
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

  // 按钮响应函数->处理按钮的点击业务
  _clickedBtn(int index){
    print('+++Clicked btn-$index~');
  }
}