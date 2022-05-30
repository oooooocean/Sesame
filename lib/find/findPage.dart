import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class findPage extends StatefulWidget {
  const findPage({Key? key}) : super(key: key);

  @override
  State<findPage> createState() => _findPageState();
}

class _findPageState extends State<findPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:
    const Scaffold(
      body: Center(
        child: Text('宠圈'),
      ),
    ),
    );
  }
}
