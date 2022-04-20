import 'package:get/get.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:sesame_frontend/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchService {
  static final shared = LaunchService();

  /// 是否登录
  bool isLogin = false;

  User? user;

  List<String> registerFlows = [];

  Future init() async {
    isLogin = (await SharedPreferences.getInstance()).containsKey('token');
    user = isLogin ? (await User.cached())! : null;
    if (isLogin) setRegisterFlows();
  }

  Future restart() async {
    await Store.clear();
    await init();
    Get.offAllNamed(AppRoutes.login);
  }

  void login(User user, String token) {
    updateUser(user);
    StoreToken.setToken(token);
  }

  void updateUser(User user) {
    user.save();
    this.user = user;
  }

  Future setRegisterFlows() async {
    if (!(user!.info?.isCompletion ?? false)) registerFlows.addAll([AppRoutes.userInfoSet, AppRoutes.albumCreate]);
  }

  String get firstRoute =>
      isLogin ? (registerFlows.isNotEmpty ? registerFlows.first : AppRoutes.scaffold) : AppRoutes.login;
}
