import 'package:get/get.dart';

const smallScreenStandard = 800.0;

mixin ThemeMixin {
  bool get isSmallScreen => Get.width <= smallScreenStandard;
  double get maxFont => isSmallScreen ? 20.0 : 40.0;
  double get appBarTitleFont => isSmallScreen ? 16.0 : 30.0;
  double get smallFont => isSmallScreen ? 13.0 : 15.0;
  double get defaultFont => isSmallScreen ? 14.0 : 20.0;
}