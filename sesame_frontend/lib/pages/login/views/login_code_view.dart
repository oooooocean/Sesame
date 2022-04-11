import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sesame_frontend/components/mixins/keyboard_allocator.dart';
import 'package:sesame_frontend/pages/login/login_controller.dart';

class LoginCodeView extends GetView<LoginController> with KeyboardAllocator {
  final photoNode = FocusNode();
  final codeNode = FocusNode();

  LoginCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
          child: KeyboardActions(
            disableScroll: true,
            config: doneKeyboardConfig([photoNode, codeNode]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Hello,\nThis is your world', style: TextStyle(fontSize: 28, color: Colors.white)),
                    _photoItem,
                    _codeItem,
                    _submitItem
                  ]),
            ),
          ),
        ),
      );

  Widget get _photoItem => Row(children: [
        TextButton(
          onPressed: () {},
          child: Row(children: const [
            Text('+86', style: TextStyle(color: Colors.white)),
            Icon(Icons.arrow_drop_down, color: Colors.white)
          ]),
          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero), alignment: Alignment.centerLeft),
        ),
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller.photoController,
            focusNode: photoNode,
            cursorColor: Colors.white,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
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
          focusNode: codeNode,
          cursorColor: Colors.white,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Input SMS code',
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
        )),
        TextButton(
          onPressed: () => controller.fetchCode(controller.photoController.text),
          child: const Text('Fetch Code', style: TextStyle(color: Colors.white, fontSize: 14)),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.5))),
        ),
      ]);

  Widget get _submitItem => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: TextButton(
            onPressed: controller.login,
            child:
                const Text('Login', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 45)),
              backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.5)),
            ),
          ),
        ),
      );
}
