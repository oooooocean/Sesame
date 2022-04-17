import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_www/route/pages.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse
      };
}

void main() {
  runApp(GetMaterialApp(
    scrollBehavior: MyCustomScrollBehavior(),
    getPages: appRoutes,
    initialRoute: AppRoutes.home,
  ));
}
