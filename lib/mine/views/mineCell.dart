
import 'package:flutter/material.dart';

import '../petInfoPage.dart';

class mineCell extends StatefulWidget {
  String? iconImageName;
  String? title;
  String? desTitle;
  String? desIconImageName;

  mineCell({
    required this.title,
    required this.iconImageName,
    this.desIconImageName,
    this.desTitle
  }):assert(title != null,'标题不能为空'),
        assert(iconImageName != null, '图标不能为空');
  @override
  State<StatefulWidget> createState() => _mineCellState();
}

class _mineCellState extends State<mineCell> {
  @override
  Color _currentColor = Colors.white;
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {

        Navigator.of(context)
                 .push(MaterialPageRoute(builder:
            (BuildContext context) => petInfoPage(widget.title)));
        setState((){
          _currentColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState((){
          _currentColor = Colors.grey;

        });

      },
      onTapCancel: () {
        setState((){
          _currentColor = Colors.white;
        });
      },



      child:   Container(
        height: 44,
        color: _currentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,// 等分
          children: [
            //左边
            Container(
              padding: EdgeInsets.all(10),//边距
              child: Row(
                children: [
                  Image.asset(widget.iconImageName!,width: 20,),
                  SizedBox(width: 10,),//间隔
                  Text(widget.title!),
                ],
              ),
            ),
            //右边
            Container(

              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Row (
                children: [
                  widget.desTitle != null ? Text(widget.desTitle!) : Container(),
                  widget.desIconImageName != null ? Image.asset(widget.desIconImageName!) : Container(),
                  Icon(Icons.arrow_forward_ios_sharp,size: 16,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


