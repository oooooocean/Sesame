import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/reload_mixin.dart';
import 'package:sesame_frontend/models/album.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/route/pages.dart';

class AlbumListController extends GetxController
    with NetMixin, StateMixin<List<Album>>, ReloadMixin {
  List<Album> get albums => state!;

  void selected(Album album) {
    // TODO: 调试用，跳转宠物信息设置页面
    Get.toNamed(AppRoutes.petInfo);
    // Get.toNamed(AppRoutes.photoList, arguments: album);
  }

  @override
  void onReady() {
    load();
    super.onReady();
  }

  @override
  void reload() => load();

  void load() async {
    change(null, status: RxStatus.loading());
    final api = get(
        'album/',
        {'user_id': (await User.cached())?.id.toString()},
        (data) =>
            (data as List<dynamic>).map((e) => Album.fromJson(e)).toList());
    api.then((value) {
      change(value, status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
