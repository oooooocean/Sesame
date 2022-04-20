import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/refresh_mixin.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/models/post.dart';
import 'package:sesame_frontend/net/net_mixin.dart';

class PostListController extends GetxController with NetMixin, RefreshMixin<Post> {
  void onTapAvatar(Post post) {}

  void onTapPhoto(Post post, int photoIndex) {}

  void load(RefreshType refreshType) {
    startRefresh(refreshType).then((value) => update());
  }

  @override
  Future<PagingData<Post>> get refreshRequest => get('posts/', {'page': paging.current.toString()}, (data) => PagingData.fromJson(data, (json) => Post.fromJson(json)));
}