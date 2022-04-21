import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/models/photo.dart';

class PostPhotosTileConfiguration {
  int crossAxisCount = 0;
  BoxFit fit = BoxFit.cover;
  double widthRadio = 1;

  PostPhotosTileConfiguration(int photoCount) {
    switch (photoCount) {
      case 1:
        crossAxisCount = 1;
        fit = BoxFit.contain;
        widthRadio = 0.65;
        break;
      case 2:
      case 4:
        crossAxisCount = 2;
        widthRadio = 0.65;
        fit = BoxFit.cover;
        break;
      default:
        crossAxisCount = 3;
        widthRadio = 1;
        fit = BoxFit.cover;
    }
  }
}

class PostPhotosTile extends StatelessWidget with LoadImageMixin {
  final List<Photo> photos;
  final void Function(int) onTap;
  final PostPhotosTileConfiguration configuration;

  PostPhotosTile({Key? key, required this.photos, required this.onTap})
      : configuration = PostPhotosTileConfiguration(photos.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (photos.length == 1) {
      return ConstrainedBox(
        constraints: BoxConstraints.loose(Size((Get.width - 30) * configuration.widthRadio, Get.height)),
        child: buildNetImage(photos.first.thumbnailUrl, fit: configuration.fit, alignment: Alignment.centerLeft),
      );
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints.loose(Size.fromWidth((Get.width - 30) * configuration.widthRadio)),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: photos.length,
          itemBuilder: (_, index) => InkWell(
            onTap: () => onTap(index),
            child: SizedBox.expand(child: buildNetImage(photos[index].thumbnailUrl, fit: configuration.fit)),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: configuration.crossAxisCount, crossAxisSpacing: 4, mainAxisSpacing: 4),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      );
    }
  }
}
