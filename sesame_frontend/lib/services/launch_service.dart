import 'package:get/get.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:sesame_frontend/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchService {
  static final shared = LaunchService();

  bool isLogin = false;

  String userId = '';

  Future init() async {
    isLogin = (await SharedPreferences.getInstance()).containsKey('token');
    userId = isLogin ? (await User.cached())!.id.toString() : '';
  }

  void restart() {
    Get.offAllNamed(AppRoutes.login);
  }

  void login(User user, String token) {
    userId = user.id.toString();
    user.save();
    StoreToken.setToken(token);
  }
}
