import 'package:get/get.dart';
import 'package:sesame_frontend/models/photo.dart';

class PhotoBrowserController extends GetxController {
  final List<Photo> images;
  int initIndex;
  final String Function(Photo) heroTagGetter;

  PhotoBrowserController()
      : images = Get.arguments[0],
        initIndex = Get.arguments[1],
        heroTagGetter = Get.arguments[2];
}
