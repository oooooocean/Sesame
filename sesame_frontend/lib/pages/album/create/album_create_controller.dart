import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/models/album.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AlbumCreateController extends GetxController with NetMixin {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  AssetEntity? cover;

  bool get shouldNext => cover != null && titleController.text.isNotEmpty;

  void choseCover() async {
    final config = AssetPickerConfig(
        selectedAssets: cover != null ? [cover!] : null, maxAssets: 1, requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    cover = results.first;
    update(['cover', 'next']);
  }

  void create() async {
    List<AssetEntity> image = cover != null ? [cover!] : [];
    await request(
        postFormData('album/', {'name': titleController.text, 'description': descriptionController.text}, image,
            (data) => Album.fromJson(data)),
        success: (album) => EasyLoading.showSuccess('Success'));
  }
}
