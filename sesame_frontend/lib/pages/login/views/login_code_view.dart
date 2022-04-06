import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sesame_frontend/components/mixins/keyboard_allocator.dart';
import 'package:sesame_frontend/pages/login/login_controller.dart';

class LoginCodeView extends GetView<LoginController> with KeyboardAllocator {
  const LoginCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
          child: KeyboardActions(
            disableScroll: true,
            config: doneKeyboardConfig([controller.photoNode, controller.codeNode]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Hello,\nThis is your world', style: TextStyle(fontSize: 28, color: Colors.white)),
                    _photoItem,
                    _codeItem
                  ]),
            ),
          ),
        ),
      );

  Widget get _photoItem => Row(children: [
        TextButton(
          onPressed: () {},
          child: Row(mainAxisSize: MainAxisSize.min, children: const [
            Text('+86', style: TextStyle(color: Colors.white)),
            Icon(Icons.arrow_drop_down, color: Colors.white)
          ]),
        ),
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller.photoController,
            focusNode: controller.photoNode,
            cursorColor: Colors.white,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                counterStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Input your phone',
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
          ),
        ),
      ]);

  Widget get _codeItem => Row(children: [
        Expanded(
            child: TextField(
          style: const TextStyle(color: Colors.white),
          controller: controller.codeController,
          focusNode: controller.codeNode,
          cursorColor: Colors.white,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Input SMS code',
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
        )),
        TextButton(
          onPressed: () => controller.fetchCode(controller.photoController.text),
          child: const Text('发送验证码', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.5))),
        ),
      ]);
}
