import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/pages/post/detail/views/comment_header.dart';
import 'package:sesame_frontend/pages/post/detail/views/post_comment_controller.dart';
import 'package:sesame_frontend/pages/post/detail/views/post_comment_page.dart';
import 'package:sesame_frontend/pages/post/detail/post_detail_controller.dart';
import 'package:sesame_frontend/pages/post/detail/views/post_favor_controller.dart';
import 'package:sesame_frontend/pages/post/detail/views/post_favor_page.dart';
import 'package:sesame_frontend/pages/post/views/post_tile.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PostDetailState();
}

class PostDetailState extends State<PostDetailPage> with SingleTickerProviderStateMixin, LoadImageMixin, ThemeMixin {
  late TabController _tabController;
  late SliverToBoxAdapter _content;
  late SliverPersistentHeader _commentHeader;
  late SmartRefresher _commentRefresher;
  late SmartRefresher _favorRefresher;
  final _commentView = const PostCommentView();
  final _favorView = const PostFavorView();

  PostDetailController get controller => Get.find<PostDetailController>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    controller.tabController = _tabController;
    _content = SliverToBoxAdapter(child: PostTile(post: controller.post, panel: false));
    _commentHeader = SliverPersistentHeader(
        pinned: true, delegate: CommentHeaderDelegate(tabController: _tabController, tapTab: controller.tapTab));
    final commentController = Get.find<PostCommentController>();
    _commentRefresher = SmartRefresher(
      enablePullUp: true,
      onRefresh: () => commentController.load(RefreshType.refresh),
      onLoading: () => commentController.load(RefreshType.loadMore),
      controller: commentController.refreshController,
      child: CustomScrollView(slivers: [_content, _commentHeader, _commentView]),
    );
    final favorController = Get.find<PostFavorController>();
    _favorRefresher = SmartRefresher(
      enablePullUp: true,
      onRefresh: () => favorController.load(RefreshType.refresh),
      onLoading: () => favorController.load(RefreshType.loadMore),
      controller: favorController.refreshController,
      child: CustomScrollView(slivers: [_content, _commentHeader, _favorView]),
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: TextButton.icon(
                onPressed: () {},
                icon: buildNetImage(controller.post.owner.thumbnailUrl),
                label: Text(controller.post.owner.nickname ?? ''))),
        body: SafeArea(
          child: GetBuilder<PostDetailController>(
            builder: (_) => _tabController.index == 0 ? _commentRefresher : _favorRefresher,
          ),
        ),
      );
}
