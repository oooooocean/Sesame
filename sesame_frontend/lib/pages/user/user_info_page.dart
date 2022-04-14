import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/pages/user/user_info_controller.dart';
import 'package:sesame_frontend/services/launch_service.dart';

class UserInfoPage extends GetView<UserInfoController> with LoadImageMixin, ThemeMixin {
  final avatarSize = 80.0;

  const UserInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              color: Colors.white,
              width: Get.width,
              child: Column(children: [
                _avatarItem,
                const SizedBox(height: 8),
                _nicknameItem
              ]),
            ),
            const Spacer(),
            _logoutItem
          ],
        ),
      ),
    );
  }

  Widget get _avatarItem => OutlinedButton(
        onPressed: () {},
        child: controller.info.avatar == null
            ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(Icons.portrait, size: 40, color: Colors.grey),
              )
            : ClipOval(
                child: buildNetImage(buildNetImageUrl(controller.info.avatar!, width: avatarSize, height: avatarSize),
                    width: avatarSize, height: avatarSize, fit: BoxFit.cover)),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          side: MaterialStateProperty.all(BorderSide(color: Colors.grey.withOpacity(0.25), width: 3)),
        ),
      );

  Widget get _nicknameItem => Text(
    controller.info.nickname ?? 'o(╥﹏╥)o',
    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
  );

  Widget get _logoutItem => TextButton(
        onPressed: () async => await Get.find<LaunchService>().restart(),
        child: const Text('LOGOUT', style: TextStyle(color: Colors.redAccent)),
        style: ButtonStyle(side: MaterialStateProperty.all(const BorderSide(color: Colors.redAccent))),
      );
}
