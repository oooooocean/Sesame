import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
TextStyle _textStyle = TextStyle(
  fontWeight: FontWeight.bold,//加粗
  fontSize: 16,
  color: Colors.black54,

);
TextStyle _plachertextStyle = TextStyle(
  fontSize: 14,
  color: Colors.black26,

);
class pet_input_cell extends StatelessWidget {
  const pet_input_cell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Container(
      height: 44,
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child:  Row(
        children: [
          Text("宠物名字",style: _textStyle,),
          Expanded(child: TextField(
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: "输入宠物的名字",
              // prefixText: "宠物名字",
              fillColor: Colors.black12,
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.grey.withOpacity(0), width: 1)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0))),

            ),
          ))
        ],
      )
    );
  }
}

class pet_select_cell extends StatefulWidget {
  String? title;
  String? desTitle;

  pet_select_cell({
    required this.title,
    required this.desTitle
  }):assert(title != null,'标题不能为空'),
        assert(desTitle != null, '描述不能为空');

  @override
  State<pet_select_cell> createState() => _pet_select_cellState();
}

class _pet_select_cellState extends State<pet_select_cell> {


  @override
  Widget build(BuildContext context) {
   return GestureDetector(

     child: Container(
       color: Colors.white,
       height: 60,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,// 等分

         children: [
          Container(
            child:  Text(widget.title!,style: _textStyle,),
          ),
          Container(
            child: Row(
              children: [
                Text(widget.desTitle!,style: _plachertextStyle,),
                SizedBox(width: 10,),
                Icon(Icons.arrow_forward_ios_sharp,size:16,)
              ],
            )

          )

         ],
       ),
     ),

   );
  }
}
class pet_info_tips extends StatelessWidget {
  const pet_info_tips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Text("Tip: 如果生日不记得了，可以填写到家日期。",style: TextStyle(color: Colors.black26,fontSize: 12),

      ),
    );
  }
}
class pet_inputTextView extends StatelessWidget {
  const pet_inputTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),

      // padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: Text("个性签名",style: _textStyle,),
          ),
          Container(

            child: TextField(
              // maxLength: 100,
              // maxLines: 5,
              decoration: InputDecoration(
                hintText: "快写下你对崽崽想说的话吧",
                fillColor: Colors.black12,
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.black26.withOpacity(0), width: 1)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0))),

              ),
            ),
          )
        ],
      ),

    );
  }
}

class pet_sure_button extends StatefulWidget {
  const pet_sure_button({Key? key}) : super(key: key);

  @override
  State<pet_sure_button> createState() => _pet_sure_buttonState();
}

class _pet_sure_buttonState extends State<pet_sure_button> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 44,
        padding: EdgeInsets.fromLTRB(20, 0, 16, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
        ),

        child: Container(
          width: width-32,
          height: 44,
          alignment: Alignment.center,

          color: Colors.redAccent,
          child: Text("保存",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),),
        )
      ),
    );


    return Container(


      height: 44,
        // color: Colors.redAccent/,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        ),
        child: GestureDetector(
        onTap: (){},

    child: Text("保存",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),),
    ),
    );
  }
}
