import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/reload_mixin.dart';
import 'package:sesame_frontend/models/photo.dart';
import 'package:sesame_frontend/models/post.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/pages/photo/photo_select_controller.dart';
import 'package:sesame_frontend/route/pages.dart';

class PostCreateController extends GetxController with NetMixin {
  final descriptionController = TextEditingController();
  List<Photo> photos = [];

  @override
  String? shouldRequest() {
    if (photos.isEmpty) return 'Please select at least one image';
    if (descriptionController.text.isEmpty) return 'Please enter description';
    return null;
  }

  void publish() {
    final api = post(
        'post/',
        {'description': descriptionController.text, 'photo_ids': photos.map((e) => e.id).toList()},
        (data) => Post.fromJson(data));
    request(api, success: (_) => Get.back());
  }

  void chosePhotos() {
    final config = PhotoSelectConfiguration(lastSelected: photos.map((e) => e.id).toList(), limit: 9);
    Get.toNamed(AppRoutes.photoSelect, arguments: config)?.then((value) {
      if (value == null) return;
      photos = value ?? [];
      update(['photos']);
    });
  }

  @override
  void onReady() {
    chosePhotos();
    super.onReady();
  }
}
