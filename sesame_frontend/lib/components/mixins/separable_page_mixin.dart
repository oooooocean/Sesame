import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SeparablePageMixin<T, P extends StatefulWidget> on State<P>{
  bool get wantKeepAlive => true;

  T get controller => Get.find<T>();

  String get routeName => throw UnimplementedError('子类实现');

  Widget get body => throw UnimplementedError('子类实现');

  Widget get page => throw UnimplementedError('子类实现');

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (Get.currentRoute != routeName) return body;

    return page;
  }
}