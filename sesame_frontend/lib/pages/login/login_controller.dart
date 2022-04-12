import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/sms_code_mixin.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:sesame_frontend/services/launch_service.dart';

enum LoginPageState { prepare, code, password }

class LoginController extends GetxController with SmsCodeMixin, NetMixin {
  final photoController = TextEditingController();
  final codeController = TextEditingController();
  var pageState = LoginPageState.prepare.obs;

  void switchLoginPageState(LoginPageState state) {
    pageState.value = state;
  }

  void login() async {
    EasyLoading.show();
    await post('login/', {'phone': photoController.text, 'code': codeController.text}, (data) {
      final user = User.fromJson(data['user']);
      final token = data['token'];
      Get.find<LaunchService>().login(user, token);
    }).then((value) {
      EasyLoading.dismiss();
      Get.offAllNamed(AppRoutes.albumCreate);
    }).catchError((error) {
      EasyLoading.dismiss();
      EasyLoading.showToast(error.toString());
    });
  }

  @override
  Future<bool> get fetchCodeRequest => Future.delayed(const Duration(seconds: 2)).then((value) => true);
}
