import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/pages/photo/photo_list_controller.dart';
import 'package:sesame_frontend/pages/photo/views/photo_thumbnail_tile.dart';

class PhotoListPage extends GetView<PhotoListController> {
  final crossAxisCount = 4;
  final space = 4.0;
  final pattern = const [QuiltedGridTile(2, 2), QuiltedGridTile(1, 1), QuiltedGridTile(1, 1), QuiltedGridTile(1, 2)];
  final double itemMaxWidth;

  PhotoListPage({Key? key})
      : itemMaxWidth = Get.width / 2.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.album.name),
        actions: [IconButton(onPressed: controller.add, icon: const Icon(Icons.add, color: Colors.white))],
      ),
      body: GetBuilder<PhotoListController>(
        builder: (_) => SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: true,
          onRefresh: () => controller.load(RefreshType.refresh),
          onLoading: () => controller.load(RefreshType.loadMore),
          child: GridView.custom(
            padding: EdgeInsets.all(space),
            gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: space,
                crossAxisSpacing: space,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: pattern),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) => PhotoThumbnailTile(
                  photo: controller.items[index],
                  onTap: () => controller.onTap(index),
                  width: itemMaxWidth,
                  height: itemMaxWidth),
              childCount: controller.items.length
            ),
          ),
        ),
      ),
    );
  }
}
