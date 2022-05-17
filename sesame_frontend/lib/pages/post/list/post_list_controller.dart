import 'dart:ffi';

import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/refresh_mixin.dart';
import 'package:sesame_frontend/components/utils/event_bust_util.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/models/post.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/route/pages.dart';
import 'package:sesame_frontend/components/utils/event_bust_util.dart';

class PostListController extends GetxController
    with NetMixin, RefreshMixin<Post> {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    EventBusUtil.getInstance().on<PageAction>().listen((event) {
      load(RefreshType.refresh);
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    EventBusUtil.getInstance().destroy();
  }

  void onTapAvatar(Post post) {}

  void onTapPhoto(Post post, int photoIndex) {
    Get.toNamed(AppRoutes.photoBrowser, arguments: [
      post.photos,
      photoIndex,
      (photo) => post.id.toString() + photo.name
    ]);
  }

  void onTap(Post post) {
    Get.toNamed(AppRoutes.postDetail, arguments: post);
  }

  void load(RefreshType refreshType) {
    startRefresh(refreshType).then((value) => update());
  }

  @override
  Future<PagingData<Post>> get refreshRequest => get(
      'posts/',
      {'page': paging.current.toString()},
      (data) => PagingData.fromJson(data, (json) => Post.fromJson(json)));
}
