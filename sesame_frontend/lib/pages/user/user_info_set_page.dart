import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sesame_frontend/components/mixins/keyboard_allocator.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/register_flow_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:sesame_frontend/services/launch_service.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'user_info_set_controller.dart';

class UserInfoSetPage extends GetView<UserInfoSetController> with ThemeMixin, KeyboardAllocator {
  final nickNameNode = FocusNode();

  UserInfoSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Setting personal Information')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _avatarItem,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: _nicknameItem,
                      ),
                      _genderItem,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: _nextItem,
                )
              ],
            ),
          ),
        ),
      );

  Widget get _avatarItem => OutlinedButton(
        onPressed: controller.choseAvatar,
        child: GetBuilder<UserInfoSetController>(
          id: 'avatar',
          builder: (_) => controller.avatarProvider == null
              ? const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.portrait, size: 40, color: Colors.grey),
                )
              : ClipOval(child: Image(image: controller.avatarProvider!, width: 80, height: 80, fit: BoxFit.cover)),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          side: MaterialStateProperty.all(BorderSide(color: Colors.grey.withOpacity(0.25), width: 3)),
        ),
      );

  Widget get _nicknameItem => KeyboardActions(
      autoScroll: false,
      config: doneKeyboardConfig([nickNameNode]),
      child: TextField(
        focusNode: nickNameNode,
        controller: controller.nicknameController,
        maxLength: 20,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\w\u4e00-\u9fa5]'))],
        onChanged: (_) => controller.update(['next']),
        decoration: InputDecoration(
            hintText: 'Enter your nickname',
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: borderColor, width: 1)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColor, width: 1))),
      ));

  Widget get _genderItem => GetBuilder<UserInfoSetController>(
        id: 'gender',
        builder: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Gender.values.map((gender) {
            final color = controller.gender == gender ? accentColor : Colors.grey;
            return OutlinedButton(
              onPressed: () => controller.choseGender(gender),
              child: Icon(gender == Gender.male ? Icons.male : Icons.female, color: color),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                shadowColor: MaterialStateProperty.all(color),
                side: MaterialStateProperty.all(BorderSide(color: color.withOpacity(0.25), width: 1.5)),
              ),
            );
          }).toList(),
        ),
      );

  Widget get _nextItem => GetBuilder<UserInfoSetController>(
      id: 'next',
      builder: (_) {
        final enable = controller.shouldRequest() == null;
        final color = enable ? accentColor : borderColor;
        return TextButton(
          onPressed: enable ? controller.save : null,
          child: Text('Next', style: TextStyle(color: color)),
          style: ButtonStyle(side: MaterialStateProperty.all(BorderSide(color: color))),
        );
      });
}
