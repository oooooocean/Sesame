import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/app.dart';
import 'package:sesame_frontend/services/launch_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  inject();
  runApp(App());
}

void inject() {
  Get.put(LaunchService.shared);
}
