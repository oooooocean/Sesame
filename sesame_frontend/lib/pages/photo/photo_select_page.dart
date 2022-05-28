import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/pages/photo/photo_select_controller.dart';
import 'package:sesame_frontend/pages/photo/views/photo_thumbnail_tile.dart';

class PhotoSelectPage extends GetView<PhotoSelectController> with ThemeMixin {
  PhotoSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chose photos'),
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close)),
        actions: [_completionItem],
      ),
      body: GetBuilder<PhotoSelectController>(
        builder: (_) => SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: true,
          onRefresh: () => controller.load(RefreshType.refresh),
          onLoading: () => controller.load(RefreshType.loadMore),
          child: _girdItem,
        ),
      ),
    );
  }

  Widget get _completionItem => GetBuilder<PhotoSelectController>(
      id: 'save',
      builder: (_) {
        final enable = controller.items.any((element) => element.selected);
        return TextButton(
            child:
                Text('完成(${controller.selectedCount})', style: TextStyle(color: enable ? Colors.white : Colors.grey)),
            onPressed:
                enable ? () => Get.back(result: controller.items.where((element) => element.selected).toList()) : null);
      });

  Widget get _girdItem => GridView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: controller.items.length,
        itemBuilder: (_, index) => GetBuilder<PhotoSelectController> (
          id: controller.items[index].name,
          builder: (_) => PhotoThumbnailTile(
              photo: controller.items[index],
              onTap: () => controller.onTap(index),
              onTapCorner: () => controller.willSelect(index)),
        ),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4),
      );
}
