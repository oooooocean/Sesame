import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sesame_frontend/components/mixins/keyboard_allocator.dart';
import 'package:sesame_frontend/pages/login/login_controller.dart';
import 'package:flutter/material.dart';

class LoginCodeView extends GetView<LoginController> with KeyboardAllocator {
  const LoginCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => KeyboardActions(
      config: doneKeyboardConfig([controller.photoNode, controller.codeNode]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Hello,\nThis is your world', style: TextStyle(fontSize: 28, color: Colors.white)),
        Row(children: [
          TextButton(
              onPressed: () {},
              child: Row(mainAxisSize: MainAxisSize.min, children: const [Text('+86'), Icon(Icons.arrow_drop_down)])),
          Expanded(child: TextField(
            focusNode: controller.photoNode,
            decoration: const InputDecoration.collapsed(hintText: 'Input your phone', border: UnderlineInputBorder()),
          ))
        ])
      ]));
}
