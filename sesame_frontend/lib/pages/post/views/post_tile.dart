import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/post.dart';
import 'package:sesame_frontend/pages/post/list/post_list_controller.dart';

class PostTile extends GetView<PostListController> with LoadImageMixin, ThemeMixin {
  final Post post;
  final space = const SizedBox(height: 5);

  PostTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [space, _headerItem, space, _descriptionItem, space, _photosItem, space]),
      );

  Widget get _headerItem => SizedBox(
        height: 50,
        child: Row(
          children: [
            _avatarItem,
            const SizedBox(width: 5),
            Text(post.owner.nickname ?? 'UNKNOWN', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      );

  Widget get _avatarItem => InkWell(
      child: CircleAvatar(backgroundImage: NetworkImage(post.owner.thumbnailUrl)),
      onTap: () => controller.onTapAvatar(post));

  Widget get _descriptionItem => Text(post.description, style: TextStyle(color: primaryColor, fontSize: 15));

  Widget get _photosItem {
    int crossAxisCount;
    BoxFit fit = BoxFit.cover;
    double widthRadio = 1;
    switch (post.photos.length) {
      case 1:
        crossAxisCount = 1;
        fit = BoxFit.contain;
        widthRadio = 0.65;
        break;
      case 2:
      case 4:
        crossAxisCount = 2;
        widthRadio = 0.65;
        break;
      default:
        crossAxisCount = 3;
    }

    if (post.photos.length == 1) {
      return ConstrainedBox(
          constraints: BoxConstraints.loose(Size((Get.width - 30) * widthRadio, Get.height)),
          child: buildNetImage(post.photos.first.thumbnailUrl, fit: fit, alignment: Alignment.centerLeft));
    } else {
      return ConstrainedBox(
          constraints: BoxConstraints.loose(Size.fromWidth((Get.width - 30) * widthRadio)),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: post.photos.length,
            itemBuilder: (_, index) => InkWell(
              onTap: () => controller.onTapPhoto(post, index),
              child: SizedBox.expand(child: buildNetImage(post.photos[index].thumbnailUrl, fit: fit)),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, crossAxisSpacing: 4, mainAxisSpacing: 4),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ));
    }
  }
}
