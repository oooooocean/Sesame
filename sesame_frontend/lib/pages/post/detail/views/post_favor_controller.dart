import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/post_handler_mixin.dart';
import 'package:sesame_frontend/components/mixins/refresh_mixin.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/models/post_favor.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/pages/post/detail/post_detail_controller.dart';

class PostFavorController extends GetxController with PostHandlerMixin, RefreshMixin<PostFavor>, NetMixin {
  void load(RefreshType refreshType) {
    startRefresh(refreshType).then((value) => update());
  }

  @override
  Future<PagingData<PostFavor>> get refreshRequest => get('post/${Get.find<PostDetailController>().post.id}/favor',
      {'page': paging.current.toString()}, (data) => PagingData.fromJson(data, (json) => PostFavor.fromJson(json)));
}