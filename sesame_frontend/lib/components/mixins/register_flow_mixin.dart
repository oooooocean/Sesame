import 'package:get/get.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:sesame_frontend/services/launch_service.dart';

mixin RegisterFlowMixin {
  bool nextRegisterStep() {
    final launch = Get.find<LaunchService>();

    if (launch.registerFlows.isEmpty) return false;

    launch.registerFlows.remove(Get.currentRoute);
    final next = launch.registerFlows.isNotEmpty ? launch.registerFlows.first : AppRoutes.scaffold;
    Get.offAllNamed(next);
    return true;
  }
}
