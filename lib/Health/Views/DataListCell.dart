import 'package:flutter/material.dart';

class DataListCell extends StatelessWidget {

  //属性
  final String district;       //地区
  final int nowConfirmed;      //现有确诊数
  final int totoalConfrirmed;  //总确诊数
  final int death;             //死亡
  final int cured;             //治愈

  //构造函数
  DataListCell({this.district,this.nowConfirmed,this.totoalConfrirmed,this.death,this.cured});
  
  //创建cell中的子元素
  Widget _buildItem(BuildContext context, String text, Color color){
    final cellWidth = (MediaQuery.of(context).size.width - 6*5) / 5;
    return Container(
      width: cellWidth,
      alignment: Alignment.center,
      child: Text(text == 'null' ? '未知' : text, 
      overflow: TextOverflow.fade,
      maxLines: 1,
        style: TextStyle(
            color: color
          ),
      ),
    );
  }

  //界面
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //地区
        _buildItem(context, district, Colors.black),
        
        //现有确诊数
        _buildItem(context, '$nowConfirmed', Colors.red),
        
        //总确诊数
        _buildItem(context, '$totoalConfrirmed', Colors.black),
        
        //死亡
        _buildItem(context, '$death', Colors.black),
        
        //治愈
        _buildItem(context, '$cured', Colors.black),
      ],
    );
  }
}