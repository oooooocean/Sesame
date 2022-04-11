import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/keyboard_allocator.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/pages/album/create/album_create_controller.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AlbumCreatePage extends GetView<AlbumCreateController> with KeyboardAllocator, ThemeMixin {
  final titleNode = FocusNode();
  final descriptionNode = FocusNode();

  AlbumCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Build your world'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          child: Column(
            children: [
              _imageItem,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  focusNode: titleNode,
                  controller: controller.titleController,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'Enter album\'s title',
                    border: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 1)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColor, width: 1)),
                  ),
                ),
              ),
              TextField(
                focusNode: descriptionNode,
                controller: controller.descriptionController,
                maxLines: 5,
                maxLength: 100,
                decoration: InputDecoration(
                  hintText: 'Enter album\'s description',
                  border: OutlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 1)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: secondaryColor, width: 1)),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: controller.create,
                child: Text('CREATE NOW', style: TextStyle(color: primaryColor)),
                style: ButtonStyle(side: MaterialStateProperty.all(BorderSide(color: primaryColor))),
              )
            ],
          ),
        ),
      );

  Widget get _imageItem => TextButton(
        child: GetBuilder<AlbumCreateController>(
            id: 'cover',
            builder: (_) => controller.cover != null
                ? Image(image: AssetEntityImageProvider(controller.cover!), width: Get.width, fit: BoxFit.cover)
                : Icon(Icons.add_a_photo_outlined, size: 40, color: primaryColor)),
        onPressed: controller.choseCover,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
          fixedSize: MaterialStateProperty.all(Size(Get.width, 140)),
        ),
      );
}
