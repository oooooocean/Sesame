import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sesame_frontend/components/comps/refresh_scaffold.dart';

/// The entry of the app
class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    _customLoading();
  }

  @override
  Widget build(BuildContext context) => refreshScaffold(
        child: MaterialApp(
          builder: EasyLoading.init(),
        ),
      );

  /// custom loading
  /// see https://pub.dev/packages/flutter_easyloading
  void _customLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid;
  }
}
