import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/sms_code_mixin.dart';

enum LoginPageState { prepare, code, password }

class LoginController extends GetxController with SmsCodeMixin {
  final photoController = TextEditingController();
  final codeController = TextEditingController();
  final photoNode = FocusNode();
  final codeNode = FocusNode();
  var pageState = LoginPageState.prepare.obs;

  void switchLoginPageState(LoginPageState state) {
    pageState.value = state;
  }

  @override
  Future<bool> get fetchCodeRequest => Future.delayed(const Duration(seconds: 2)).then((value) => true);
}
