import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/refresh_mixin.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/models/photo.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/route/pages.dart';

class PhotoSelectConfiguration {
  final List<int> lastSelected;
  final int limit;

  PhotoSelectConfiguration({required this.lastSelected, required this.limit});
}

class PhotoSelectController extends GetxController with RefreshMixin<Photo>, NetMixin {
  final PhotoSelectConfiguration config;

  PhotoSelectController() : config = Get.arguments ?? [];

  void onTap(int index) {
    Get.toNamed(AppRoutes.photoBrowser, arguments: [items, index]);
  }

  void willSelect(int index) {
    final photo = items[index];
    if (!photo.selected && selectedCount == config.limit) {
      EasyLoading.showToast('最多选择${config.limit}张图片');
      return;
    }
    items[index].selected = !items[index].selected;
    update([items[index].name, 'save']);
  }

  void load(RefreshType refreshType) {
    startRefresh(refreshType).then((value) => update());
  }

  @override
  Future<PagingData<Photo>> get refreshRequest => get('photos/', {'page': paging.current.toString()},
          (data) => PagingData.fromJson(data, (json) => Photo.fromJson(json))).then((value) {
        for (var element in value.items) {
          if (config.lastSelected.contains(element.id)) element.selected = true;
        }
        return value;
      });

  int get selectedCount => items.where((element) => element.selected).length;
}
