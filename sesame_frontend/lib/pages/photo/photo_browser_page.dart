import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/pages/photo/photo_browser_controller.dart';

class PhotoBrowserPage extends GetView<PhotoBrowserController> with LoadImageMixin {
  const PhotoBrowserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ExtendedImageSlidePage(
        child: Scaffold(
          body: ExtendedImageGesturePageView.builder(
            itemBuilder: _itemBuilder,
            itemCount: controller.images.length,
            onPageChanged: (index) {
              controller.initIndex = index;
              controller.update([index.toString()]);
            },
            controller: ExtendedPageController(initialPage: controller.initIndex),
          ),
        ),
      );

  Widget _itemBuilder(BuildContext context, int index) {
    final photo = controller.images[index];
    final image = Padding(
      padding: const EdgeInsets.all(5),
      child: ExtendedImage.network(buildNetImageUrl(photo.name, width: Get.width, height: Get.height),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (_) => GestureConfig(inPageView: true),
          enableSlideOutPage: true),
    );
    return GetBuilder<PhotoBrowserController>(
        id: index.toString(),
        builder: (_) => controller.initIndex == index ? Hero(tag: photo.name, child: image) : image);
  }
}
