import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/route/pages.dart';

class ScaffoldController extends GetxController {
  late TabController tabController;

  void tapRightAction() {
    Get.toNamed(tabController.index == 0 ? AppRoutes.albumCreate : AppRoutes.postCreate);
  }
}