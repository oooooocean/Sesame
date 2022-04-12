import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/app.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:sesame_frontend/services/launch_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(initRoute: await init()));
}

Future<String> init() async {
  await LaunchService.shared.init();
  Get.put(LaunchService.shared);
  return LaunchService.shared.isLogin ? AppRoutes.albumList : AppRoutes.login;
}
