import 'package:get/get.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/services/launch_service.dart';

class UserInfoController extends GetxController {
  UserInfo get info => Get.find<LaunchService>().user!.info!;
}