import 'package:get/get.dart';
import 'package:sesame_frontend/models/photo.dart';
import 'package:sesame_frontend/pages/album/create/album_create_controller.dart';
import 'package:sesame_frontend/pages/album/create/album_create_page.dart';
import 'package:sesame_frontend/pages/album/list/album_list_controller.dart';
import 'package:sesame_frontend/pages/album/list/album_list_page.dart';
import 'package:sesame_frontend/pages/login/login_controller.dart';
import 'package:sesame_frontend/pages/login/login_page.dart';
import 'package:sesame_frontend/pages/photo/photo_browser_controller.dart';
import 'package:sesame_frontend/pages/photo/photo_browser_page.dart';
import 'package:sesame_frontend/pages/photo/photo_list_controller.dart';
import 'package:sesame_frontend/pages/photo/photo_list_page.dart';
import 'package:sesame_frontend/pages/photo/photo_select_controller.dart';
import 'package:sesame_frontend/pages/photo/photo_select_page.dart';
import 'package:sesame_frontend/pages/post/create/post_create_controller.dart';
import 'package:sesame_frontend/pages/post/create/post_create_page.dart';
import 'package:sesame_frontend/pages/post/detail/post_comment_edit_page.dart';
import 'package:sesame_frontend/pages/post/detail/post_detail_controller.dart';
import 'package:sesame_frontend/pages/post/detail/post_detail_page.dart';
import 'package:sesame_frontend/pages/post/list/post_list_controller.dart';
import 'package:sesame_frontend/pages/post/list/post_list_page.dart';
import 'package:sesame_frontend/pages/scaffold/scaffold_controller.dart';
import 'package:sesame_frontend/pages/scaffold/scaffold_page.dart';
import 'package:sesame_frontend/pages/user/user_info_controller.dart';
import 'package:sesame_frontend/pages/user/user_info_set_page.dart';
import 'package:sesame_frontend/pages/pet/pet_info_page.dart';
import 'package:sesame_frontend/services/launch_service.dart';

part 'routes.dart';

final appRoutes = [
  GetPage(
      name: AppRoutes.petInfo,
      page: () => PetInfoPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PetInfoController()))),
  GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController()))),
  GetPage(
      name: AppRoutes.albumCreate,
      page: () => AlbumCreatePage(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => AlbumCreateController()))),
  GetPage(
      name: AppRoutes.albumList,
      page: () => const AlbumListPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AlbumListController());
        Get.lazyPut(() => UserInfoController());
      })),
  GetPage(
      name: AppRoutes.userInfoSet,
      page: () => UserInfoSetPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => UserInfoSetController(
          userInfo: Get.arguments ?? Get.find<LaunchService>().user!.info)))),
  GetPage(
      name: AppRoutes.photoList,
      page: () => const PhotoListPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PhotoListController()))),
  GetPage(
      opaque: false,
      transition: Transition.noTransition,
      showCupertinoParallax: false,
      name: AppRoutes.photoBrowser,
      page: () => const PhotoBrowserPage(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => PhotoBrowserController()))),
  GetPage<List<Photo>>(
      name: AppRoutes.photoSelect,
      page: () => PhotoSelectPage(),
      fullscreenDialog: true,
      binding:
          BindingsBuilder(() => Get.lazyPut(() => PhotoSelectController()))),
  GetPage(
      name: AppRoutes.postCreate,
      page: () => PostCreatePage(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => PostCreateController()))),
  GetPage(
      name: AppRoutes.postList,
      page: () => const PostListPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PostListController()))),
  GetPage(
      name: AppRoutes.scaffold,
      page: () => const ScaffoldPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AlbumListController());
        Get.lazyPut(() => PostListController());
        Get.lazyPut(() => ScaffoldController());
        Get.lazyPut(() => UserInfoController());
      })),
  GetPage(
      name: AppRoutes.postDetail,
      page: () => const PostDetailPage(),
      binding: BindingsBuilder(() {
        Get.put(PostDetailController());
      })),
  GetPage<String>(
      name: AppRoutes.postComment,
      opaque: false,
      popGesture: false,
      fullscreenDialog: true,
      page: () => PostCommentEditPage()),
];
