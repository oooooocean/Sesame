import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/models/post.dart';

class PostDetailController extends GetxController {
  final Post post;
  late TabController tabController;

  PostDetailController() : post = Get.arguments;

  void tapTab() => update();
}