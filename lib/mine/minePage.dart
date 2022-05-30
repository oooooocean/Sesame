import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_info_demo/mine/views/mineCell.dart';

class minePage extends StatefulWidget {
  const minePage({Key? key}) : super(key: key);

  @override
  State<minePage> createState() => _minePageState();
}

class _minePageState extends State<minePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          mineCell(title: "联系我们", iconImageName: 'images/猫.png'),
          Divider(height: 0.5,color: Colors.grey,indent: 50,),
          mineCell(title: "分享给好友", iconImageName: 'images/猫包.png'),
          Divider(height: 0.5,color: Colors.grey,indent: 50,),
          mineCell(title: "去评分", iconImageName: 'images/猫条.png'),
          SizedBox(height: 20,),

          mineCell(title: "意见反馈", iconImageName: 'images/猫草.png'),
          Divider(height: 0.5,color: Colors.grey,indent: 50,),

          mineCell(title: "用户协议", iconImageName: 'images/猫爬架.png'),
          Divider(height: 0.5,color: Colors.grey,indent: 50,),
          SizedBox(height: 20,),

          mineCell(title: "宠物档案", iconImageName: 'images/逗猫棒.png'),
          Divider(height: 0.5,color: Colors.grey,indent: 50,),

        ],

      ),




    );
  }
}

