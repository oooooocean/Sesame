import 'package:get/get.dart';
import 'package:sesame_www/pages/home/home_page.dart';
import 'package:sesame_www/pages/home/home_page_controller.dart';

part 'routes.dart';

final appRoutes = [
  GetPage(
  name: AppRoutes.home,
  page: () => HomePage(),
  binding: BindingsBuilder(() => Get.lazyPut(() => HomePageController()))),
];