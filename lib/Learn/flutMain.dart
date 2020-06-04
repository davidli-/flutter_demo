import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

// 主界面
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.orange //主题色
      ),
      home: RandomWords()
    );
  }
}

// 控件类
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

// 状态类
class RandomWordsState extends State<RandomWords>{
  
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
    
  @override
  Widget build(BuildContext context){
    //final wordPair = new WordPair.random();
    //return new Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[IconButton(icon:Icon(Icons.list), onPressed: _pushSaved)],
        ), 
      body: _buildSuggestions(),);
  }

  // 容器视图-ListView
  Widget _buildSuggestions() {
    return new ListView.builder( //初始化列表
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) { // 相当于cellForRowAtIndexPath:
        if (i.isOdd) { //奇数行
          // 在每一列之前，添加一个1像素高的分隔线widget
          return Divider(); // 返回分割线
        }
        final index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]); // 返回title
      }
    );
  }

  // 内部组件 Cell中的title
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text( // 左边文字
        pair.asPascalCase, 
        style:_biggerFont
        ),
      trailing: Icon( // 右边爱心
        alreadySaved? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
      onTap: (){ //匿名函数
        setState(() { //调用setState() 会为State对象触发build()方法，从而导致对UI的更新
          if (alreadySaved) {
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
      );
  }
  
  // cell的点击事件
  void _pushSaved(){
    print('+++clicked');
    Navigator.of(context).push( //push到新页面
      MaterialPageRoute(
        builder: (context) {
          
          final titles = _saved.map( // 闭包 返回cell中title的文字
            (pair){
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          
          final divided = ListTile.divideTiles(
            context: context,
            tiles: titles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }
      ),
    );
  }
}