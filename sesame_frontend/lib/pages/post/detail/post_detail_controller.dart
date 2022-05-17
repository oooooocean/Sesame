import 'package:flutter/material.dart' show ScrollController, TabController;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sesame_frontend/components/utils/event_bust_util.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/models/post.dart';
import 'package:sesame_frontend/models/post_comment.dart';
import 'package:sesame_frontend/models/post_favor.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:sesame_frontend/pages/post/detail/post_comment_edit_page.dart';
import 'package:sesame_frontend/pages/post/views/post_handler_tile.dart';
import 'package:sesame_frontend/route/pages.dart';

import 'package:sesame_frontend/components/utils/event_bust_util.dart';

class PostDetailController extends GetxController with NetMixin {
  final Post data;
  late TabController tabController;
  final refreshController = RefreshController(initialRefresh: true);
  final scrollController = ScrollController();
  final commentPaging = PagingData<PostComment>(0, []);
  final favorPaging = PagingData<PostFavor>(0, []);
  final List<double> _offsets = [0, 0];

  List<PostComment> get comments => commentPaging.items;

  List<PostFavor> get favors => favorPaging.items;

  PostDetailController() : data = Get.arguments;

  void tapTab() {
    // 保存
    _offsets[tabController.previousIndex] = scrollController.offset;
    // 恢复
    scrollController.jumpTo(_offsets[tabController.index]);
    resetRefreshFooter();
    update();
  }

  void tapAction(PostHandlerType type) {
    switch (type) {
      case PostHandlerType.comment:
        _comment();
        break;
      case PostHandlerType.favor:
        _favor();
        break;
    }
  }

  void _favor() async {
    final url = 'post/${data.id}/favor';
    Future<bool> api = data.hasFavor
        ? delete(url, {}, (data) => data)
        : post(url, {}, (data) => data);
    request<bool>(api, success: (isSuccess) {
      if (!isSuccess) return;
      data.hasFavor = !data.hasFavor;
      update(['handler']);
    });
  }

  void _comment() async {
    final result = await Get.toNamed(AppRoutes.postComment);
    if (result == null || result.isEmpty) return;
    final api = post('post/${data.id}/comment', {'comment': result},
        (data) => PostComment.fromJson(data));
    request<PostComment>(api, success: (comment) {
      comments.insert(0, comment);
      update();
    });
    EventBusUtil.getInstance().fire(PageAction(true));
  }

  void load(RefreshType refreshType) {
    commentPaging.prepare(RefreshType.refresh);
    favorPaging.prepare(RefreshType.refresh);
    if (refreshType == RefreshType.refresh) {
      refreshLoad();
    } else {
      loadMore();
    }
  }

  void loadMore() {
    api.then((value) {
      paging.merge(value, RefreshType.loadMore);
      resetRefreshFooter();
      update();
    });
  }

  void refreshLoad() {
    Future.wait([commentRequest, favorRequest]).then((values) {
      commentPaging.merge(
          values[0] as PagingData<PostComment>, RefreshType.refresh);
      favorPaging.merge(
          values[1] as PagingData<PostFavor>, RefreshType.refresh);
      refreshController.refreshCompleted(resetFooterState: true);
      if (commentPaging.isEnd && isComment) refreshController.loadNoData();
      if (favorPaging.isEnd && !isComment) refreshController.loadNoData();
      update();
    });
  }

  void resetRefreshFooter() {
    final paging = this.paging;
    paging.isEnd
        ? refreshController.loadNoData()
        : refreshController.loadComplete();
  }

  void toUserTimeline(int userId) {}

  bool get isComment => tabController.index == 0;

  PagingData get paging => isComment ? commentPaging : favorPaging;

  Future get api => isComment ? commentRequest : favorRequest;

  Future<PagingData<PostComment>> get commentRequest => get(
      'post/${Get.find<PostDetailController>().data.id}/comment',
      {'page': commentPaging.current.toString()},
      (data) =>
          PagingData.fromJson(data, (json) => PostComment.fromJson(json)));

  Future<PagingData<PostFavor>> get favorRequest => get(
      'post/${Get.find<PostDetailController>().data.id}/favor',
      {'page': favorPaging.current.toString()},
      (data) => PagingData.fromJson(data, (json) => PostFavor.fromJson(json)));
}
