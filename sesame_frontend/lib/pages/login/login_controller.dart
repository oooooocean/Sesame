import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum LoginPageState {
  prepare,
  code,
  password
}

class LoginController extends GetxController {
  final photoController = TextEditingController();
  final codeController = TextEditingController();
  final photoNode = FocusNode();
  final codeNode = FocusNode();
  var pageState = LoginPageState.prepare.obs;

  void switchLoginPageState(LoginPageState state) {
    pageState.value = state;
  }
}