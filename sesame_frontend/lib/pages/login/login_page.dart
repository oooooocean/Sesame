import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/pages/login/login_controller.dart';
import 'package:sesame_frontend/pages/login/views/login_code_view.dart';
import 'package:sesame_frontend/pages/login/views/login_prepare_view.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/login-bg.png'), fit: BoxFit.cover)),
          child: Obx(() {
            switch (controller.pageState.value) {
              case LoginPageState.prepare:
                return const LoginPrepareView();
              case LoginPageState.code:
                return LoginCodeView();
              default:
                return LoginCodeView();
            }
          }),
        ),
      );
}
