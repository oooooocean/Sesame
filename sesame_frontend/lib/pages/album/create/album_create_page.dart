import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sesame_frontend/components/mixins/keyboard_allocator.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/pages/album/create/album_create_controller.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AlbumCreatePage extends GetView<AlbumCreateController>
    with KeyboardAllocator, ThemeMixin {
  final titleNode = FocusNode();
  final descriptionNode = FocusNode();

  AlbumCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Build your world')),
        body: SafeArea(
          child: KeyboardActions(
            config: doneKeyboardConfig([titleNode, descriptionNode]),
            child: SizedBox(
              height: Get.height - Get.statusBarHeight - kToolbarHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 15.0),
                child: Column(
                  children: [
                    _imageItem,
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: _albumTitleItem),
                      _albumDescriptionItem,
                    ]),
                    const Spacer(),
                    _nextItem
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _imageItem => TextButton(
        child: GetBuilder<AlbumCreateController>(
            id: 'cover',
            builder: (_) => controller.cover != null
                ? Image(
                    image: AssetEntityImageProvider(controller.cover!),
                    width: Get.width,
                    fit: BoxFit.cover)
                : Icon(Icons.add_a_photo_outlined, size: 40, color: greyColor)),
        onPressed: controller.choseCover,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(borderColor),
          fixedSize: MaterialStateProperty.all(Size(Get.width, 140)),
        ),
      );

  Widget get _albumTitleItem => TextField(
        textAlign: TextAlign.center,
        focusNode: titleNode,
        controller: controller.titleController,
        maxLength: 10,
        onChanged: (_) => controller.update(['next']),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[\w\u4e00-\u9fa5_]'))
        ],
        decoration: InputDecoration(
            hintText: 'Enter album\'s title',
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: greyColor, width: 1))),
      );

  Widget get _albumDescriptionItem => TextField(
        focusNode: descriptionNode,
        controller: controller.descriptionController,
        maxLines: 5,
        maxLength: 100,
        onChanged: (_) => controller.update(['next']),
        decoration: InputDecoration(
            hintText: 'Enter album\'s description',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greyColor, width: 1))),
      );

  Widget get _nextItem => GetBuilder<AlbumCreateController>(
      id: 'next',
      builder: (_) {
        final enable = controller.shouldNext;
        final color = controller.shouldNext ? accentColor : Colors.grey;
        return TextButton(
          onPressed: enable ? controller.create : null,
          child: Text('CREATE NOW', style: TextStyle(color: color)),
          style: ButtonStyle(
              side: MaterialStateProperty.all(BorderSide(color: color))),
        );
      });
}
