import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/comps/refresh_scaffold.dart';
import 'package:sesame_frontend/route/pages.dart';

/// The entry of the app
class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    _customLoading();
  }

  @override
  Widget build(BuildContext context) => refreshScaffold(
        child: GetMaterialApp(
            enableLog: const bool.fromEnvironment('dart.vm.product'),
            initialRoute: AppRoutes.login,
            getPages: appRoutes,
            builder: EasyLoading.init(),
            theme: themeData),
      );

  /// custom loading
  /// see https://pub.dev/packages/flutter_easyloading
  void _customLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid;
  }

  /// theme
  ThemeData get themeData => ThemeData(scaffoldBackgroundColor: const Color(0xfff4f4f4));
}
