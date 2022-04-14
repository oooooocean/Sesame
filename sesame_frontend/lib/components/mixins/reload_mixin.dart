import 'package:get/get.dart';

mixin ReloadNotificationMixin {
  void notifyReload<T extends ReloadMixin>({String? tag}) {
    if (!Get.isRegistered<T>(tag: tag)) return;
    Get.find<T>(tag: tag).reload();
  }
}

mixin ReloadMixin {
  void reload() {}
}