import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'user_info_set_controller.dart';

class UserInfoSetPage extends GetView<UserInfoSetController> {
  const UserInfoSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(title: const Text('Setting personal Information')),
        body: Column(
          children: [
            CircleAvatar(child: _avatar),
          ],
        ),
      );


  Widget get _avatar =>
      IconButton(
          onPressed: controller.choseAvatar,
          icon: controller.avatarProvider == null ? const Icon(Icons.portrait, size: 40) : Image(
              image: controller.avatarProvider!));
}


