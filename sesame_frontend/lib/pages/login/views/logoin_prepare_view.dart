import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/pages/login/login_controller.dart';

class LoginPrepareView extends GetView<LoginController> with LoadImageMixin {
  const LoginPrepareView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipOval(child: buildAssetImage('logo', width: 45)),
        const Spacer(),
        const Text('Hello,\nThis is your world', style: TextStyle(fontSize: 28, color: Colors.white)),
        const SizedBox(height: 40),
        Row(children: [
          TextButton(
              onPressed: () => controller.switchLoginPageState(LoginPageState.code),
              child: const Text('Login with code'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white))),
          const SizedBox(width: 15),
          const Text('or', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
        ]),
        TextButton(
            onPressed: () => controller.switchLoginPageState(LoginPageState.password),
            child: const Text('Login with password'),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white))),
      ]);
}
