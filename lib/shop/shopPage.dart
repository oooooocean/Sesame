import 'package:flutter/material.dart';

class shopPage extends StatefulWidget {
  const shopPage({Key? key}) : super(key: key);

  @override
  State<shopPage> createState() => _shopPagePageState();
}

class _shopPagePageState extends State<shopPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Scaffold(
        body: Center(
          child: Text('商城'),
        ),
      ),
    );
  }
}
