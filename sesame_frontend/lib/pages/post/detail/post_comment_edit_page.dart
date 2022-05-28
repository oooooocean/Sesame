import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/keyboard_allocator.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';

class PostCommentEditPage extends StatelessWidget with KeyboardAllocator, ThemeMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  PostCommentEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: GestureDetector (
          behavior: HitTestBehavior.opaque,
          onTap: () => Get.back(),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: TextField (
                focusNode: _focusNode,
                autofocus: true,
                controller: _textController,
                textInputAction: TextInputAction.done,
                onSubmitted: (text) => Get.back(result: text),
                decoration: InputDecoration(filled: true, fillColor: borderColor, hintText: 'comment of civilization', focusedBorder: InputBorder.none),
              ),
            ),
          ),
        ),
      );
}
