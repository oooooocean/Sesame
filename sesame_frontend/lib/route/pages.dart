import 'package:get/get.dart';
import 'package:sesame_frontend/pages/album/create/album_create_controller.dart';
import 'package:sesame_frontend/pages/album/create/album_create_page.dart';
import 'package:sesame_frontend/pages/album/list/album_list_controller.dart';
import 'package:sesame_frontend/pages/album/list/album_list_page.dart';
import 'package:sesame_frontend/pages/login/login_controller.dart';
import 'package:sesame_frontend/pages/login/login_page.dart';
import 'package:sesame_frontend/pages/user/user_info_set_page.dart';

part 'routes.dart';

final appRoutes = [
  GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController()))),
  GetPage(
      name: AppRoutes.albumCreate,
      page: () => AlbumCreatePage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AlbumCreateController()))),
  GetPage(
      name: AppRoutes.albumList,
      page: () => const AlbumListPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AlbumListController()))),
  GetPage(
      name: AppRoutes.userInfoSet,
      page: () => UserInfoSetPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => UserInfoSetController(userInfo: Get.arguments)))),
];
