import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/app.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:sesame_frontend/services/launch_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  inject();
  final isLogin = false; // await Get.find<LaunchService>().isLogin;

  runApp(App(initRoute: isLogin ? AppRoutes.albumCreate : AppRoutes.login));
}

void inject() {
  Get.put(LaunchService.shared);
}
