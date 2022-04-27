import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/post_handler_mixin.dart';
import 'package:sesame_frontend/components/mixins/refresh_mixin.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/models/post_comment.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/pages/post/detail/post_detail_controller.dart';

class PostCommentController extends GetxController with RefreshMixin<PostComment>, NetMixin, PostHandlerMixin {
  void load(RefreshType refreshType) {
    startRefresh(refreshType).then((value) => update());
  }

  @override
  Future<PagingData<PostComment>> get refreshRequest => get('post/${Get.find<PostDetailController>().post.id}/comment',
      {'page': paging.current.toString()}, (data) => PagingData.fromJson(data, (json) => PostComment.fromJson(json)));
}
