import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/sms_code_mixin.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/net/net_mixin.dart';

enum LoginPageState { prepare, code, password }

class LoginController extends GetxController with SmsCodeMixin, NetMixin {
  final photoController = TextEditingController();
  final codeController = TextEditingController();
  final photoNode = FocusNode();
  final codeNode = FocusNode();
  var pageState = LoginPageState.prepare.obs;

  void switchLoginPageState(LoginPageState state) {
    pageState.value = state;
  }

  void login() async {
    EasyLoading.show();
    await post('login/', {'phone': photoController.text, 'code': codeController.text}, (data) {
      final user = User.fromJson(data['user']);
      user.save();
      final token = data['token'];
    }).catchError((error) {
      EasyLoading.showToast(error.toString());
    }).whenComplete(() => EasyLoading.dismiss());
  }

  @override
  Future<bool> get fetchCodeRequest => Future.delayed(const Duration(seconds: 2)).then((value) => true);
}
