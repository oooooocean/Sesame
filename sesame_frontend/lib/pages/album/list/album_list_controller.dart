import 'package:get/get.dart';
import 'package:sesame_frontend/models/album.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/net/net_mixin.dart';

class AlbumListController extends GetxController with NetMixin, StateMixin<List<Album>> {
  List<Album> get albums => state!;

  void selected(Album album) {}

  @override
  void onReady() {
    load();
    super.onReady();
  }

  void load() async {
    change(null, status: RxStatus.loading());
    final api = get('album/', {'user_id': (await User.cached())?.id.toString()},
        (data) => (data as List<dynamic>).map((e) => Album.fromJson(e)).toList());
    api.then((value) {
      change(value, status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
