import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

mixin SmsCodeMixin on GetxController {

  var codeString = 'Fetch Code'.obs;
  Timer? timer;
  int _counter = 59;

  void fetchCode(String phone) {
    if ((timer?.isActive ?? false) || phone.length != 11) return;

    startTimer();
    EasyLoading.show();
    fetchCodeRequest
        .then((value) {
          EasyLoading.dismiss();
          return value;
        })
        .then((value) => EasyLoading.showToast(value ? '验证码发送成功' : '验证码发送失败'))
        .catchError((e) => EasyLoading.showToast(e.toString()));
  }

  Future<bool> get fetchCodeRequest => throw UnimplementedError('子类实现');

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final isCompletion = _counter == 0;
      if (isCompletion) timer.cancel();
      _counter = isCompletion ? 59 : (_counter - 1);
      codeString.value = isCompletion ? 'Fetch Code' : '${_counter}s';
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
