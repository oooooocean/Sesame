import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/comps/refresh_scaffold.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/route/pages.dart';

/// The entry of the app
class App extends StatelessWidget with ThemeMixin {
  final String initRoute;

  App({Key? key, required this.initRoute}) : super(key: key) {
    _customLoading();
  }

  @override
  Widget build(BuildContext context) => refreshScaffold(
        child: GetMaterialApp(
            enableLog: const bool.fromEnvironment('dart.vm.product'),
            initialRoute: initRoute,
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
  ThemeData get themeData => ThemeData(
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: secondaryColor), counterStyle: const TextStyle(color: Colors.grey)),
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: true,
          titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      scaffoldBackgroundColor: const Color(0xfff4f4f4));
}
