import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/pages/post/create/post_create_controller.dart';

class PostCreatePage extends GetView<PostCreateController> with ThemeMixin, LoadImageMixin {
  PostCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar,
        body: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [_descriptionItem, _photosItem]),
      );

  AppBar get _appBar => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        actions: [IconButton(onPressed: controller.publish, icon: const Icon(Icons.launch))],
      );

  Widget get _descriptionItem => TextField(
      controller: controller.descriptionController,
      maxLength: 200,
      maxLines: 4,
      style: TextStyle(color: primaryColor, fontSize: 15.0),
      decoration: const InputDecoration(hintText: 'What you\'re thinking now...', border: InputBorder.none));

  Widget get _photosItem => GetBuilder<PostCreateController>(
      id: 'photos',
      builder: (_) {
        List<Widget> photos = controller.photos
            .map(
              (photo) => TextButton(
                onPressed: controller.chosePhotos,
                child: SizedBox.expand(child: buildNetImage(photo.thumbnailUrl, fit: BoxFit.cover)),
                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
              ),
            )
            .toList();
        if (photos.length < 9) {
          photos.add(
            TextButton(
                onPressed: controller.chosePhotos,
                child: const Icon(Icons.add, color: Colors.grey, size: 40),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(borderColor))),
          );
        }
        return GridView.count(
            padding: const EdgeInsets.only(top: 20.0, right: 20),
            crossAxisCount: 3,
            children: photos,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            shrinkWrap: true);
      });
}
