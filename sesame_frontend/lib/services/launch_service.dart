import 'package:get/get.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchService {
  static final shared = LaunchService();

  Future<bool> get isLogin async => (await SharedPreferences.getInstance()).containsKey('token');

  void restart() {
    Get.offAllNamed(AppRoutes.login);
  }
}
