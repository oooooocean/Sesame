import 'package:flutter/material.dart';
import 'package:personal_info_demo/shop/shopPage.dart';
import 'package:personal_info_demo/find/findPage.dart';
import 'package:personal_info_demo/home/homePage.dart';
import 'package:personal_info_demo/mine/minePage.dart';

class rootPage extends StatefulWidget {

  const rootPage({Key? key}) : super(key: key);

  @override
  _rootPageState createState() => _rootPageState();

}
class _rootPageState extends State<rootPage> {
  @override
  var _currentIndex = 0 ;
  List<Widget> _pages = [homePage(),findPage(),shopPage(),minePage()];

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("pet_demo"),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.contacts),label: '宠圈'),
          BottomNavigationBarItem(icon: Icon(Icons.find_in_page),label: '商城'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的')
        ],
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black,
          onTap: (index){
            setState(
                (){
                  _currentIndex = index;
                }
            );
          },
          
        ),
      ),
    );
  }



}