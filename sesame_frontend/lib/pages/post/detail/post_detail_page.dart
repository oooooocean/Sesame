import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/pages/post/detail/views/comment_header.dart';
import 'package:sesame_frontend/pages/post/detail/views/post_comment_page.dart';
import 'package:sesame_frontend/pages/post/detail/post_detail_controller.dart';
import 'package:sesame_frontend/pages/post/detail/views/post_favor_page.dart';
import 'package:sesame_frontend/pages/post/views/post_handler_tile.dart';
import 'package:sesame_frontend/pages/post/views/post_tile.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PostDetailState();
}

class PostDetailState extends State<PostDetailPage> with SingleTickerProviderStateMixin, LoadImageMixin, ThemeMixin {
  late TabController _tabController;

  PostDetailController get controller => Get.find<PostDetailController>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    controller.tabController = _tabController;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextButton.icon(
            onPressed: () {},
            icon: ClipOval(
                child: SizedBox(
                    width: 30, height: 30, child: buildNetImage(controller.data.avatarUrl, fit: BoxFit.cover))),
            label: Text(controller.data.owner.nickname ?? '', style: const TextStyle(color: Colors.white)),
          ),
        ),
        body: SafeArea(
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: GetBuilder<PostDetailController>(
                    builder: (_) => SmartRefresher(
                      enablePullUp: true,
                      onRefresh: () => controller.load(RefreshType.refresh),
                      onLoading: () => controller.load(RefreshType.loadMore),
                      controller: controller.refreshController,
                      child: CustomScrollView(controller: controller.scrollController, slivers: [
                        _content,
                        _commentHeader,
                        _tabController.index == 0 ? PostCommentView() : PostFavorView()
                      ]),
                    ),
                  ),
                ),
                GetBuilder<PostDetailController>(
                  id: 'handler',
                  builder: (_) => PostHandlerTile(onTap: controller.tapAction, hasFavor: controller.data.hasFavor),
                )
              ],
            ),
          ),
        ),
      );

  Widget get _content => SliverToBoxAdapter(child: PostTile(post: controller.data, panel: false));

  Widget get _commentHeader => SliverPersistentHeader(
      pinned: true, delegate: CommentHeaderDelegate(tabController: _tabController, tapTab: controller.tapTab));
}
