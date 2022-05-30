
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_info_demo/mine/views/pet_info_view.dart';

class petInfoPage extends StatefulWidget {

  final String ? title;
  petInfoPage(this.title);

  @override
  State<petInfoPage> createState() => _petInfoPageState();

}

class _petInfoPageState extends State<petInfoPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: Container(
        // color: Colors.red,
        child: ListView(
          children: [
            headView(),
            SizedBox(height: 16,),
            pet_input_cell(),
            SizedBox(height: 16,),

           Container(
             margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
             child: Column(
               children: [
                 pet_select_cell(title: "宠物品种", desTitle: "点击选择品种"),
                 Divider(height: 0.5,color: Colors.grey,indent: 16,endIndent: 16,),

                 pet_select_cell(title: "出生日期", desTitle: "点击选择生日"),
                 Divider(height: 0.5,color: Colors.grey,indent: 16,endIndent: 16,),

                 pet_info_tips(),
                 SizedBox(height: 16,),
               ],
             ),
           ),
            
            pet_inputTextView(),
            SizedBox(height: 16,),

            pet_sure_button()








          ],
        ),
      ),
    );
  }
}



class headView extends StatefulWidget {
  const headView({Key? key}) : super(key: key);

  @override
  State<headView> createState() => _headViewState();
}

class _headViewState extends State<headView> {
  File? _avatarFile;
  final MethodChannel _methodChannel = const MethodChannel('minePage/method');

  @override
  void initState() {
    super.initState();
    _methodChannel.setMethodCallHandler((call) async{
      if (call.method == 'imagePath') {


        String imagePath = call.arguments.toString().substring(7);
        print(call.arguments);
        print(imagePath);
        setState(() {
          _avatarFile = File(imagePath);
        });
      }else{
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height:  100,
      padding: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () {
              print("select HeadImage");
              _methodChannel.invokeListMethod('pictureMethod');

            },
            child: Icon(Icons.camera_alt_outlined) ,
          ),
          GestureDetector(
            onTap: () {
              print("select HeadImage");
              _methodChannel.invokeListMethod('pictureMethod');

            },
            child: Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                  image: _avatarFile == null
                      ?const DecorationImage( image:
                  AssetImage('images/猫.png'),
                      fit: BoxFit.cover)
                      : DecorationImage(image:
                  FileImage(_avatarFile!),
                      fit: BoxFit.cover)
              ),

            ),
          ),


        ],
      ),


    );

  }
}

