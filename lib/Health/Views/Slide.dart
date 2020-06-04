import 'package:flutter/material.dart';
import 'package:flutter_demo/Health/Utils/AMap.dart';
import 'WebView.dart';
import '../Utils/FetchCases.dart';

class Slide extends StatelessWidget {

  // push到内置网页
  _pushToURL(BuildContext context, String title, String url){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_){
        return HealthWebView(title ,url);
      })
    );
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            accountName: Text("欢迎光临我的博客~",
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(color: Colors.black, offset: Offset(0, 1), blurRadius: 2)
                ]
              ),
            ), 
            accountEmail: RichText( //富文本
              text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "https://davidlii.cn", 
                    style: TextStyle(color: Colors.white, 
                      fontSize: 20,
                      shadows: <Shadow>[
                          Shadow(color: Colors.black, offset: Offset(0, 2), blurRadius: 2)
                      ]
                    )
                  ),
                ],
              )
            ),
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/4131.jpg')),
            ),
            onDetailsPressed: (){
              _pushToURL(context, 'Davidlii', 'https://davidlii.cn');
            },
          ),
          
          ListTile(title: Text("位置"),
            leading: Icon(Icons.location_on),
            onTap: (){
              AMap.getLocation().then((value) => Navigator.pop(context));
            },
          ),
          
          ListTile(title: Text("刷新"),
          leading: Icon(Icons.refresh),
          onTap: (){
            Fetch.reqData().then((value) => Navigator.pop(context));
          },
          ),
          
          ListTile(
            title: Text("版权"),
            leading: Icon(Icons.copyright),
            onTap: (){
              _pushToURL(context, '网易新冠肺炎疫情动态地图', 'https://wp.m.163.com/163/page/news/virus_report/index.html');
            },
          ),
        ],
      ),
    );
  }
}
