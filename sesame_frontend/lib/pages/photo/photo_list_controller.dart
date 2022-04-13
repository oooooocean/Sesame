import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/refresh_mixin.dart';
import 'package:sesame_frontend/models/album.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/models/photo.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PhotoListController extends GetxController with RefreshMixin<Photo>, NetMixin {
  final Album album;

  PhotoListController() : album = Get.arguments;

  void onTap(int index) {}

  void add() async {
    const config = AssetPickerConfig(maxAssets: 1, requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    EasyLoading.show();
    postFormData('album/${album.id}/photo', {}, results,
        (data) => (data as List<dynamic>).map((e) => Photo.fromJson(e)).toList()).then((value) {
      items.insertAll(0, value);
      update();
    }).whenComplete(() => EasyLoading.dismiss());
  }

  void load(RefreshType refreshType) {
    startRefresh(refreshType).then((value) => update());
  }

  @override
  Future<PagingData<Photo>> get refreshRequest => get('album/${album.id}/photo', {'page': paging.current.toString()},
      (data) => PagingData.fromJson(data, (json) => Photo.fromJson(json)));
}
